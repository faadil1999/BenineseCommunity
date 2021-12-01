
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unautrefirebase/Loading.dart';
import 'package:unautrefirebase/caisseCommune.dart';

class ModifieCaisse extends StatefulWidget {

  @override
  _ModifieCaisse createState() => _ModifieCaisse();
}

class _ModifieCaisse extends State<ModifieCaisse> {

 final TextEditingController montantController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  String error = "";
 CollectionReference caisseCom = FirebaseFirestore.instance.collection('caisse commune');



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caisse Commune"),
        backgroundColor: Colors.green,
      ),
        backgroundColor: Colors.green,
        body: Center(
          child: Form(
            key: formkey,
            child:Container(
              height: 400.0,
              width: 350.0,
              child: Card(
                elevation: 10.0,
                child: Column(
                  children: [
                   Padding(padding: EdgeInsets.all(15.0) ,
                     child: TextFormField(
                       controller: montantController,
                       keyboardType: TextInputType.number,
                       decoration: InputDecoration(
                         labelText: 'Dieu voit tout le monde!!!!',
                       ),
                       validator: (value){
                         if(value!.isEmpty){
                           return 'Le montant est null!!';
                         }
                       },
                     ) , ),
                    Padding(padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 15.0 , right: 65.0),
                          child: RaisedButton(onPressed:  ()async{
                            //print(int.parse(montantController.text) );
                            if(formkey.currentState!.validate()){
                              double resultat = 0.0;
                              DocumentSnapshot caissemontant = await FirebaseFirestore.instance.collection('caisse commune').doc('YuRHYB9fCAtzeUPY7GYt').get();
                              resultat = caissemontant.get('montant') + double.parse(montantController.text);
                              caisseCom.doc('YuRHYB9fCAtzeUPY7GYt').update({
                                'montant': resultat,
                              });
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context)=>CaisseCommune()));
                            }
                          },
                            child: Text("Ajouter"),
                            color: Colors.blueAccent,
                            shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          ),),
                        Padding(padding: EdgeInsets.only(left: 15.0 , right: 1.0),
                        child: RaisedButton(onPressed:  ()async{
                          if(formkey.currentState!.validate()){
                            double resultat = 0.0;
                            DocumentSnapshot caissemontant = await FirebaseFirestore.instance.collection('caisse commune').doc('YuRHYB9fCAtzeUPY7GYt').get();
                            if(double.parse(montantController.text) < caissemontant.get('montant')){
                              resultat  = caissemontant.get('montant') - double.parse(montantController.text);
                              caisseCom.doc('YuRHYB9fCAtzeUPY7GYt').update({
                                'montant': resultat,
                              });
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context)=>CaisseCommune()));
                            }
                            else{
                              alert();
                            }

                          }

                        },
                          child: Text("Soustraire"),
                          color: Colors.red,
                          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        ),),

                        SizedBox(height: 15.0,),

                      ],
                    ),),

                  ],
                )
                ,
              ),
              )
          ),
        ),
    );
  }
  
void changeCaisseCommune(int montant , String operation) async{
    var resultat = 0;
    if(operation == '-'){
      DocumentSnapshot caissemontant = await FirebaseFirestore.instance.collection('caisse commune').doc('YuRHYB9fCAtzeUPY7GYt').get();
      resultat =  caissemontant.get('montant') - montant;
      caisseCom.doc('YuRHYB9fCAtzeUPY7GYt').update({
        'montant': resultat,
      });


    }
    else if( operation == '+')
      {
        DocumentSnapshot caissemontant = await FirebaseFirestore.instance.collection('caisse commune').doc('YuRHYB9fCAtzeUPY7GYt').get();
        resultat =  caissemontant.get('montant') + montant;
        caisseCom.doc('YuRHYB9fCAtzeUPY7GYt').update({
          'montant': resultat,
        });
      }
    
}

Future<Null> alert()async{
  return showDialog(context: context,
      builder: (BuildContext context){
      return new AlertDialog(
        title: Text("Erreur Montant!!" ,
        textScaleFactor: 2,),
        titleTextStyle: new TextStyle(color: Colors.red),
        backgroundColor: Colors.white,
        content: Text("Le montant que vous avez mit est superieur au montant disponible" ,
        textScaleFactor: 1.2,),
        contentTextStyle: new TextStyle(color: Colors.red),
        actions: [
          new FlatButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Ok"))
        ],
      );
      });

 }

}
