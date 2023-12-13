import mysql.connector

# Define the connection parameters
config = {
    "user": "youruser",
    "password": "yourpassword",
    "host": "localhost",
    "database": "yourdb",
}

# Create a connection to the MySQL server
conn = mysql.connector.connect(**config)

# Create a cursor to interact with the database
cursor = conn.cursor()

# Example: Execute a SQL query
cmd = "SELECT * FROM your_table_name"
cursor.execute(cmd)

# Fetch and print results
for row in cursor.fetchall():
    print(row)

# Example: Insert data into the table
insert_cmd = "INSERT INTO your_table_name (name, hobby) VALUES (%s, %s)"
data_to_insert = [
    ("John", "Cycling"),
    ("Jane", "Swimming"),
    ("Bob", "Gaming"),
]

cursor.executemany(insert_cmd, data_to_insert)
conn.commit()

# Example: Execute a SQL query
cmd = "SELECT * FROM your_table_name"
cursor.execute(cmd)

# Fetch and print results
for row in cursor.fetchall():
    print(row)

# Close cursor and connection
cursor.close()
conn.close()
