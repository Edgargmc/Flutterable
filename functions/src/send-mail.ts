
//const functions = require('firebase-functions');
import * as functions from 'firebase-functions';
const nodemailer = require('nodemailer');

//firebase functions:config:set gmail.email="beautixapp@gmail.com" gmail.password="Gustavo54667531";
const gmailEmail = functions.config().gmail.email;
const gmailPassword = functions.config().gmail.password;
 const mailTransport = nodemailer.createTransport({
    service: 'gmail',
    auth: {
        user: gmailEmail,
        pass: gmailPassword
    }
});
const mailFrom=gmailEmail;

/* *********************************************************************** */
/* *********************************************************************** */

export const sendLogError=async function(message:string){
    try{
    console.warn("############# ERROR: " +message);
    const mailOptions = {
        from: mailFrom,
        to: mailFrom,
        subject: "ERROR Servidor 😡  😡 ",
        text: message
    };
       return mailTransport.sendMail(mailOptions); 
    }catch(error){
        console.warn("############# ERROR sendLogError resp: " ,error);
        return false;
    }
}

export const sendMail=async function(data, context){    
    try{
    console.warn("############# sendAppMail: " ,data.message);
    const mailOptions = {
        from: data.username + '<'+mailFrom+'>',
        to: mailFrom,
        subject: "Hack19 App😀😀",
        html: data.message
    };
     return mailTransport.sendMail(mailOptions); 
    }catch(error){
        console.warn("############# ERROR sendAppMail resp: " ,error);
        return false;
    }
};
/* *********************************************************************** */
/* *********************************************************************** */