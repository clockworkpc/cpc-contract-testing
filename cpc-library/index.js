import express from 'express';
import routes from './src/routes/cpcLibraryRoutes';
import mongoose from 'mongoose';
import bodyParser from 'body-parser';

const app = express();
const PORT = 4001;

// mongoose connection
mongoose.Promise = global.Promise;
mongoose.connect( 'mongodb://localhost/LIBRARYdb', {
  useNewUrlParser: true,
  useUnifiedTopology: true
} );

// bodyParser setup
app.use( bodyParser.urlencoded( { extended: true } ) );
app.use( bodyParser.json() );

routes( app );

app.get( '/', ( req, res ) =>
  res.send( `Welcome to the CPC Library on MongoDB, available at Port ${PORT}` )
);

app.listen( PORT, () =>
  console.log( `CPC Library server is running on port ${PORT}` )
);
