import ContactBook.mysql_module;

public function main() {

    mysql_module:listContacts();

    mysql_module:addContact();

    mysql_module:listContacts();

    mysql_module:deleteContact();

}
