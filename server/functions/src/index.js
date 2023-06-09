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

const handleStripeError = (error, res) => {
  switch (error.type) {
    case 'StripeCardError':
      // A declined card error
      res.status(400).send({ message: 'Your card has been declined.' });
      break;
    case 'RateLimitError':
      // Too many requests made to the API too quickly
      res.status(429).send({ message: 'Too many requests. Please try again later.' });
      break;
    case 'InvalidRequestError':
      // Invalid parameters were supplied to Stripe's API
      res.status(400).send({ message: 'Invalid parameters.' });
      break;
    case 'APIError':
      // An error occurred internally with Stripe's API
      res.status(500).send({ message: 'Internal error. Please try again later.' });
      break;
    case 'AuthenticationError':
      // Authentication with Stripe's API failed
      res.status(401).send({ message: 'Not authenticated. Please check your API keys.' });
      break;
    default:
      // Handle any other types of unexpected errors
      res.status(500).send({ message: 'An unexpected error occurred.' });
      break;
  }
};

exports.createStripePaymentIntent = onCall(async (data, context) => {

  try {
    const paymentIntent = await stripe.paymentIntents.create({
      amount: data.amount,  // Pass the correct amount
      currency: 'usd',
      // Add more options as needed
    });

    return {
      clientSecret: paymentIntent.client_secret
    };
  } catch (error) {
    handleStripeError(error, response);
  }
});

exports.routeToStripeCheckout = onCall(async (data, context) => {
  
  // Create a product first
  try {
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

    const session = await stripe.checkout.sessions.create({
      line_items: [
        {
          price_data: {
            currency: 'usd',
            product_data: {
              name: 'T-shirt',
            },
            unit_amount: 2000,
          },
          quantity: 1,
        },
      ],
      mode: 'payment',
      success_url: 'https://podiumapartments.com/success',
      cancel_url: 'https://podiumapartments.com/failure',
    });
    console.log(`session:`, session);
    console.log(`price:`, price);
    console.log(`paymentLink:`, paymentLink);
    return session;
  } catch (error) {
    handleStripeError(error, response);
    
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
