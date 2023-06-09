/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });



// You will need the blaze plan for firebase in order to use this code. As well as firebase funtions


const functions = require('firebase-functions');
const admin = require('firebase-admin');
const fs = require('fs');
const path = require('templates/welcome_email.html');
admin.initializeApp();

exports.sendWelcomeEmail = functions.auth.user().onCreate((user) => {
  const userEmail = user.email;
  const fromEmail = functions.config().email.from;

  const delay = 60000; // 1 minute delay

  setTimeout(() => {
    const templatePath = path.join(__dirname, 'templates/welcome_email.html');
    const htmlTemplate = fs.readFileSync(templatePath, 'utf8');
    const customizedTemplate = htmlTemplate.replace('{{username}}', username);

    const mailOptions = {
      from: fromEmail,
      to: userEmail,
      subject: 'Welcome to The App',
      html: customizedTemplate,
    };

    admin
      .firestore()
      .collection('mail')
      .add(mailOptions)
      .then(() => {
        console.log('Welcome email sent successfully');
      })
      .catch((error) => {
        console.error('Error sending welcome email:', error);
      });
  }, delay);

  return null;
});