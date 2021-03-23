import ballerina/io;
import ballerina/sql;

public function addContact(Contact contact) {
    io:println("[MYSQL_CLIENT] [AddContact] Adding contact to database");

    sql:ParameterizedQuery insertQuery = 
        `INSERT INTO Contact (Name, Address, Phone, Email)
        VALUES (${contact.Name}, ${contact.Address}, ${contact.Phone}, ${contact.Email})`;

    sql:ExecutionResult result = checkpanic dbClient->execute(insertQuery);
}

public function updateContact(Contact contact, int ID) {
    io:println("[MYSQL_CLIENT] [updateContact] Updating contact in database");

    sql:ParameterizedQuery updateQuery = 
        `UPDATE Contact
        SET Name = ${contact.Name}, Address = ${contact.Address}, Phone = ${contact.Phone}, Email = ${contact.Email}
        WHERE ID = ${ID}`;

    sql:ExecutionResult result = checkpanic dbClient->execute(updateQuery);
}

public function deleteContact(int ID) {
    io:println("[MYSQL_CLIENT] [deleteContact] Deleting contact from database");

    sql:ParameterizedQuery deleteQuery = `
        DELETE FROM Contact WHERE ID = ${ID}`;

    sql:ExecutionResult result = checkpanic dbClient->execute(deleteQuery);
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