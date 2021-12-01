import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:unautrefirebase/Loading.dart';

class CaisseCommune extends StatefulWidget {


  @override
  _CaisseCommuneState createState() => _CaisseCommuneState();
}

CollectionReference caisse = FirebaseFirestore.instance.collection('caisse commune');

class _CaisseCommuneState extends State<CaisseCommune> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Caisse Commune'),
      ),
      body: FutureBuilder(
        future: caisse.doc('YuRHYB9fCAtzeUPY7GYt').get(),
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
            return Container(

                child: Center(
                  child: Card(
                      elevation: 15.0,
                      child: Container(
                        height: 400.0,
                        width: 300.0,
                        child: Column(
                          children: [
                            SizedBox(height: 135.0,),
                            Card(
                              elevation: 5.0,
                              child: Text("${data['montant']} RUB",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          SizedBox(height: 20.0,),
                          RaisedButton(onPressed:  (){
                            Navigator.pushNamed(context, '/caisseModif');
                          },
                            child: Text("Modifiez montant"),
                            color: Colors.green,
                          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          )
                          ],
                        ),
                      )
                  ),
                )
              );

          }
          return Loading();
        },
      )
    );
  }
}
