import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
console.warn('===> admin init admin');  


let firestore:any;

/* **************************** USER ************************************** */

exports.addUser=functions.runWith({ memory: '256MB', timeoutSeconds: 300 }).https.onCall(async (data, context) => {
    console.log("#############  addUser call: " ,data);
    firestore = firestore || admin.firestore();
    const module = require('./users-https');
    return await module.addUserModule(data,context,admin,firestore);
});
