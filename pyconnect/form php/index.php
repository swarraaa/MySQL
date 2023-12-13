<!DOCTYPE html>
<html>
<head>
    <title>Form Example</title>
</head>
<body>
    <h1>Submit Form</h1>
    <form action="" method="POST">
        <label for="name">Name:</label><br>
        <input type="text" id="name" name="name"><br>

        <label for="subject">Subject:</label><br>
        <input type="text" id="subject" name="subject"><br>

        <input type="submit" value="Submit">
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $servername = "mysql-container";
        $username = "root";
        $password = "password";
        $dbname = "Details";

        $name = $_POST["name"];
        $subject = $_POST["subject"];

        // Create a connection to MySQL
        $conn = new mysqli($servername, $username, $password, $dbname);

        // Check connection
        if ($conn->connect_error) {
            die("Connection failed: " . $conn->connect_error);
        }

        try {
            // Create the 'users' table if it doesn't exist
            $createTableQuery = "CREATE TABLE IF NOT EXISTS users (
                id INT AUTO_INCREMENT PRIMARY KEY,
                name VARCHAR(255) NOT NULL,
                subject VARCHAR(255) NOT NULL
            )";
            if ($conn->query($createTableQuery) === TRUE) {
                echo "Table created successfully.<br>";
            } else {
                echo "Error creating table: " . $conn->error . "<br>";
            }

            // Insert data into the 'users' table
            $insertQuery = "INSERT INTO users (name, subject) VALUES ('$name', '$subject')";
            if ($conn->query($insertQuery) === TRUE) {
                echo "Data inserted successfully.";
            } else {
                echo "Error inserting data: " . $conn->error . "<br>";
            }
        } catch (Exception $e) {
            echo "Error: " . $e->getMessage();
        }

        $conn->close(); // Close the connection
    }
    ?>
</body>
</html>
