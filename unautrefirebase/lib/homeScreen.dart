import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unautrefirebase/Loading.dart';

import 'NavDrawer.dart';

class HomeScreen extends StatefulWidget {
  final String uid ;

  const HomeScreen({Key ? key , required this.uid}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(uid);
}

class _HomeScreenState extends State<HomeScreen> {
  String uid;
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String userEmail ="";
  String userPhoneNumber="";

  _HomeScreenState(this.uid);
  @override
  void initState() {
    super.initState();
    getCurrentUserInfo();
  }

Future<void> _refresh() async {
    return Future.delayed(
      Duration(seconds: 3),
    );
}

  void getCurrentUserInfo() async {
    user = await _auth.currentUser;
    userEmail = user.email;

  }

  @override
  Widget build(BuildContext context) {
    CollectionReference userDetails = FirebaseFirestore.instance.collection(
        "users");

    return Scaffold(
        drawer: NavDrawer(uid:this.uid),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Membre"),
        ),
        body: RefreshIndicator(onRefresh: _refresh,
          child: FutureBuilder(
            future: userDetails.doc(this.uid).get(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist!");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!.data();
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: 15.0, top: 10.0, right: 15.0),
                        child: Card(
                          color: Colors.green[200],
                          elevation: 10.0,
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 42, right: 5.0),
                                  child: Image.network(
                                    "https://enseignementsuperieur.gouv.bj/images/armoiries2.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "AEBR SPB",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 31.0),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 5.0,right: 5.0),
                                  child: Image.network(
                                    "https://enseignementsuperieur.gouv.bj/images/armoiries2.png",
                                    height: 50,
                                    width: 50,
                                  ),
                                ),


                              ],
                            ),
                            height: 150,
                            width: 400.0,
                          ),

                        ),
                      ),
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            child: FittedBox(
                              fit: BoxFit.fill,
                              alignment: Alignment.topCenter,
                              child: Row(
                                children: [

                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 20),
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.green.shade400,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/listMember');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text("List des \nmembres",
                                              style: TextStyle(fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 10,),

                                            Text("membres", style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                      width: 150,
                                      margin: EdgeInsets.only(right: 20),
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow.shade200,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: FlatButton(
                                        onPressed: () {

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text("Historique ",
                                                style: TextStyle(fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(height: 10,),
                                              Text("2 mandats", style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      )
                                  ),

                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 20),
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.red.shade400,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: FlatButton(
                                      onPressed: () {

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text("Membre du \nbureau",
                                              style: TextStyle(fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 10,),
                                            Text("4 membres", style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                      width: 150,
                                      margin: EdgeInsets.only(right: 20),
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade200,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0))),
                                      child: FlatButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, "/evenement");
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text("Evenement",
                                                style: TextStyle(fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(height: 10,),

                                            ],
                                          ),
                                        ),
                                      )
                                  ),

                                  Container(
                                    width: 150,
                                    margin: EdgeInsets.only(right: 20),
                                    height: 150,
                                    decoration: BoxDecoration(
                                        color: Colors.yellow.shade400,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/caisseCommune');
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text("Caisse commune",
                                              style: TextStyle(fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 10,),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),

                        child: Container(
                            height: 100,
                            width:400,
                            decoration: BoxDecoration(
                                color: data['due'] == 0 ? Colors.green : Colors.red.shade400 ,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0)
                                )),
                            child:Center(
                              child:  data['due'] == 0 ? Text(" Vous ètes à jour " , style: TextStyle(fontSize: 20.0),) : Text("Vous n'ètes pas à jour !!\n Vous devez payer ${data['due']} RUB",style: TextStyle(fontSize: 20.0),) ,
                            )
                        ),),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, top: 10.0),
                        child: Card(
                          color: Colors.green[200],
                          elevation: 10.0,
                          child: Container(
                            child: Column(

                              children: [

                                Card(
                                  elevation: 10.0,
                                  child: Container(
                                      height: 60.0,
                                      width: 400.0,
                                      padding: EdgeInsets.all(15.0),
                                      child: labeltexte(data['full_name'])
                                  ),
                                ),
                                Card(
                                  elevation: 10.0,
                                  child: Container(
                                    height: 60.0,
                                    width: 400.0,
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Email : $userEmail " ,style: TextStyle(color: Colors.green ,fontSize: 20.0),),
                                  ),
                                ),
                                Card(
                                  elevation: 10.0,
                                  child: Container(
                                    height: 60.0,
                                    width: 400.0,
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Telephone : ${data['tel']} " , style: TextStyle(color: Colors.green ,fontSize: 20.0)),
                                  ),
                                ),
                                Card(
                                  elevation: 10.0,
                                  child: Container(
                                    height: 60.0,
                                    width: 400.0,
                                    padding: EdgeInsets.all(15.0),
                                    child: Text("Université : ${data['university']} " , style: TextStyle(color: Colors.green ,fontSize: 20.0)),
                                  ),
                                ),
                                SizedBox(height: 20.0,),
                                Container(
                                  height: 275,
                                  width: 275,

                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      image: new DecorationImage(
                                          fit:BoxFit.cover,
                                          image: new NetworkImage(data['urlPic']))
                                  ),

                                ),

                              ],
                            ),
                            height: 600,
                            width: 400.0,
                          ),

                        ),
                      )
                    ],
                  ),
                );
              }
              return Loading();
            },
          ),
        ),
    );
  }

  Text labeltexte(String text){
    return Text(text ,style:GoogleFonts.lato(fontSize: 20.0 ,)
    );
  }
}

