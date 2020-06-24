import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging/loginregister.dart';
import 'package:messaging/preferences/preference.dart';
class ChatAd extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatAd();
  }
  
}
class _ChatAd extends State <ChatAd>{
  void MoveToLastScreen(){
           showDialog(context: context,
           builder: (context)=> AlertDialog(title: Text('Logout from app',style: GoogleFonts.aBeeZee(color:Colors.black),),
           actions: <Widget>[
             FlatButton(onPressed:()=>Navigator.pop(context,false), child: Text('OK',style: GoogleFonts.aBeeZee(color:Colors.cyanAccent[300]),)
             ),
            
           ],
           ));
          
  }
 void logoutAdmin()async{
 HelperFunctions.saveAdminLoggedInSharedPreference(false);
  Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Loginregister()),
        (Route<dynamic> route) => false);
}
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        MoveToLastScreen();
      },
          child: Scaffold(
        backgroundColor:  Color(0xff1f1f1f),
        appBar: AppBar(backgroundColor: Color(0xff1f1f1f),
        automaticallyImplyLeading: false,
        title: Text('WELCOME',style: GoogleFonts.aBeeZee(color:Colors.blue[500],fontWeight: FontWeight.bold,fontSize: 20),),
        centerTitle: true,
        actions: <Widget>[
         GestureDetector(
      onTap:(){
           logoutAdmin();
      },
      child: Container(padding: EdgeInsets.symmetric(horizontal:16),
      child: Icon(Icons.exit_to_app,color: Colors.white,),
      ),
      
    )
        ],
        ),
        body: Center(
          child: Text('WELCOME TO THE ADMIN SIDE!',style: GoogleFonts.aBeeZee(color:Colors.white,fontSize:18,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
  
}