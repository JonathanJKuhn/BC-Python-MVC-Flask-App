from flask import render_template,redirect,request
from flask_app import app
from flask_app.controllers import burgers

if __name__=="__main__":
    app.run(debug=True)