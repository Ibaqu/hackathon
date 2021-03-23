import ballerina/io;
import ballerina/sql;

public function addContact() {
    io:println("[MYSQL_CLIENT] [AddContact] Adding contact to database");

    string query = "INSERT INTO Contact (Name, Address, Phone, Email) VALUES ('Aquib', '160/43', 2213445, 'aquib.zt@gmail.com')";
    sql:ExecutionResult result = checkpanic dbClient->execute(query);
}

public function updateContact() {
    io:println("[MYSQL_CLIENT] [updateContact] Updating contact in database");

    string query = "UPDATE Contact SET Name = 'Amir' WHERE ID = 2";

    sql:ExecutionResult result = checkpanic dbClient->execute(query);
}

public function deleteContact() {
    io:println("[MYSQL_CLIENT] [deleteContact] Deleting contact from database");

    string query = "DELETE FROM Contact WHERE `ID` = 2";
    sql:ExecutionResult result = checkpanic dbClient->execute(query);
}

public function listContacts() {
    io:println("[MYSQL_CLIENT] [listContact] Listing contacts in database");

    // Query
    string query = "SELECT * FROM Contact";
    stream<record{}, error> resultStream = dbClient->query(query);

    // Display information
    io:println();
    error? e = resultStream.forEach(
        function(record {} result) {
            io:println("\tContact details : ", result);
        }
    );
    io:println();

}

public function createContactTable() {
    io:println("[MYSQL_CLIENT] [createContactTable] Creating Contact table if doesnt exist");

    // Query
    string query = "CREATE TABLE IF NOT EXISTS Contact (ID int(11) PRIMARY KEY NOT NULL auto_increment, Name varchar(60), Address varchar(100), Phone int(10), Email varchar(30))";
    sql:ExecutionResult result = checkpanic dbClient->execute(query);
}