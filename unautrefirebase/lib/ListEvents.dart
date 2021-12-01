


import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unautrefirebase/DatabaseManager.dart';
import 'package:unautrefirebase/homeScreen.dart';

import 'EventDetails.dart';
import 'Loading.dart';

class ListEvents extends StatefulWidget {


  @override
  _ListEventsState createState() => _ListEventsState();
}

class _ListEventsState extends State<ListEvents> {
  final CollectionReference event = FirebaseFirestore.instance.collection('events');
  List eventList = [];
  List idList = [];
  String uid = "";
  dynamic user ;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    getCurrentUserInfo();
  }



  void getCurrentUserInfo() async {
    user = await _auth.currentUser;
    uid = user.uid;

  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getEventList();
    dynamic resultatId = await DatabaseManager().getIdEvent();

    if (resultant == null) {
      print("Unable to retrive");
    } else {
      setState(() {
        idList = resultatId;
        eventList = resultant;
        print(eventList.length);
      });
    }
  }
  Future<void>participee(String uid, String id_event)async{
    var listparticipan = [uid];
    Firestore.instance.collection("events").doc(id_event).update({"participant":FieldValue.arrayUnion(listparticipan)});
  }

  check_if_Participe(String uid, List the_participants){
     bool verify = false;

     for(int i = 0 ; i< the_participants.length ; i++){
         if(uid == the_participants[i])
          {
            verify = true;

         }
     }

    return verify;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des evenements'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder(
        future: event.doc("PtmV3PGhiwWnr5d8gqDq").get(),
        builder: (BuildContext context ,AsyncSnapshot<DocumentSnapshot> snapshot ){
          if(snapshot.hasError){
            return Text("Something went wrong");
          }
          if(snapshot.hasData && !snapshot.data!.exists){
            return Text("Document does not exist!");
          }

          if(snapshot.connectionState == ConnectionState.done){
            return Container(
              child: ListView.builder(
                  itemCount: eventList.length,
                  itemBuilder: (context , index){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>EventDetails(id_event:idList[index])));
                      },
                      child: eventList[index]['event_archived'] == false ? Container(
                        height: eventList[index]['title_event'] !="" ? 200 : 0,
                        padding: EdgeInsets.all(5.0),
                        child:eventList[index]['title_event'] !="" ?  Card(
                          elevation: 5.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Padding(
                               padding: EdgeInsets.only(left: 20.0),
                               child:  Column(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   Text(eventList[index]['title_event']
                                   ),
                                   Text("${eventList[index]['price_event']} RUB"),
                                   Text("${eventList[index]['Date_event']}"),
                                   ElevatedButton(
                                     style: ElevatedButton.styleFrom(shape: StadiumBorder(),
                                        primary: Colors.red,
                                     ),
                                     onPressed: ()async{
                                       await DatabaseManager().archived(idList[index]);
                                       Navigator.pop(context);

                                     },
                                     child: Text("Archiver"),),

                                   check_if_Participe(uid, eventList[index]['participant']) !=true ? ElevatedButton(onPressed: (){
                                     participee(uid,idList[index]);
                                     ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(content: Text("Participation Enrégistré !!"))
                                     );
                                     Navigator.pop(context);
                                     Navigator.pushNamed(context, '/evenement');

                                   },
                                     style:ElevatedButton.styleFrom(
                                         shape: StadiumBorder(),

                                     ),
                                     child: Text("Participer"),

                                   ):  RaisedButton(onPressed: (){

                                   },
                                     child: Text("Inscrit(e)!!"),

                                   ),
                                 ],
                               ),
                             ),

                              SizedBox(width: 100,),
                              Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Container(
                                    width: 120,
                                    height: 120,
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        shape: BoxShape.rectangle,
                                        image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            image: new NetworkImage(
                                                eventList[index]['url_image_event'])))),
                              )

                            ],
                          ),
                        ):SizedBox(height: 0.0,),
                      ):SizedBox(height: 0.0,),
                    );
                  }
              ),
            );
         }
          return Loading();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/addEvent");
        },
        child: Icon(Icons.event),
      ),

    );

  }

//our faire la modification dun element de  la liste des evenement je recupere [index] de eventList[index] qui est reliee a une valeur de la
//data base .Je vais creer une fonction dans le onPressed du future RaisedButton
}

