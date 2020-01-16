import mongoose from 'mongoose';

const Schema = mongoose.Schema;
export const ContactSchema = new Schema({
  christianName: {
    type: String,
    required: 'Enter a Christian name'
  },
  surname: {
    type: String,
    required: 'Enter a surname'
  },
  email: {
    type: String
  },
  company: {
    type: String
  },
  phone: {
    type: Number
  },
  created_date: {
    type: Date,
    default: Date.now
  }
});
