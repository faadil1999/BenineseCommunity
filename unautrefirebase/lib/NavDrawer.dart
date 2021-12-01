import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unautrefirebase/AuthentificationService.dart';
import 'package:unautrefirebase/EditProfil.dart';
import 'package:unautrefirebase/authenticate_screen.dart';


class NavDrawer extends StatelessWidget{
  final String uid ;

  const NavDrawer({Key ? key , required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(child: Text('Menu',
            style: TextStyle(color: Colors.black , fontSize: 25),
          ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0) ,bottomRight: Radius.circular(20.0)) ,
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("images/coverBenin.jpg")
                )
            ),
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Articles'),
            onTap: (){
              Navigator.pushNamed(context, '/articles');
            },

          ),
          ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profil'),
              onTap: ()=> {Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfil(uid: this.uid)))}

          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Setting'),
            onTap: ()=> {Navigator.of(context).pop(),},

          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Deconnexion'),
            onTap: () async{
              await AuthentificationService().signOut();
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AuthenticateScreen()));
              },

          )
        ],
      ),
    );
  }


}