import mongoose from 'mongoose';
// import request from 'request';
const request = require( 'request' );
const libraryHost = 'http://localhost:4001';

export const getBooks = ( req, res ) => {
  const getBooksOptions = {
    method: 'GET',
    url: [ libraryHost, 'book' ].join( '/' )
  };

  request( getBooksOptions, ( err, apiResponse, body ) => {
    err ? console.log( err ) : res.send( JSON.parse( body ) );
  } );
}

export const getBookWithID = ( req, res ) => {
  const getBookWithIDOptions = {
    method: 'GET',
    url: [ libraryHost, 'book', req.params.bookID ].join( '/' )
  };

  request( getBookWithIDOptions, ( err, apiResponse, body ) => {
    err ? console.log( err ) : res.send( JSON.parse( body ) );
  } );
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
