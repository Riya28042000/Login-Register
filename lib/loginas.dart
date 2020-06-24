import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging/admin/loginadmin.dart';
import 'package:messaging/loginregister.dart';
import 'package:messaging/user/loginuser.dart';

 
 class Loginas extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Loginas();
  }
   
 }

 class _Loginas extends State <Loginas>{
   void MoveToLastScreen() {
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
       backgroundColor: Color(0xff1f1f1f),
       body: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
          //  Padding(
          //    padding: const EdgeInsets.only(left: 10),
          //    child: Align(alignment: Alignment.topLeft,child: IconButton(icon: Icon(Icons.arrow_back,color: Colors.blue[900],), onPressed: () {Navigator.pop(context);},),),
          //  ),
         Text('Login As', style: GoogleFonts.aBeeZee(fontSize:25, color:Colors.white),textAlign: TextAlign.left,),
               SizedBox(height: 20,),
           GestureDetector(
                                      child: Center(child: Card(color:Colors.blue[500],child: Container(height:40,width: MediaQuery.of(context).size.width-150,child: Center(child: Text("Admin",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),))))),
                                      onTap: () {
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginAd()));
                                        setState(() {
                                         print('hi');
                                        });
                                      
                                      },
                                    ),
                                  //  SizedBox(height: 5,),
            GestureDetector(
                                      child: Center(child: Card(color:Colors.blue[500],child: Container(height:40,width: MediaQuery.of(context).size.width-150,child: Center(child: Text("User",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),))))),
                                      onTap: () {
                                        setState(() {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserAd()));
                                         print('hello');
                                        });
                                      
                                      },
                                    ),

         ],
       )

      ),
    );
  }
  
 }