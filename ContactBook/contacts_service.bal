import ContactBook.mysql_module;
import ballerina/http;

service http:Service /contacts_service on new http:Listener(9090) {

    resource function get listContacts(http:Request req) returns http:Response {
        mysql_module:listContacts();

        http:Response response = new;
        response.statusCode = 200;
        return response;
    }

    resource function post addContact(@http:Payload json payload) returns http:Response {
        mysql_module:Contact|error contact = payload.cloneWithType(mysql_module:Contact);
        http:Response response = new;

        if (contact is mysql_module:Contact) {
            error? err = mysql_module:addContact(contact);

            if (err is error) {
                response.statusCode = 500;
                response.setTextPayload(err.message());
            } else {
                response.statusCode = 200;
                response.setTextPayload("Added contact to database");
            }
        } else {
            response.statusCode = 500;
            response.setTextPayload(contact.toString());
        }

        return response;
    }

    resource function post updateContact/[int ID](@http:Payload json payload) returns http:Response {
        mysql_module:Contact|error contact = payload.cloneWithType(mysql_module:Contact);
        http:Response response = new;

        if (contact is mysql_module:Contact) {
            error? err = mysql_module:updateContact(contact, ID);

            if (err is error) {
                response.statusCode = 500;
                response.setTextPayload(err.message());
            } else {
                response.statusCode = 200;
                response.setTextPayload("Updated contect in database");
            }
        } else {
            response.statusCode = 500;
            response.setTextPayload(contact.toString());
        }

        return response;
    }

    resource function post deleteContact/[int ID](http:Request request) returns http:Response {
        error? err = mysql_module:deleteContact(ID);
        http:Response response = new;

        if (err is error) {
            response.statusCode = 500;
            response.setTextPayload(err.message());
        } else {
            response.statusCode = 200;
            response.setTextPayload("Deleted contect from database");
        }

        return response;
    }

    resource function get createTable() returns http:Response {
        error? err = mysql_module:createContactTable();
        http:Response response = new;

        if (err is error) {
            response.statusCode = 500;
            response.setTextPayload(err.message());
        } else {
            response.statusCode = 200;
            response.setTextPayload("Created contact table in database");
        }

        return response;
    }

}
