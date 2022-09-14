contract myBooks {
  //Mappings
  mapping(uint => string) public names;
  mapping(uint => string) public books;
  mapping(address => mapping(uint => string)) public myBooks;
  
  struct Book{
    string title;
    string author;
  }
  
  constructor() {
    names[1] = "Adam";
    names[2] = "Charles";
    names[2] = "Bob";
  }
  
  function addBooks(
    uint _id;
    string memory _title;
    string memory _author;
  ) public {
    books[_id] = Book(_title, _author);    
  }
  
  function addMyBooks(
    uint _id;
    string memory _title;
    string memory _author;
  ) public {
    myBooks[msg.sender][_id] = Book(_title, _author);
  }
  
}
