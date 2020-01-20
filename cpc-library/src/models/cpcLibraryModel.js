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
  checkedInDate: {
    type: Date,
    default: Date.now
  },
  checkoutOutDate: {
    type: Date,
    default: null
  },
  returnDate: {
    type: Date,
    default: null
  },
  available: {
    type: Boolean,
    default: true
  }
} );
