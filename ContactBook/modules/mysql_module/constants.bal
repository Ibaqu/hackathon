import ballerinax/mysql;

string host = "localhost";
string user = "root";
string password = "root";
int port = 3306;

string database = "contacts";

public type Contact record {|
    string Name;
    string Address;
    string Phone;
    string Email;
|};

// Create DBClient
mysql:Client dbClient = checkpanic new (host, user, password, database, port);

