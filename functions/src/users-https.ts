//const admin=require('firebase-admin');
//import * as admin from 'firebase-admin';
//import * as functions from 'firebase-functions';
//const firestore = admin.firestore();


/* *********************************************************************** */
const photoDefaultSmall ='https://firebasestorage.googleapis.com/v0/b/beautix-54f94.appspot.com/o/app%2Fdefault_small.jpg?alt=media&token=9b9929b8-e7e6-45cb-8c39-834f30c0c90f';
//const photoDefaultLarge ='https://firebasestorage.googleapis.com/v0/b/beautix-54f94.appspot.com/o/app%2Fdefault_large.jpg?alt=media&token=b6b0f254-c45c-4e96-a8c6-255726711b06';

/* *********************************************************************** */
//import { sendLogError } from "./send-mail"
import { IResponse } from './models';
import { IUser } from './iuser';
import { UserRecord, user } from 'firebase-functions/lib/providers/auth';
/* *********************************************************************** */
/* *********************************************************************** */
export const addUserModule=async function(data,context,admin,firestore){
    console.info("#############  addUser   : ", data);
    const respTX :IResponse={
        status:true,
        message:'antes de correr',
    };
   
    let paso='0';
   
    try{
        const newuser:IUser=data.user;
        const password:string=data.password;
        console.info("#############  newuser   : ", newuser);
     
        /*
        const usersname= await firestore.collection('users').where('username', '==', newuser.name ).select().get();
       // console.warn("#############  usersname docs : " ,usersname.docs);
       // console.warn("############# usersname size  : " ,usersname.size);
        paso='1';
        for (const user of usersname.docs) {
            console.log(user);
             if(user.id !== newuser.id){
                respTX.status=false;
                respTX.message='El nombre de usuario '+ newuser.name+' ya está en uso.';
                return respTX;
             }
        }
        */
        /*
        const usersname= await firestore.collection('users').where('username', '==', newuser.username ).get();
        paso='1';
        if(usersname.size>0){
            respTX.status=false;
            respTX.message='El nombre de usuario '+ newuser.username+' ya está en uso.';
            return respTX;

        }
        */


        /*
        const usersemail= await firestore.collection('users').where('email', '==', newuser.email).select().get();
         console.warn("#############  usersemail docs : " ,usersemail.docs);
        console.warn("############# usersemail size  : " ,usersemail.size);
        paso='2';
        for (const usercheck of usersemail.docs) {
            console.log(usercheck);
             if(usercheck.id !== newuser.id){
                respTX.status=false;
                respTX.message='Ya existe un usuario con el email ' + newuser.email;
                return respTX;
             }
        }
        */
        
        
        const newFirebaseUser={
            uid:newuser.id,
            displayName:newuser.name,
            email:newuser.email,
            password: password,
            photoURL:photoDefaultSmall
        };
        
        paso='3';
        const firebaseUser:UserRecord=await admin.auth().createUser(newFirebaseUser);
        console.info("=====> addUser usuario creado firebaseUser : ",firebaseUser );
        
       paso='4';
       
       newuser.photoUrl=photoDefaultSmall;
       newuser.isAdmin=false;
      
       console.info("=====>Antes addUser usuario firestore: ",newuser );
       await firestore.collection('users').doc(newuser.id).set(newuser, {merge: true});


       console.info("=====>Despues addUser usuario firestore: ",newuser );
       respTX.status=true;
       respTX.message='Nuevo usuario creado con mail ' + newuser.email;
       return respTX;
       
        
    }catch(error) {
        //await sendLogError("addUser \npaso:"+paso+"\nmessage: " +error.toString()+ ' username:'+ data.user.name + ' email:'+ data.user.email+ ' uid: '+ data.user.id);
        console.warn("#############  addUser resp: " ,error);
        return{
           status:false,
           message:error.toString(),  
        }
    };
};

/* *********************************************************************** */
/* *********************************************************************** */
export const  updateUserModule=async function(data,context,admin,firestore){
     
   
    const respTX :IResponse={
        status:true,
        message:'antes de correr',
    };
   
    if (!context.auth) {
        respTX.status=false;
        respTX.message="No esta autenticado, debe volver a iniciar session..."
        return respTX;
    }

    
    let paso='0';
   
    try{
      
        const newuser:IUser=data.user;
        console.log('updateUserModule user', newuser);
        if(newuser.age!==undefined){
            newuser.age= getDate(newuser.age);
        }
        /*
        const usersname= await firestore.collection('users').where('username', '==', newuser.name ).select().get();
        //console.warn("#############  usersname docs : " ,usersname.docs);
        //console.warn("############# usersname size  : " ,usersname.size);
        paso='1';
        for (const user of usersname.docs) {
             if(user.id !== newuser.id){
                console.warn("usersname name duplicado",user);
                respTX.status=false;
                respTX.message='El nombre de usuario '+ newuser.name+' ya está en uso.';
                return respTX;
             }
        }
        */
        /*
        paso='1';
        if(usersname.size>0){
            respTX.status=false;
            respTX.message='El nombre de usuario '+ newuser.username+' ya está en uso.';
            return respTX;

        }
         */
        const usersemail= await firestore.collection('users').where('email', '==', newuser.email).select().get();
       // console.warn("#############  usersemail docs : " ,usersemail.docs);
       // console.warn("############# usersemail size  : " ,usersemail.size);
        paso='2';
        for (const chekuser of usersemail.docs) {
          
             if(chekuser.id !== newuser.id){
                console.warn("usersemail mail duplicado",user);
                respTX.status=false;
                respTX.message='Ya existe un usuario con el email ' + newuser.email+', cambielo y reintente!';
                return respTX;
             }
        }

        
        const newFirebaseUser={
            displayName:newuser.name,
            email:newuser.email,
            photoURL:newuser.photoUrl,
        };
       
        paso='3';
        const firebaseUser:UserRecord=await admin.auth().updateUser(newuser.id,newFirebaseUser);
        
        console.log("=====> updateUser usuario : ",firebaseUser );
        
       paso='4';
            
        const resp= await firestore.collection('users').doc(newuser.id).set(newuser, {merge: true});
       // const resp= await firestore.collection('users').doc(`${newuser.id}`).update({username:newuser.name, email:newuser.email, photoUrl:newuser.photoUrl});
        console.log("#############  updateUser resp: " ,resp);
        
        respTX.status=true;
        respTX.message='Datos actualizados!';
        return respTX;
       
        
    }catch(error) {
        console.warn("#############  updateUser  error resp: " ,error);
       // await sendLogError("updateUser \npaso:"+paso+"\nmessage: " +error.toString());
        return{
           status:false,
           message:error.toString(),  
        }
    };

};

/* ******************************************************************* */
function getDate(_stringDate:String): Date {
    console.warn('getDate init gp',_stringDate );
        try{
            
          //  const _stringDate="2018-11-14T19:00:00.000";
          //  const now=new Date();
            
            const parts =_stringDate.split('T');
            const partsD =parts[0].split('-');
            const partsH=parts[1].split(':');
            const prevDate=new Date( + partsD[0], + partsD[1] - 1,+ partsD[2],+ partsH[0],+ partsH[1]); 
            return prevDate;
        }catch(err){
            console.error('getNextDate error:', err);
            const messge = "ERROR SERVIDOR - getDate error :" + err;
            return null;
        }
    }

module.exports = { addUserModule ,updateUserModule}