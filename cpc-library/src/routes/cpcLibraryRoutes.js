import {
  addnewBook,
  getBooks,
  getBookWithID,
  updateBook,
  deleteBook
} from '../controllers/cpcLibraryController';

const routes = ( app ) => {
  app.route( '/book' )
    .get( getBooks )
    .post( addnewBook );

  app.route( '/book/:bookID' )
    .get( getBookWithID )
    .put( updateBook )
    .delete( deleteBook );

  // .delete((req, res) =>
  //   res.send('DELETE request successful!'));
}

export default routes;
