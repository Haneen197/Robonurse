const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

// Function to create user document when a new user signs up
exports.createUserDocument = functions.auth.user().onCreate(async (user) => {
  const firestore = admin.firestore();
  
  // Create a basic user document
  const userData = {
    email: user.email,
    displayName: user.displayName || '',
    uid: user.uid,
    createdTime: admin.firestore.FieldValue.serverTimestamp(),
    photoUrl: user.photoURL || '',
    phoneNumber: user.phoneNumber || '',
    patient: false,
    doctor: false,
  };

  try {
    await firestore.collection('users').doc(user.uid).set(userData);
    console.log(`User document created for ${user.uid}`);
  } catch (error) {
    console.error('Error creating user document:', error);
  }
});

// Function to handle user deletion
exports.onUserDeleted = functions.auth.user().onDelete(async (user) => {
  let firestore = admin.firestore();
  let userRef = firestore.doc("users/" + user.uid);
  await firestore.collection("users").doc(user.uid).delete();
});

// HTTP function to update user role (can be called from the app)
exports.updateUserRole = functions.https.onCall(async (data, context) => {
  // Check if user is authenticated
  if (!context.auth) {
    throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated');
  }

  const { role } = data;
  const userId = context.auth.uid;

  if (!role || (role !== 'Patient' && role !== 'Doctor')) {
    throw new functions.https.HttpsError('invalid-argument', 'Invalid role provided');
  }

  const firestore = admin.firestore();
  
  try {
    await firestore.collection('users').doc(userId).update({
      patient: role === 'Patient',
      doctor: role === 'Doctor',
    });
    
    return { success: true, message: 'Role updated successfully' };
  } catch (error) {
    console.error('Error updating user role:', error);
    throw new functions.https.HttpsError('internal', 'Failed to update user role');
  }
});
