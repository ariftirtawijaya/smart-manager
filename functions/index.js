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

exports.updateUserCredential = functions.https.onRequest(async (req, res) => {
  const userId = req.query.userId;
  const newEmail = req.query.newEmail;
  const newPassword = req.query.newPassword;

  try {
    if (newEmail) {
      await admin.auth().updateUser(userId, {
        email: newEmail,
      });
    }

    if (newPassword) {
      await admin.auth().updateUser(userId, {
        password: newPassword,
      });
    }

    res.status(200).send("User credential updated successfully");
  } catch (error) {
    res.status(500).send("Error while updating user credential: " + error);
  }
});

exports.createUser = functions.https.onRequest(async (req, res) => {
  const email = req.query.email;
  const password = req.query.password;

  try {
    const userRecord = await admin.auth().createUser({
      email: email,
      password: password,
    });
    const uid = userRecord.uid;

    res.status(200).send(`${uid}`);
  } catch (error) {
    res.status(500).send("Error while creating user: " + error);
  }
});

exports.deleteStoreFolder = functions.https.onRequest(async (req, res) => {
  const storeId = req.query.storeId;

  try {
    const bucket = admin.storage().bucket();
    const folderPath = `store/${storeId}`;
    const [files] = await bucket.getFiles({
      prefix: folderPath,
    });
    for (const file of files) {
      await file.delete();
    }

    res.status(200).send("All image from "+ storeId + " sucessfully deleted");
  } catch (error) {
    res.status(500).send("Error while deleting store images: " + error);
  }
});
