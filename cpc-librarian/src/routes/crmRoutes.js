import {
  addnewContact,
  getContacts,
  getContactWithID,
  updateContact,
  deleteContact
} from '../controllers/crmController';


const routes = (app) => {
  app.route('/contact')
    .get(getContacts)
    .post(addnewContact);

  app.route('/contact/:contactID')
    .get(getContactWithID)
    .put(updateContact)
    .delete(deleteContact);

    // .delete((req, res) =>
    //   res.send('DELETE request successful!'));
}

export default routes;
