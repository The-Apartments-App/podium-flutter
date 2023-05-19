// import firebase from 'firebase';

// import { initializeApp } from 'firebase/app';
// import { getFunctions } from 'firebase/functions';

const admin = require('firebase-admin');
const functions = require("firebase-functions");

const app = admin.initializeApp({
  apiKey: "AIzaSyAbqW7X77MZBrVI5I2CJd0GfQQJ2uhfH0c",
  authDomain: "podium-78b4e.firebaseapp.com",
  databaseURL: "https://podium-78b4e-default-rtdb.firebaseio.com",
  projectId: "podium-78b4e",
  storageBucket: "podium-78b4e.appspot.com",
  messagingSenderId: "158576154553",
  appId: "1:158576154553:web:a4881527ce2a9684bb8868",
  measurementId: "G-NG6RZE5X1N",
});
// const functions = firebase.functions.getFunctions(app);


const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

// console.log({stripe});

// const generatePaymentResponse = (intent) => {
//   switch(intent.status) {
//     case 'requires_action':
//       return {
//         clientSecret: intent.clientSecret,
//         requiresAction: true,
//         status: intent.status,
//       };
//     case 'requires_payment_method':
//       return {
//         'error': 'Your card was denied, please provide a new payment method',
//       };
//     case 'succeeded':
//       console.log("Payment Succeeded");
//       return { clientSecret: intent.clientSecret, status: intent.status }
//   }
//   return { error: 'failed'};
// }

// exports.StripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
//   const { paymentMethodId, rentBill, currency, useStripeSdk, } = req.body;

//   const orderAmount = 5;

//   try {
//     if(paymentMethodId){
//       const params = {
//         amount: orderAmount,
//         confirm: true,
//         confirmation_method: 'manual',
//         currency: currency,
//         payment_method: paymentMethodId,
//         use_stripe_sdk: useStripeSdk
//       }
//       const intent = await stripe.paymentIntents.create(params);
//       console.log({intent});
//       return res.send(generatePaymentResponse(intent))
//     }
//     return res.sendStatus(400);
//   } catch(error){
//       throw new functions.https.HttpsError(error.code, error.message)
//   }
// })

// exports.StripePayEndpointIntentId = functions.https.onRequest(async (req, res) => {
//   const { paymentIntentId } = req.body;

//   try {
//     if(paymentIntentId) {
//       const intent =  await stripe.paymentIntents.confirm(paymentIntentId);
//       console.log({intent});
//       return res.send(generatePaymentResponse(intent));
//     }
//     return res.sendStatus(400);
//   } catch(error){
//       throw new functions.https.HttpsError(error.code, error.message);
//   }
// });
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.helloWorld = functions.https.onRequest((req, res) => {
console.log('This shit was called.');
try {
  console.log('this is inside of the try');
  functions.logger.info("Hello logs!", {structuredData: true});
  res.json({result : 'Success!'});
  } catch (error) {
    console.log('this is inside of the try');
    console.log({error});
    throw new functions.https.HttpsError(error.code, error.message);
  }
});
