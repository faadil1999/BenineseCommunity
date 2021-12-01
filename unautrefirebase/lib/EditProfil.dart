import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:unautrefirebase/DatabaseManager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:unautrefirebase/homeScreen.dart';

import 'home.dart';

class EditProfil extends StatefulWidget {
  final String uid;
  const EditProfil({Key? key , required this.uid}) : super(key: key);

  @override
  _EditProfilState createState() => _EditProfilState(this.uid);
}

class _EditProfilState extends State<EditProfil> {

  String uid;

  _EditProfilState(this.uid);

  firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage
      .instance;

  static const IMAGE_URL = "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  final formKey = GlobalKey<FormState>();
  final fullnameController = TextEditingController();
  final universityController = TextEditingController();
  final codeStatutController = TextEditingController();
  final passwordController = TextEditingController();
  final telController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File ? image;
  String statut = "";
  String fileUrl = "";


  Future selectFile() async {
    // ignore: invalid_use_of_visible_for_testing_member

    var result = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(result.path);
      fileUrl = result.path;
    });
  }


  Padding formEdit(String label, TextEditingController controllerEdit,
      TextInputType textInputType, String data) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: '$label',
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          hintText: data,
        ),

        keyboardType: textInputType,
        controller: controllerEdit,
        validator: (value) {
          if (value!.isEmpty) {
            return "$label est vide";
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference userDetails = FirebaseFirestore.instance.collection(
        'users');

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child:Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  children: [
                    formEdit('Nom Prenom', fullnameController, TextInputType.text,
                        'fullname'),
                    formEdit('Université', universityController, TextInputType.text,
                        'University'),
                    formEdit(
                        'Tel', telController, TextInputType.number, 'Phone number'),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Code Statut',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    10.0))
                            )
                        ),
                        keyboardType: TextInputType.text,
                        controller: codeStatutController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            statut = "Simple Membre";
                          }
                          else if (value == "pregunta966") {
                            statut = "President";
                          }
                          else if (value == "secree966") {
                            statut = "Sécrétaire";
                          }
                          else if (value == "caisse966") {
                            statut = "Trésorier";
                          }
                        },
                      ),
                    ),

                    ElevatedButton(onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print(fullnameController.text);
                        print(universityController.text);
                        print(telController.text);
                        print(statut);

                        DatabaseManager().updateUser(fullnameController.text,universityController.text,statut,telController.text,this.uid);

                        Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => Home(uid: this.uid )), (route) => false);
                      }
                    }, child: Text("Valider")),
                    SizedBox(height: 20,)
                  ],
                ),
              ),


              fileUrl != "" ? Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  child: Column(
                    children: [
                      Image.file(image! , height: 200, width: 200,),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed:(){
                          uploadUrlImage(uid, context);
                      },
                          child:Text("Modifier Photo"))
                    ],
                  ),
                ),
              ):     ElevatedButton(onPressed: (){
                selectFile();
              }, child: Text("Modifier Image")),
            ]
          ),
        ),
      ),

    );
  }

  Future <void> uploadUrlImage(String uid , BuildContext context) async {
    StorageReference ref = _storage.ref().child("Location/");
    firebase_storage.StorageUploadTask storageUploadTask = ref.child(
        "${basename(image!.path)}").putFile(image);

    if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
      final String url = await ref.getDownloadURL();
      print("The download URL is " + url);
    } else if (storageUploadTask.isInProgress) {
      storageUploadTask.events.listen((event) async {
        double percentage = 100 * (event.snapshot.bytesTransferred.toDouble() /
            event.snapshot.totalByteCount.toDouble());
        print("The percentage " + percentage.toString());

        if(percentage == 100.0){
          StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask
              .onComplete;
          fileUrl = await storageTaskSnapshot.ref.getDownloadURL();
          DatabaseManager().updateUserImage( uid, fileUrl);
          Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => Home(uid: this.uid )), (route) => false);

          print(fileUrl);
        }
      });



    }
  }

}
