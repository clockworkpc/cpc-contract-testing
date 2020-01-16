import mongoose from 'mongoose';
import {
  BookSchema
}
from '../models/cpcLibraryModel';

const Book = mongoose.model( 'Book', BookSchema );

export const addnewBook = ( req, res ) => {
  let newBook = new Book( req.body );

  newBook.save( ( err, contact ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( contact );
  } );
}

export const getBooks = ( req, res ) => {
  Book.find( {}, ( err, contact ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( contact );
  } );
}

export const getBookWithID = ( req, res ) => {
  Book.findById( req.params.contactID, ( err, contact ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( contact );
  } );
}

export const updateBook = ( req, res ) => {
  Book.findOneAndUpdate( {
    _id: req.params.contactID
  }, req.body, {
    new: true,
    useFindAndModify: false
  }, ( err, contact ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( contact );
  } );
}

export const deleteBook = ( req, res ) => {
  Book.deleteOne( { _id: req.params.contactID }, ( err, contact ) => {
    if ( err ) {
      res.send( err );
    }
    res.json( { message: `Successfully deleted contact: ${req.params.contactID}`, id: req.params.contactID } );
  } );
}
