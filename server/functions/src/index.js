const {initializeApp} = require("firebase-admin/app");
const {logger} = require("firebase-functions");
const { HttpsError, onCall} = require("firebase-functions/v2/https");

const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

const app = initializeApp({
  apiKey: "AIzaSyAbqW7X77MZBrVI5I2CJd0GfQQJ2uhfH0c",
  authDomain: "podium-78b4e.firebaseapp.com",
  appId: "1:158576154553:web:a4881527ce2a9684bb8868",
  projectId: "podium-78b4e",
  databaseURL: "https://podium-78b4e-default-rtdb.firebaseio.com",
  storageBucket: "podium-78b4e.appspot.com",
  messagingSenderId: "158576154553",
  measurementId: "G-NG6RZE5X1N",
});

exports.createStripePaymentIntent = onCall(async (req) => {

  const rentAmount = req.data.rentAmount;
  const paymentIntent = await stripe.paymentIntents.create({
    amount: 100,
    currency: 'usd',
    automatic_payment_methods: {
      enabled: true,
    },
  });
  return paymentIntent;
});

//~~~~ This is just a test function. Use this to experiment. ~~~~
exports.printmessage = onCall((req) => {

  const text = req.data.text;
  logger.debug(`this is text ${text}`)
  if (!(typeof text === "string") || text.length === 0) {
    // Throwing an HttpsError so that the client gets the error details.
    throw new HttpsError("invalid-argument", "The function must be called " +
    `with one argument 'text' containing the message text to add. Text is ${text}`);
  }
  logger.info('Message Returned');
  const response = { 'message': text };

  return response;
});
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~