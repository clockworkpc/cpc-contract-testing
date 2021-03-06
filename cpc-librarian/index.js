import express from 'express';
import routes from './src/routes/cpcLibrarianRoutes';
import mongoose from 'mongoose';
import bodyParser from 'body-parser';

const app = express();
const PORT = 4002;

// mongoose connection
mongoose.Promise = global.Promise;
mongoose.connect( 'mongodb://localhost/CRMdb', {
  useNewUrlParser: true,
  useUnifiedTopology: true
} );

// bodyParser setup
app.use( bodyParser.urlencoded( { extended: true } ) );
app.use( bodyParser.json() );

routes( app );

app.get( '/', ( req, res ) =>
  res.send( `Welcome to the CPC Librarian on MongoDB, available at Port ${PORT}` )
);

app.listen( PORT, () =>
  console.log( `Your server is running on port ${PORT}` )
);
