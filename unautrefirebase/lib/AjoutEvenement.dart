import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:unautrefirebase/DatabaseManager.dart';
import 'package:unautrefirebase/ListEvents.dart';


class AjoutEvenement extends StatefulWidget {


  @override
  _AjoutEvenementState createState() => _AjoutEvenementState();
}

class _AjoutEvenementState extends State<AjoutEvenement> {
  //the key and the controllers for the form
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController() ;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  //static urlImage for none image
  static const IMAGE_URL = "https://www.smartsurvey.co.uk/wp-content/uploads/event-evaluation.jpg";

  final CollectionReference event = FirebaseFirestore.instance.collection('events');
  firebase_storage.FirebaseStorage _storage =   firebase_storage.FirebaseStorage.instance;
  File ? image;
  String filename = "";
  String urlImage = IMAGE_URL;
  ImagePicker picker = ImagePicker();
  int countElementEvent = 0;

    Future selectFile()async{
      // ignore: invalid_use_of_visible_for_testing_member

      var result = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        image = File(result.path);
      });

    }





  Future<void> addImageToFirebase(String title , String description , String price ,String date_event ) async {

    StorageReference ref = _storage.ref().child("Location/");
    firebase_storage.StorageUploadTask storageUploadTask = ref.child("${basename(image!.path)}").putFile(image);


    if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
      final String url = await ref.getDownloadURL();
      print("The download URL is " + url);
    } else if (storageUploadTask.isInProgress) {

      storageUploadTask.events.listen((event) {
        double percentage = 100*(event.snapshot.bytesTransferred.toDouble() / event.snapshot.totalByteCount.toDouble());
        print("The percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot =await storageUploadTask.onComplete;
      filename = await storageTaskSnapshot.ref.getDownloadURL();
      urlImage = filename;

      //Here you can get the download URL when the task has been completed.
      await DatabaseManager().addEvent(title, description, urlImage ,price , date_event);

      print("Download URL " + urlImage.toString());

    } else{
      //Catch any cases here that might come up like canceled, interrupted
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: formKey,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                child: image == null ?Image.network("$IMAGE_URL",
                  width:  400,
                  height: 300,
                ) : uploadArea(),
              ),
                formElement("Titre", titleController , 1 ,1 ,TextInputType.text),
                formElement("Description", descriptionController , 3,10,TextInputType.text),
                formElement("Prix",priceController, 1, 1 , TextInputType.number),
                formElement("Date Evenement",dateController, 1,1,TextInputType.datetime),
                RaisedButton(
                    child: Text("Valider" ,style: TextStyle(color: Colors.white),),
                    color: Colors.green,
                    onPressed: ()async{
                      if(formKey.currentState!.validate()){
                        // ignore: unnecessary_null_comparison
                        if(image != null ) {
                          addImageToFirebase(titleController.text,
                              descriptionController.text , priceController.text , dateController.text);
                        }else{
                          await DatabaseManager().addEvent(titleController.text, descriptionController.text, IMAGE_URL, priceController.text,dateController.text);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Evenement enrégistré !!"))
                        );
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context)=>ListEvents()));
                      }
                    }

                )
              ],
            ) ,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: ()  {
            selectFile();
          },
          child: Icon(Icons.image)

      ),
    );
  }

  Padding formElement(String label , TextEditingController controllerForm, int min_lines , int max_lines , TextInputType textInputType){
    return Padding(padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: controllerForm,
        decoration: InputDecoration(
            labelText: '$label'
        ),
        minLines: min_lines,
        maxLines: max_lines,
        keyboardType: textInputType,
        validator: (value){
          if(value!.isEmpty){
            return "$label est vide !!";
          }
          return null;
        },
      )
      ,);
  }
  Widget uploadArea(){
    return Column(
      children: [
        Image.file(image!,width: double.infinity,),

      ],
    );
  }
}
