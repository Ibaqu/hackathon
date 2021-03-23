import ballerina/io;
import ballerina/sql;

public function addContact(Contact contact) returns error? {
    io:println("[MYSQL_CLIENT] [addContact] Adding contact to database");

    string regex = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$";

    if (validate(contact)) {
        sql:ParameterizedQuery insertQuery = `INSERT INTO Contact (Name, Address, Phone, Email)
        VALUES (${
        contact.Name}, ${contact.Address}, ${contact.Phone}, ${contact.Email})`;

        sql:ExecutionResult|error result = dbClient->execute(insertQuery);

        if (result is error) {
            return result;
        }

    } else {
        io:println("[MYSQL_CLIENT] [addContact] Regex validation failed");
    }
}

public function updateContact(Contact contact, int ID) returns error? {
    io:println("[MYSQL_CLIENT] [updateContact] Updating contact in database");

    if (validate(contact)) {
        sql:ParameterizedQuery updateQuery = `UPDATE Contact
        SET Name = ${contact.Name}, Address = ${contact.
        Address}, Phone = ${contact.Phone}, Email = ${contact.Email}
        WHERE ID = ${ID}`;

        sql:ExecutionResult|error result = dbClient->execute(updateQuery);

        if (result is error) {
            return result;
        }

    } else {
        io:println("[MYSQL_CLIENT] [updateContact] Regex validation failed");
    }
}

public function deleteContact(int ID) returns error? {
    io:println("[MYSQL_CLIENT] [deleteContact] Deleting contact from database");

    sql:ParameterizedQuery deleteQuery = `
        DELETE FROM Contact WHERE ID = ${ID}`;
    sql:ExecutionResult|error result = dbClient->execute(deleteQuery);

    if (result is error) {
        return result;
    }
}

public function listContacts() {
    io:println("[MYSQL_CLIENT] [listContact] Listing contacts in database");

    // Query
    string query = "SELECT * FROM Contact";
    stream<record { }, error> resultStream = dbClient->query(query);

    // Display information
    io:println();
    error? e = resultStream.forEach(function(record { } result) {
                                        io:println("\tContact details : ", result);
                                    });
    io:println();
}

public function createContactTable() returns error? {
    io:println("[MYSQL_CLIENT] [createContactTable] Creating Contact table if doesnt exist");

    // Query
    string query = "CREATE TABLE IF NOT EXISTS Contact (ID int(11) PRIMARY KEY NOT NULL auto_increment, Name varchar(60), Address varchar(100), Phone varchar(15), Email varchar(30))";
    sql:ExecutionResult|error result = dbClient->execute(query);

    if (result is error) {
        return result;
    }
}
