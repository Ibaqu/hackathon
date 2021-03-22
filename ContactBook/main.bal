import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;


public function main() {

    // SQL Information
    string host = "localhost";
    string user = "root";
    string password = "root";
    int port = 3306;

    // Database
    string database = "contacts";

    io:println("MYSQL client created");
    mysql:Client dbClient = checkpanic new (host, user, password, database, port);

    // Create table query
    string query = "CREATE TABLE Test(Name varchar(20), ID int)";

    // Execute query
    sql:ExecutionResult result = checkpanic dbClient->execute(query);

    io:print("Affected Row count : " , result.affectedRowCount);

    checkpanic dbClient.close();
}
