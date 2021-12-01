
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{

  final CollectionReference profilList = FirebaseFirestore.instance.collection('users');
  final CollectionReference event = FirebaseFirestore.instance.collection('events');

  Future<void> createUserData(String full_name , String university , String tel ,String uid )async {
      return await profilList.doc(uid).set({
        'uid':uid,
        'full_name':full_name,
        'university':university,
        'due':0,
        'tel':tel,
        'statut':'Simple Membre',
        'urlPic':'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
      });
  }

  Future updateUser(String fullname , String university , String statut ,String tel , String uid )async{
    return await profilList.doc(uid).update({
      'full_name':fullname ,
      'university':university,
      'tel':tel,
      'statut':statut,

    });
  }

  Future updateUserImage(String uid  , String urlPic)async{
    return await profilList.doc(uid).update({
      'urlPic':urlPic,
    });
  }




  Future getUserList()async{
    List itemList = [];

    try{
      await profilList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((DocumentSnapshot doc){
          print(doc.id);
        });
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data());
        });
      } );
    return itemList;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future addEvent(String titleEvent , String descriptionEvent , String urlImage ,String price , String dateevent)async{


    return await event.add({
      'description_event':descriptionEvent,
      'title_event':titleEvent,
      'event_archived':false ,
      'url_image_event':urlImage,
      'price_event': price,
      'Date_event':dateevent,
      'participant':[],

    }).then((value) => print("Value Added $urlImage")).catchError((error)=>print("Failed to add data $error"));

  }

  Future getEventList () async{
    List itemList = [];
    try{
      await event.get().then((query){

        query.docs.forEach((element) {
          itemList.add(element.data());
        });
      });
      return itemList;
    }catch(e){
      print(e.toString());
      return null;
      }
  }

  Future archived(String id) async{
      event.doc(id).update({
        'event_archived': true,
      });
  }


  Future getIdEvent() async {
    List idList = [];
    try{
      await event.get().then((query){
        query.docs.forEach((DocumentSnapshot doc){
          idList.add(doc.id);
        });

      });
      return idList;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}