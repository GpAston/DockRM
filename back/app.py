from flask import Flask, render_template, request
import requests
from flaskext.mysql import MySQL
import hashlib

monApp = Flask(__name__)
monApp.config.from_object( 'config' )

mysql = MySQL()
mysql.init_app( monApp )
connector = mysql.connect()
cursor = connector.cursor()
mavar = ({
    "nom":"pagies",
    "prenom":"leo",
    "afficher":"oui"
},{
    "nom":"leman",
    "prenom":"maxence",
    "afficher":"non"
})

def hash_fonct(passwords):
    var1 = hashlib.sha512(passwords.encode( "utf-8" ))
    hashcode = var1.hexdigest()
    return(hashcode)

@monApp.route( "/" )
def fhello():
    return render_template("index.html", datas=mavar)

    
    
    
