import mongoose from 'mongoose';
// import request from 'request';
const request = require('request');
const libraryHost = 'http://localhost:4001';

function logRequest(req, description) {
  console.log("\n" + "REQUEST: " + description);
  console.log("METHOD AND URL: " + req.method + ' ' + req.url + "\n");
  console.log("BODY:");
  console.log(req.body);
  console.log("HEADERS:");
  console.log(req.headers);
  console.log("\n-------------------\n");
}

export const getBooks = (req, res) => {
  logRequest(req, "getBooks");

  const getBooksOptions = {
    method: 'GET',
    url: [libraryHost, 'book'].join('/')
  };

  request(getBooksOptions, (err, apiResponse, body) => {
    err ? console.log(err) : res.send(JSON.parse(body));
  });
}

export const getBookWithID = (req, res) => {
  logRequest(req, 'getBookWithID');
  const getBookWithIDOptions = {
    method: 'GET',
    url: [libraryHost, 'book', req.params.bookID].join('/')
  };

  request(getBookWithIDOptions, (err, apiResponse, body) => {
    err ? console.log(err) : res.send(JSON.parse(body));
  });
}

export const getBooksByAuthor = (req, res) => {
  logRequest(req, 'getBooksByAuthor');
  const getBooksOptions = {
    method: 'GET',
    url: [libraryHost, 'book'].join('/')
  };

  function filterByAuthor(json_body) {
    return {
      "author": "Foo Bar III",
      "title": "Hello, World!"
    }
  }

  request(getBooksOptions, (err, apiResponse, body) => {
    if (err) {
      console.log(err);
    } else {
      filterByAuthor(JSON.parse(body));
    }
  });



}

// export const updateBook = ( req, res ) => {
//   Book.findOneAndUpdate( {
//     _id: req.params.bookID
//   }, req.body, {
//     new: true,
//     useFindAndModify: false
//   }, ( err, book ) => {
//     if ( err ) {
//       res.send( err );
//     }
//     res.json( book );
//   } );
// }
//
// export const deleteBook = ( req, res ) => {
//   Book.deleteOne( { _id: req.params.bookID }, ( err, book ) => {
//     if ( err ) {
//       res.send( err );
//     }
//     res.json( { message: `Successfully deleted book: ${req.params.bookID}`, id: req.params.bookID } );
//   } );
// }
