
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Loading.dart';

class UserDetails extends StatefulWidget {
  final String uid;
  const UserDetails({Key ? key , required this.uid}) : super(key: key);

  @override
  _UserDetailsState createState() => _UserDetailsState( uid);
}

class _UserDetailsState extends State<UserDetails> {
  late String uid;

  _UserDetailsState(this.uid);


  String email = "";
  @override
  void initState() {
    super.initState();

  }



  fetchuserDetail()async{
     DocumentSnapshot result = await FirebaseFirestore.instance.collection('user').doc(this.uid).get();

     if(result == null){
       print("Error Loading");
       return null;
     }

  }



  @override
  Widget build(BuildContext context) {
    CollectionReference userDetails = FirebaseFirestore.instance.collection("users");


    return Scaffold(
      appBar: AppBar(
        title: Text(this.uid),
      ),
      body: FutureBuilder(
        future: userDetails.doc(this.uid).get(),
        builder:
        (BuildContext context , AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasError){
            return Text("Something went wrong");
          }
          if(snapshot.hasData && !snapshot.data!.exists){
            return Text("Document does not exist!");
          }

          if(snapshot.connectionState == ConnectionState.done){
            Map<String, dynamic> data = snapshot.data!.data();
            return Text("${data['full_name']}");
          }
          return Loading();
        },

    )
    );
  }
}
