
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unautrefirebase/DatabaseManager.dart';
import 'package:unautrefirebase/UserDetails.dart';

class ListUser extends StatefulWidget {


  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List userProfilesList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();

  }


  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUserList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
        print(userProfilesList.length);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des membres'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: userProfilesList.length,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(uid:userProfilesList[index]['uid'])));
              } ,
              child: Container(
                margin: EdgeInsets.all(7.5),
                child: Card(
                  elevation: 10.0,
                  child:Column(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 30),
                      child:Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          image: DecorationImage(image: NetworkImage(userProfilesList[index]['urlPic'])
                            
                          )
                        ),
                        
                      ) ,
                      ),

                      Text(userProfilesList[index]['full_name']),
                      Text(userProfilesList[index]['university']),
                    ],
                  ),

                ),
              )
            );
          },

        ),
      )
    );
  }
}
