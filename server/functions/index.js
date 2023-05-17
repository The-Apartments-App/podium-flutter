const functions = require("firebase-functions");

const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);

const generatePaymentResponse = (intent) => {
  switch(intent.status) {
    case 'requires_action':
      return {
        clientSecret: intent.clientSecret,
        requiresAction: true,
        status: intent.status,
      };
    case 'requires_payment_method':
      return {
        'error': 'Your card was denied, please provide a new payment method',
      };
    case 'succeeded':
      console.log("Payment Succeeded");
      return { clientSecret: intent.clientSecret, status: intent.status }
  }
  return { error: 'failed'};
}

exports.StripePayEndpointMethodId = functions.https.onRequest(async (req, res) => {
  const { paymentMethodId, rentBill, currency, useStripeSdk, } = req.body;

  const orderAmount = 5;

  try {
    if(paymentMethodId){
      const params = {
        amount: orderAmount,
        confirm: true,
        confirmation_method: 'manual',
        currency: currency,
        payment_method: paymentMethodId,
        use_stripe_sdk: useStripeSdk
      }
      const intent = await stripe.paymentIntents.create(params);
      console.log({intent});
      return res.send(generatePaymentResponse(intent))
    }
    return res.sendStatus(400);
  } catch(error){
      throw new functions.https.HttpsError(error.code, error.message)
  }
})

exports.StripePayEndpointIntentId = functions.https.onRequest(async (req, res) => {
  const { paymentIntentId } = req.body;

  try {
    if(paymentIntentId) {
      const intent =  await stripe.paymentIntents.confirm(paymentIntentId);
      console.log({intent});
      return res.send(generatePaymentResponse(intent));
    }
    return res.sendStatus(400);
  } catch(error){
      throw new functions.https.HttpsError(error.code, error.message);
  }
});
// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.helloWorld = functions.https.onRequest((req, res) => {

  try {
    functions.logger.info("Hello logs!", {structuredData: true});
    return res.status(200).json({ message: "Success" });
  } catch (error) {
      throw new functions.https.HttpsError(error.code, error.message);
  }
});
