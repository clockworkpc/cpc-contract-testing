import mongoose from 'mongoose';
import {
  BookSchema
}
from '../models/cpcLibraryModel';

const Book = mongoose.model( 'Book', BookSchema );

export const addnewBook = ( req, res ) => {
  let newBook = new Book( req.body );

  newBook.save( ( err, book ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( book );
  } );
}

export const getBooks = ( req, res ) => {
  Book.find( {}, ( err, book ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( book );
  } );
}

export const getBookWithID = ( req, res ) => {
  Book.findById( req.params.bookID, ( err, book ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( book );
  } );
}

export const updateBook = ( req, res ) => {
  Book.findOneAndUpdate( {
    _id: req.params.bookID
  }, req.body, {
    new: true,
    useFindAndModify: false
  }, ( err, book ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( book );
  } );
}

export const deleteBook = ( req, res ) => {
  Book.deleteOne( { _id: req.params.bookID }, ( err, book ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( { message: `Successfully deleted book: ${req.params.bookID}`, id: req.params.bookID } );
  } );
}
