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
  quantity: {
    type: Number,
    default: 1
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


// christianName: {
//   type: String,
//   required: 'Enter a Christian name'
// },
// surname: {
//   type: String,
//   required: 'Enter a surname'
// },
// email: {
//   type: String
// },
// company: {
//   type: String
// },
// phone: {
//   type: Number
// },
// created_date: {
//   type: Date,
//   default: Date.now
// }
