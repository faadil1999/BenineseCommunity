


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:unautrefirebase/DatabaseManager.dart';

import 'User.dart';

class AuthentificationService{

 final FirebaseAuth _auth =FirebaseAuth.instance;
 late String getUid  = "";


 AppUser? _userFromFirebaseUser(User user){
   return user != null ? AppUser(uid: user.uid) : null;
 }

 Stream<AppUser?> get user{
   return _auth.authStateChanges().map(_userFromFirebaseUser);
 }

   Future signInWithEmailAndPassword(String email , String password) async{

     try{
       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
       User user =result.user;
       return user;
     }catch(e){
       print(e.toString());
     }

   }

 Future createNewUser(String email , String password , String full_name, String university ,String tel  ) async{

   try{
     UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     User user = result.user;
    await DatabaseManager().createUserData(full_name, university, tel , user.uid);

    this.getUid = user.uid;
     print("Le uid de lutilisateur est ------------------${this.getUid}-----------------");
   }catch(e){
     print(e.toString());
   }


 }

 Future signOut() async{
   try {

     return await _auth.signOut();

   }catch(exeption){
     print(exeption.toString());
     return null;
   }
 }
}