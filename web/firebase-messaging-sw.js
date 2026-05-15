// Firebase Messaging service worker — must be served at the site root as
// /firebase-messaging-sw.js (same host as the Flutter web app).
// SDK version matches web/index.html.
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyDsYf2_DFUnlVeUi4j7K8z0d3mEfqUEQUE",
  authDomain: "topwr-new-firebase.firebaseapp.com",
  projectId: "topwr-new-firebase",
  storageBucket: "topwr-new-firebase.firebasestorage.app",
  messagingSenderId: "617137016106",
  appId: "1:617137016106:web:5e658b445168146d19a253",
  measurementId: "G-1YNYE6GCC4",
});

const messaging = firebase.messaging();
