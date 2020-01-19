# CPC Contract Testing

This project is a customised clone of [ruby-template](https://github.com/clockworkpc/ruby-template) on Github, which inherits the accumulated Ruby knowledge of Alexander JK Garber from [cpc-ruby](https://github.com/clockworkpc/ruby-template)

## Licence

All code herein is available under a GPLv3 licence.  Please use, re-use, modify, and share.

## Purpose: Contract Testing between Services

The purpose of this project is to provide a simplistic scenario for contract testing in a microservices architecture.  In this project are two services:
1. CPC Library: an Express server connected to a Mongo database, which contains a collection of library books.
2. CPC Librarian: an Express server that communicates with CPC Library on behalf of the Client.

The role of the Client is played by Ruby classes that make API calls to **CPC Librarian**, which are executed by RSpec.

## Structure

The project is composed of two elements:
1. Ruby *Classes* and RSpecs in the root folder:
   1. `lib`: the Ruby Classes.
   2. `spec`: the RSpec suite.
1. Two Node-Express servers in sub-folders:
   1. `cpc-library`
   2. `cpc-librarian`

## Note About The Roles of Library and Librarian

In order for the contract testing to be meaningful, the **Librarian** needs to do more than simply ferry API calls between the Client and Library.  Therefore, in this setup, imagine that the **Library** offers only a primitive GET API:
- GET all books in the collection
- GET a book by Book ID

This means that in order to retrieve the details of a book by other parameters, namely **author** and **title**, a middleman needs to `GET` the details of all the books in the collection and then iterate through the response body to filter by **author** and **title**.

In this fictitious and probably unrealistic scenario, therefore, the **Librarian** performs the vital function of giving the end-user a way to search for a book in the collection without having to supply the book's unique `_id` or parse the mass of a JSON response body.

## Workflow

```
REQUEST:  Client => Librarian => Library
RESPONSE: Library => Librarian => Client
```

### Basic Example: Is A Book Available To Borrow?

1. Library Member visits the Librarian website, and in the search form,
   1. types in the **Book Title** field the title "Hello, World!"
   1. types in the **Author** field the name "Foo Bar III",
   1. and clicks **Search**, to see whether it is available. **[1]**

1. The UI sends an API call to the Express server `cpc-librarian` on port **4002**: `POST http://localhost:4002/book/request/available ({author: "Foo Bar III", title: "Hello, World!"})`
1. `cpc-librarian` then performs the following actions:
   1. `GET`s **all** the library books in the collection from the **CPC Library** Express server on Port **4001**:
      - `GET http://localhost:4001/book/`
      - Receives **GET Response 200** (if any books exist in the DB)
   1. Identifies the `_id` of the first **available** copy, i.e. which matches **author** and **title** WHERE `available === true`.
   1. Returns the details of the book in the body of the **GET response**.
1. The front end will process this response and display it to the end-user.

**[1]** This is simulated in RSpec by the method call `CpcLibrarian.get_book_by_author_title('Foo Bar III', 'Hello, World!')`.

### Advanced Example: Checking Out A Book

1. Library visits the Librarian website,
   1. finds the book 'Hello, World!' by Foo Bar III,
   1. sees that it is available,
   1. and clicks "Borrow" **[2]**
1. The UI sends an API call to the Express server `cpc-librarian` on port **4002**:
   - `POST http://localhost:4002/book/request/borrow ( {_id: 123456789} )`
1. `cpc-librarian` then performs the following actions:
   1. Sends a request to the **CPC Library** Express server on port **4001** to *modify* the entry for the book in the database:
      - `PATCH http://localhost:4001/book ({ id_: 123456789, available: false, checkedOut: TODAY(), Due: TODAY()+14 })`
      - Receive **PATCH Response 200** (if request successful)
   1. Returns the details of the book, including the **Due Date** in the **POST response**.
1. The front end will process this response and display it to the end-user.

**[2]** This is simulated in RSpec by the method call CpcLibrarian.borrow_book({ BOOK_ID })
