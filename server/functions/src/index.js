const {initializeApp} = require("firebase-admin/app");
const {logger} = require("firebase-functions");
const { HttpsError, onCall} = require("firebase-functions/v2/https");

const stripe = require('stripe')('sk_test_51LxiI2FvdtE6BFaUeYbounOqjjNdoHkJhPQomXFMHrAwoIfO2C0AlnIeLSet3C65f0dBE9vKuMopyqd2V18KOeST006GPKClNM');

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

exports.createStripePaymentIntent = onCall(async (data, context) => {

  const rentAmount = data.rentAmount;
  const paymentIntent = await stripe.paymentIntents.create({
    amount: 100,
    currency: 'usd',
    payment_method_types: ['card'],
  });
  return paymentIntent;
});

exports.routeToStripeCheckout = onCall(async (data, context) => {
  
  // Create a product first
  const product = await stripe.products.create({
    name: 'Rent Payment',
  });

  // Then create a price using the product's id
  const price = await stripe.prices.create({
    currency: 'usd',
    unit_amount: 1000,
    product: product.id,
  });

  const paymentLink = await stripe.paymentLinks.create({
    line_items: [
      {
        price: price.id,
        quantity: 1,
      },
    ],
  });

  console.log(`price:`, price);
  console.log(`paymentLink:`, paymentLink);
  return {'response': paymentLink};
});

//~~~~ This is just a test function. Use this to experiment. ~~~~
exports.printmessage = onCall((data, context) => {

  const text = data.text;
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
