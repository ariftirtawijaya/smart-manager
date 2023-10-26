const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.deleteUser = functions.https.onRequest((req, res) => {
  const userId = req.query.userId;

  admin
      .auth()
      .deleteUser(userId)
      .then(() => {
        res.status(200).send("User deleted successfully");
      })
      .catch((error) => {
        res.status(500).send("Error while deleting user: " + error);
      });
});
