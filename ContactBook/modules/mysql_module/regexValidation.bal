import ballerina/regex;


public function validate(Contact contact) returns boolean {

    // Validate email
    if (regex:matches(contact.Email, "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$")) {
        return true;
    }

    // Validate phone number
    if (regex:matches(contact.Phone.toString(), "^\\d{10}$")) {
        return true;
    }

    return false;
}