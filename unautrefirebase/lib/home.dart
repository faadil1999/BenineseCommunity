import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unautrefirebase/AjoutEvenement.dart';
import 'package:unautrefirebase/CommunityArticles.dart';
import 'package:unautrefirebase/ListEvents.dart';

import 'package:unautrefirebase/ListUser.dart';
import 'package:unautrefirebase/Loading.dart';
import 'package:unautrefirebase/authenticate_screen.dart';
import 'package:unautrefirebase/caisseCommune.dart';

import 'package:unautrefirebase/homeScreen.dart';

import 'EventDetails.dart';
import 'NavDrawer.dart';
import 'modifierCaisse.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
final String uid ;

const Home({Key ?key ,  required this.uid }): super (key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute:'/',
      routes: {
        '/':(context)=>HomeScreen(uid: this.uid),
      },
      onGenerateRoute: (settings)=>RouteGenerator.genrateRoute(settings),
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.green,
      ),

      debugShowCheckedModeBanner: false,
    );
  }

}

class RouteGenerator{

  static Route<dynamic>genrateRoute(RouteSettings settings){

    switch(settings.name){
      case '//':
        return MaterialPageRoute(builder: (context)=> AuthenticateScreen());
       case'/evenement':
         return MaterialPageRoute(builder: (context)=>ListEvents());
      case '/addEvent':
        return MaterialPageRoute(builder: (context)=>AjoutEvenement());
      case '/listMember':
        return MaterialPageRoute(builder: (context)=>ListUser());
      case '/caisseCommune':
        return MaterialPageRoute(builder: (context)=> CaisseCommune());
      case '/caisseModif':
        return MaterialPageRoute(builder: (context)=>ModifieCaisse());
      case '/articles':
        return MaterialPageRoute(builder: (context)=>CommunityArticles());
      default:
        return MaterialPageRoute(builder: (context)=>Scaffold(
          appBar: AppBar(title: Text("Error"), centerTitle: true,),
          body: Center(
            child: Text("Page not found"),
          ),
        ));
    }
  }

}
