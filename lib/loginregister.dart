import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging/loginas.dart';
import 'package:messaging/user/register.dart';
 
 class Loginregister extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Logreg();
  }
   
 }

 class Logreg extends State <Loginregister>{
    Future <bool> _SaveAndBack(){
           return showDialog(context: context,
           builder: (context)=> AlertDialog(title: Text('Do you want to exit the app?',style: GoogleFonts.aBeeZee(color:Colors.black),),
           actions: <Widget>[
             FlatButton(onPressed:()=>Navigator.pop(context,false), child: Text('No',style: GoogleFonts.aBeeZee(color:Colors.cyanAccent[300]),)
             ),
              FlatButton(onPressed:()=>Navigator.pop(context,true), child: Text('Yes',style: GoogleFonts.aBeeZee(color:Colors.cyanAccent[300])))
           ],
           ));
          
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
          child: Scaffold(
       backgroundColor: Color(0xff1f1f1f),
       body: Column(
         crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
         Text('WELCOME!', style: GoogleFonts.aBeeZee(fontSize:25, color:Colors.white),textAlign: TextAlign.left,),
               SizedBox(height: 20,),
           GestureDetector(
                                      child: Center(child: Card(color:Colors.blue[500],child: Container(height:40,width: 250,child: Center(child: Text("Login",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),))))),
                                      onTap: () {
                                        setState(() {
                                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginas()));
                                         print('hi');
                                         
                                        });
                                      
                                      },
                                    ),
                                  //  SizedBox(height: 5,),
            GestureDetector(
                                      child: Center(child: Card(color:Colors.blue[500],child: Container(height:40,width: 250,child: Center(child: Text("Register",style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),))))),
                                      onTap: () {
                                        setState(() {
                                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                                         print('hello');
                                        });
                                      
                                      },
                                    ),

         ],
       )

      ), onWillPop:_SaveAndBack,
    );
  }
   
 }