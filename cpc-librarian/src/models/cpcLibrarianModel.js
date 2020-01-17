import mongoose from 'mongoose';

const Schema = mongoose.Schema;
export const BookSchema = new Schema( {
  title: {
    type: String,
    required: 'Enter a book title'
  },
  author: {
    type: String,
    required: 'Enter the name of the author'
  },
  checkedIn: {
    type: Date,
    default: Date.now
  },
  checkoutOut: {
    type: Date,
    default: null
  },
  returnDate: {
    type: Date,
    default: null
  }
} );
