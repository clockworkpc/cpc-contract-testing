const _ = require('lodash');
const formidableMiddleware = require('express-formidable');
const libraryHost = 'http://localhost:4001';
import mongoose from 'mongoose';
const request = require('request');

function logRequest(req, description) {
  console.log("\n" + "REQUEST: " + description);
  console.log("METHOD AND URL: " + req.method + ' ' + req.url + "\n");
  console.log("BODY:");
  console.log(req.fields);
  console.log("HEADERS:");
  console.log(req.headers);
  console.log("\n-------------------\n");
}

function logResponse(packagedResponse, description) {
  console.log("\n" + "RESPONSE: " + description);
  console.log(packagedResponse);
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

export const requestBooksByAuthor = (req, res) => {
  logRequest(req, 'requestBooksByAuthor');

  const getBooksOptions = {
    method: 'GET',
    url: [libraryHost, 'book'].join('/')
  };

  function filterByAuthor(hsh_ary, author_str) {
    return _.filter(hsh_ary, { 'author': author_str });
  }

  request(getBooksOptions, (err, apiResponse, body) => {
    if (err) {
      console.log(err);
    } else {
      var booksByAuthor = filterByAuthor(JSON.parse(body), req.fields['author']);
      logResponse(booksByAuthor, `Books by the author: ${req.fields['author']} \n`);
      res.send(booksByAuthor);
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
