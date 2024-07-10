const firebase = require('firebase');

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyAIBeOorGcmbTcPS3w_ADRIz_FhjGFoWwI",
  authDomain: "foodary-mobile-app.firebaseapp.com",
  projectId: "foodary-mobile-app",
  storageBucket: "foodary-mobile-app.appspot.com",
  messagingSenderId: "570648531036",
  appId: "1:570648531036:web:085d1ec70ba6b14a0d9699",
  measurementId: "G-CPJCDQ9DSG"
};

firebase.initializeApp(firebaseConfig); //initialize firebase app 
module.exports = { firebase }; //export the app