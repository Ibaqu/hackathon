import ContactBook.mysql_module;

public function main() {

    mysql_module:listContacts();

    mysql_module:Contact contact = { 
        Name : "Testing",
        Address: "1/3 Nittawela road",
        Phone: 2345,
        Email: "aquib.zt@gmail.com"
    };

    mysql_module:addContact(contact);

    mysql_module:listContacts();

    mysql_module:deleteContact(6);

    mysql_module:Contact contactUpdated = { 
        Name : "Zee",
        Address: "1/3 Nittawela road",
        Phone: 2345,
        Email: "zeeb.zt@gmail.com"
    };

    mysql_module:updateContact(contactUpdated, 5);

}
