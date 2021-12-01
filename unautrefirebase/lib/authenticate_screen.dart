
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unautrefirebase/AuthentificationService.dart';
import 'package:unautrefirebase/DatabaseManager.dart';
import 'package:unautrefirebase/ListUser.dart';
import 'package:unautrefirebase/homeScreen.dart';

import 'home.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({Key? key,}) : super(key: key);

  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  final formKey = GlobalKey<FormState>();
  final fullnameController = TextEditingController();
  final universityController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final telController = TextEditingController();
  bool showSignIn = false;
  bool loading = false;
  String error = "";

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final AuthentificationService verifie = AuthentificationService() ;
  void toggleView(){
  setState(() {
    formKey.currentState!.reset();
    error = "";
    fullnameController.text = "";
     universityController.text = "";
     emailController.text = "";
     passwordController.text = "";
     telController.text = "";
     showSignIn = !showSignIn;
  });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0.0,
        title:  Text(showSignIn ? 'Sign In' : 'Register'),
        actions: [
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text(showSignIn ? 'Register' : 'Sign In'),
            onPressed: () => toggleView(),

          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.0,),
            Form(
              key:formKey ,
              child: Column(
                children: [
                  showSignIn ? SizedBox(
                height: 0,) : Padding(padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller:fullnameController,
                      decoration: InputDecoration(
                        labelText: 'Full name',
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        ),

                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Write your full name';
                        }
                        return null;
                      },

                    ),
                  ),
                  showSignIn ? SizedBox(
                    height: 0,) : Padding(padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller:telController,
                      decoration: InputDecoration(
                        labelText: 'Tel :',
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        ),

                      ),
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Write your telephone number';
                        }
                        return null;
                      },

                    ),
                  ),
                  showSignIn ? SizedBox(height: 0.0,)
                      :Padding(padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller:universityController,
                      decoration: InputDecoration(
                        labelText: 'University',
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        ),

                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Write your university.If You don't study just write 'None'";
                        }
                        return null;
                      },
                      //
                    ),),

                  showSignIn ? SizedBox(height: 0.0,) :Text('If you dont study just write none ' ,style: TextStyle(color: Colors.grey),) ,
                  Padding(padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller:emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        ),

                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Write your email';
                        }
                        return null;
                      },

                    ),),
                  Padding(padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller:passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.all(Radius.circular(10.0)),

                        ),

                      ),
                      validator: (value){
                        if(value!.length<6){
                          return 'You should have more than 6 characters ';
                        }
                        return null;
                      },

                    ),)



                ],
              ),
            ),
            ElevatedButton(onPressed: ()async{

              if(formKey.currentState!.validate()){
                setState(() {
                  loading = true;
                });

               // dynamic result = showSignIn ? verifie.signInWithEmailAndPassword(emailController.text, passwordController.text)
               //     : verifie.

                if(showSignIn == true){
                  await verifie.signInWithEmailAndPassword(emailController.text, passwordController.text);
                  dynamic result = await verifie.signInWithEmailAndPassword(emailController.text, passwordController.text);
                  if(result == null){
                    error = "Email ou mot de passe non valide";
                  }
                }
              else{

                await verifie.createNewUser(emailController.text, passwordController.text, fullnameController.text, universityController.text ,telController.text);
                dynamic result =  await verifie.createNewUser(emailController.text, passwordController.text, fullnameController.text, universityController.text ,telController.text);
                if(result == null){
                  error = "Email ou mot de passe non valide";
                }
              }

               var uid =  FirebaseAuth.instance.currentUser.uid;

                print(
                    "le Uid est celui laaaa------------$uid---------------");
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Home(uid: uid)));

              }

            },
                child: showSignIn ? Text("Sign In") : Text("Register") ,
            ),

            Text(error , style: TextStyle(color: Colors.red , fontSize: 20.0),),
          ],
        ),
      ),
    );

  }


}

