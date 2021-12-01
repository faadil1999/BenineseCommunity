
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:unautrefirebase/AuthentificationService.dart';
import 'package:unautrefirebase/DatabaseManager.dart';
import 'package:unautrefirebase/ListUser.dart';
import 'package:unautrefirebase/authenticate_screen.dart';
import 'package:unautrefirebase/splashScreen.dart';

import 'User.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',//id
  'High Importance Notification',//title
  'This channel is used for important notification',//
  importance: Importance.High,
  playSound: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
        value: AuthentificationService().user,
        initialData: null,
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreenWrapper(),
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
        )
    );
  }

}

