 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'Loading.dart';

class EventDetails extends StatefulWidget {
  final String id_event;
  const EventDetails ({Key ? key , required this.id_event}): super(key:key);
   @override
   _EventDetailsState createState() => _EventDetailsState(id_event);
 }
 
 class _EventDetailsState extends State<EventDetails> {

  String id_event;

  _EventDetailsState(this.id_event);

  final CollectionReference _userCollection = Firestore.instance.collection('users');


   @override
   Widget build(BuildContext context) {
     CollectionReference eventDetails = FirebaseFirestore.instance.collection('events');

     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.green,
         title: Text("Evènement"),
       ),
       body: FutureBuilder(
         future: eventDetails.doc(this.id_event).get(),
         builder: (BuildContext context ,AsyncSnapshot<DocumentSnapshot> snapshot){
           if(snapshot.hasError){
             return Text("Something went wrong");
           }
           if(snapshot.hasData && !snapshot.data!.exists){
             return Text("Document does not exist!");
           }

           if(snapshot.connectionState == ConnectionState.done){

             Map<String, dynamic> data = snapshot.data!.data();

                return SingleChildScrollView(


                child:  Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Card(
                        elevation: 15,
                        child: Container(
                      width: 380,
                      height: 200,
                      decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                              fit: BoxFit.cover,
                              image: new NetworkImage(
                         data['url_image_event'])))
                  ),

                ),SizedBox(height: 30,),
                      Container(
                        height: 100,
                        width: 400,
                        decoration: new BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                        child: Center(
                          child: Text("${data['title_event']}"),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        height: 200,
                        width: 400,
                        decoration: new BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.all(Radius.circular(15.0))
                        ),
                        child: new Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Center(
                              child:RichText(text:TextSpan(text: "${data['description_event']}",
                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                              ),
                              textAlign: TextAlign.justify),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 100,
                            decoration: new BoxDecoration(
                                color: Colors.yellowAccent,
                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                            ),
                            child: Center(
                              child: Text("${data['price_event']} RUB"),
                            ),
                          ),

                          Container(
                            height: 50,
                            width: 100,
                            decoration: new BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(15.0))
                            ),
                            child: Center(
                              child: Text("${data['Date_event']}"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                    ],
                  ),
                ));
           }
           return Loading();
         },
       ),
     );
   }
 }
 