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

const handleStripeError = (error) => {
  let message;

  switch (error.type) {
    case 'StripeCardError':
      message = 'Your card has been declined.';
      break;
    case 'RateLimitError':
      message = 'Too many requests. Please try again later.';
      break;
    case 'InvalidRequestError':
      message = 'Invalid parameters.';
      break;
    case 'APIError':
      message = 'Internal error. Please try again later.';
      break;
    case 'AuthenticationError':
      message = 'Not authenticated. Please check your API keys.';
      break;
    default:
      message = 'An unexpected error occurred. Actually, no. I fully expected this to happen so fuck you.';
      break;
  }

  throw new HttpsError('invalid-argument', message);
};


// exports.createStripePaymentIntent = onCall(async (data, context) => {

//   try {
//     const paymentIntent = await stripe.paymentIntents.create({
//       amount: data.amount,  // Pass the correct amount
//       currency: 'usd',
//       // Add more options as needed
//     });

//     return {
//       clientSecret: paymentIntent.client_secret
//     };
//   } catch (error) {
//     handleStripeError(error, response);
//   }
// });

exports.routeToStripeCheckout = onCall(async (data, context) => {
  
  // Create a product first
  try {
    const product = await stripe.products.create({
      name: 'Rent Payment',
    });

  const session = await stripe.checkout.sessions.create({
    line_items: [
      {
        price_data: {
          product: product.id,
          unit_amount: 1000,
          currency: 'usd',
        },
        quantity: 1,
      },
    ],
    mode: 'payment',
    success_url: 'https://podiumapartments.com/success',
    cancel_url: 'https://podiumapartments.com/failure',
  });

    return session;

  } catch (error) {
    handleStripeError(error);
    
  }

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
