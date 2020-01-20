import {
  // addnewBook,
  getBooks,
  getBookWithID,
  getBooksByAuthor
  // updateBook,
  // deleteBook
} from '../controllers/cpcLibrarianController';

const routes = (app) => {
  app.route('/book')
    .get(getBooks);
  // .post( addnewBook );

  app.route('/book/:bookID')
    .get(getBookWithID);
  // .put( updateBook )
  // .delete( deleteBook );

  // .delete((req, res) =>
  //   res.send('DELETE request successful!'));

  app.route('/book/request/available')
    .get(getBooksByAuthor);
}

export default routes;
