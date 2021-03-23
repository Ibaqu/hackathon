import ContactBook.mysql_module;
import ballerina/http;

service http:Service /contacts_service on new http:Listener(9090) {

    resource function get listContacts(http:Request req) returns http:Response {
        mysql_module:listContacts();

        http:Response response = new;
        response.statusCode =  200;
        return response;
    }

    resource function post addContact(@http:Payload json payload) returns http:Response {
        mysql_module:Contact|error contact = payload.cloneWithType(mysql_module:Contact);

        http:Response response = new;

        if (contact is mysql_module:Contact) {
            mysql_module:addContact(contact);
            response.statusCode = 200;
        } else {
            response.statusCode = 500;
        }

        return response;
    }

    resource function post updateContact(@http:Payload json payload) returns http:Response {
        mysql_module:Contact|error contactUpdated1 = payload.cloneWithType(mysql_module:Contact);

        http:Response response = new;

        if (contactUpdated1 is mysql_module:Contact) {
            mysql_module:updateContact(contactUpdated1, 3);
            response.statusCode = 200;
        } else {
            response.statusCode = 500;
        }

        return response;
    }

    resource function post deleteContact/[int ID](http:Request request) returns http:Response {

        mysql_module:deleteContact(ID);

        http:Response response = new;
        response.statusCode = 200;
        return response;
    }

}
