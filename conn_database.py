# Necessary library for connect database
import pandas as pd
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError
from clean_data import trans_df

# Database configuration
host_db = "" # Input your host
port_db =    # Input your port
user_db = ""   # Input your username
password_db =  # Input your password
scmaname_db = "frauds_db"
tablname_db = "transactions"
insert_db = pd.DataFrame(trans_df)

# Database connection (MySQL)
def conn_database(host, port, username, password, database):
    conn_engine = create_engine(f"mysql+pymysql://{username}:{password}@{host}:{port}/{database}")
    try:
        print("\nProcess: database connection ...")
        conn_engine.connect()
    except SQLAlchemyError as errors:
        print(f"Connect status -> error: {errors}")
        return None
    except Exception as e:
        print(f"Connect status -> message error: {e}")
        return None
    else:
        print("Connect status -> successful")
        return conn_engine

# Insert data to database (MySQL)
def insert_data(dataframe: pd.DataFrame, table: str):
    conn_mysql = conn_database(host_db, port_db, user_db, password_db, scmaname_db)
    if conn_mysql is None:
        print("Please!! verify database configuration again")
    else:
        try:
            print("\nProcess: Insert data to database ...")
            print(f"Insert status -> data dimension input: {dataframe.shape}")
            dataframe.to_sql(table, con=conn_mysql, if_exists="append", index=False)
        except Exception as e:
            print(f"Insert status -> message error: {e} ...")
        else:
            print("Insert status -> successful")

insert_data(insert_db, tablname_db)
