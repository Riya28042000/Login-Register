import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging/loginas.dart';
import 'package:messaging/loginregister.dart';
import 'package:messaging/preferences/preference.dart';
import 'package:messaging/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Chatting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Chatting();
  }
  
}
class _Chatting extends State <Chatting>{
  AuthMethods authMethods= new AuthMethods();
  void logoutUser()async{
 HelperFunctions.saveUserLoggedInSharedPreference(false);
  Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Loginregister()),
        (Route<dynamic> route) => false);
}
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xff1f1f1f),
        appBar:  AppBar(backgroundColor: Color(0xff1f1f1f),
    automaticallyImplyLeading: false,
    title: Text('WELCOME',style: GoogleFonts.aBeeZee(color:Colors.blue[500],fontWeight: FontWeight.bold,fontSize: 20),),
    centerTitle: true,
    actions: <Widget>[
    GestureDetector(
      onTap:(){
           logoutUser();
      },
      child: Container(padding: EdgeInsets.symmetric(horizontal:16),
      child: Icon(Icons.exit_to_app,color: Colors.white,),
      ),
      
    )
    ],
    ),
    body: Center(
      child: Text('WELCOME TO THE USER SIDE!',style: GoogleFonts.aBeeZee(color:Colors.white,fontWeight:FontWeight.bold,fontSize:18 ),),
    ),
      );
  }
  
}