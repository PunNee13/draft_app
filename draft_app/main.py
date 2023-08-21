import os
from flask import Flask, request, render_template
from forms import InputForm

import pandas as pd
from google.auth import default
import vertexai
from vertexai.preview.language_models import ChatModel

app = Flask(__name__)
# app.config['SECRET_KEY'] = "8c76c624141d11ee831c42bb11ccffe5"

credentials, _ = default(
    scopes=['https://www.googleapis.com/auth/cloud-platform']
)

vertexai.init(
    project="gaie-0008052023",
    location="us-central1",
    credentials=credentials
)
chat_model = ChatModel.from_pretrained("chat-bison@001")
parameters = {
    "temperature": 0.2,
    "max_output_tokens": 1024,
    "top_p": 0.8,
    "top_k": 40
}


@app.route('/')
def about():
    return render_template("about.html")


@app.route('/reset', methods=['GET', 'POST'])
def reset():
    print("Inside reset")
    return render_template("run.html",
                           text_polishing_input="",
                           text_polishing_output="")


@app.route('/submit', methods=['GET', 'POST'])
def submit():
    text_polishing_input = request.form['text_polishing_input']
    text_polishing_context = request.form['text_polishing_context']    
    print(text_polishing_input)
    chat = chat_model.start_chat(context=text_polishing_context,**parameters)
    print("Chat session started")
    text_polishing_output = chat.send_message(text_polishing_input)
    print("Chat Desc request/response") 
    print(text_polishing_output)
    return render_template('run.html', 
                           text_polishing_context=text_polishing_context,
                           text_polishing_input=text_polishing_input, 
                           text_polishing_output=text_polishing_output
                           )

@app.route("/run", methods=["GET", "POST"])
def run():
    return render_template('run.html')

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=int(os.environ.get("PORT", 8080)))
