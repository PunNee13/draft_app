from email.policy import default
from http import client
from multiprocessing import connection
from flask_wtf import FlaskForm
from wtforms import SubmitField, SelectField, validators
from wtforms.fields import IntegerField
from wtforms.widgets import NumberInput
from google.cloud import bigquery

# client = bigquery.Client()

# connection_query = (
#     'SELECT connection FROM `gaie-0008052023.sm_pp.connections`'
# )

# part_query = (
#     'SELECT part FROM `gaie-0008052023.sm_pp.parts`'
# )

# tool_query = (
#     'SELECT tool FROM `gaie-0008052023.sm_pp.tools`'
# )

# connections = client.query(connection_query).to_dataframe()
# parts = client.query(part_query).to_dataframe()
# tools = client.query(tool_query).to_dataframe()


class InputForm(FlaskForm):
    # connection = SelectField(
    #     'Connection',
    #     validators=[validators.InputRequired()],
    #     choices=connections.connection.to_list(), 
    #     default=1
    # )
    print("Connections read")
    # part = SelectField(
    #     'Part',
    #     validators=[validators.InputRequired()],
    #     choices=parts.part.to_list(),
    #     default=1
    # )
    print("Parts read")
    # tool = SelectField(
    #     'Tool',
    #     validators=[validators.InputRequired()],
    #     choices=['None', ] + tools.tool.to_list(),
    #     default=1
    # )
    print("Connections Tools")
    repetition = IntegerField(
        'Repetitions',
        validators=[validators.InputRequired()],
        widget=NumberInput(min=1),
        default=1
    )
    submit = SubmitField('Submit')
