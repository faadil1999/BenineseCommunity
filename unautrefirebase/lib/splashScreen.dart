import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:unautrefirebase/authenticate_screen.dart';
import 'package:unautrefirebase/homeScreen.dart';
import 'package:unautrefirebase/notification_service.dart';

import 'User.dart';
import 'home.dart';

class SplashScreenWrapper extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final user = Provider.of<AppUser?>(context);
  if(user == null){
    return AuthenticateScreen();
  }else{
    return NotificationService();
  }
//Home(uid: user.uid)
  }
}