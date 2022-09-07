from flask_app.config.mysqlconnection import connectToMySQL
# We will need to import burger.py to access the class
from flask_app.models import burger
class Topping:
    def __init__( self , db_data ):
        self.id = db_data['id']
        self.topping_name = db_data['topping_name']
         # we need have a list in case we want to show which burgers are related to the topping.
        self.on_burgers = []
        self.created_at = db_data['created_at']
        self.updated_at = db_data['updated_at']

    @classmethod
    def save( cls , data ):
        query = "INSERT INTO toppings ( topping_name, created_at , updated_at ) VALUES (%(topping_name)s,NOW(),NOW());"
        return connectToMySQL('burgers').query_db(query, data)
    # This method will retrieve the specific topping along with all the burgers associated with it.
    @classmethod
    def get_topping_with_burgers( cls , data ):
        query = "SELECT * FROM toppings LEFT JOIN add_ons ON add_ons.topping_id = toppings.id LEFT JOIN burgers ON add_ons.burger_id = burgers.id WHERE toppings.id = %(id)s;"
        results = connectToMySQL('burgers').query_db( query , data )
        # results will be a list of topping objects with the burger attached to each row. 
        topping = cls( results[0] )
        for row_from_db in results:
            # Now we parse the topping data to make instances of toppings and add them into our list.
           burger_data = {
                "id" : row_from_db["burgers.id"],
                "name" : row_from_db["name"],
                "bun" : row_from_db["bun"],
                "calories" : row_from_db["calories"],
                "created_at" : row_from_db["toppings.created_at"],
                "updated_at" : row_from_db["toppings.updated_at"]
           }
           topping.on_burgers.append( burger.Burger( burger_data ) )
        return topping

