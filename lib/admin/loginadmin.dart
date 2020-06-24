import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging/admin/listadmin.dart';
import 'package:messaging/preferences/preference.dart';

class LoginAd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginAd();
  }
}
 GlobalKey<FormState> validatekey=GlobalKey<FormState>();
class _LoginAd extends State<LoginAd> {
  


  

   final _scaffoldKey = GlobalKey<ScaffoldState>();
   String username;
  String password;
  bool passwordVisible= true;
  bool isLoading= false;
  void signIn(){
    setState(() {
      isLoading=true;
    });
    HelperFunctions.saveAdminLoggedInSharedPreference(true);
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                                       HelperFunctions.saveAdminNameSharedPreference(username);
                                                
    new Future.delayed(const Duration(seconds: 4), () {
 setState(() {
   isLoading=false;
 });

Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatAd()));
});
   
  }
 
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) :Scaffold(
       key: _scaffoldKey,
      backgroundColor:  Color(0xff1f1f1f) ,
          body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: validatekey,
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // GestureDetector(
                      //   onTap: () {
                      //     setState(() {});
                      //   },
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left: 10),
                      //     child: Align(
                      //       alignment: Alignment.topLeft,
                      //       child: IconButton(
                      //           icon: Icon(
                      //           Icons.arrow_back,
                      //           color: Colors.blue[500],
                      //         ),
                      //         onPressed: (){
                      //           Navigator.pop(context);
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30, top: 30),
                        child: Text(' ADMIN', style: GoogleFonts.aBeeZee(fontSize:25, color:Colors.white),)
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Enter Username";
                            } else
                              return null;
                          },
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            // fillColor: Color(0xffefb168),
                            hintText: "Email",
                             alignLabelWithHint: true,
                            labelText: "Email",
                            hintStyle: GoogleFonts.aBeeZee(color:Colors.grey),
                           
                            labelStyle: GoogleFonts.aBeeZee(color:Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue[500],
                                  style: BorderStyle.solid,
                                  width: 1),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffffffff),
                                  style: BorderStyle.solid,
                                  width: 1),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onSaved: (value) {
                            username=value;
                          },
                        ),
                      ),
         
                      SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null) {
                              return "Enter Password";
                            } else
                              return null;
                          },
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.white,
                          obscureText: passwordVisible,
                          decoration: InputDecoration(
                            // fillColor: Color(0xffefb168),
                            hintText: "Password",
                            alignLabelWithHint: true,
                            labelText: "Password",
                             hintStyle: GoogleFonts.aBeeZee(color:Colors.grey),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon

                                  passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            labelStyle: GoogleFonts.aBeeZee(color:Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.blue[500],
                                  style: BorderStyle.solid,
                                  width: 1),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffffffff),
                                  style: BorderStyle.solid,
                                  width: 1),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onSaved: (value) {
                            password=value;
                          },
                        ),
                      ),
                       SizedBox(height: 10,),
                      GestureDetector(onTap: (){
                          print(username);
                                                validatekey.currentState.save();
                                                if(username?.isEmpty??true)
                                                {  _displaySnackBar(context, "Please enter your Email");
                                              
                                                }
                                 else if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(username))
                                    _displaySnackBar(context, "Please Fill valid Email");
                                                  else
                                                  if(password?.isEmpty??true)
                                                  _displaySnackBar(context, "Please enter your Password");
                                                  else
                                                  if(username.compareTo('admin@gmail.com')!=0 )
                                                   _displaySnackBar(context, "Incorrect Email");
                                                   else
                                                   if(password!='admin'){
                                                       _displaySnackBar(context, "Incorrect Password");
                                                   }

                                                  else{
                                                  signIn();
                                                  }
                                              },child: Card(color: Colors.blue[500],clipBehavior: Clip.antiAlias,child: Container(width: MediaQuery.of(context).size.width/1.5,child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(Icons.person,color: Colors.white,),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text("Login",style: GoogleFonts.aBeeZee(color: Colors.white,fontWeight: FontWeight.bold),),
                                                    ),
                                                  ],
                                                ),
                                              ))),),
                                              /*RaisedButton(
                                                onPressed: () {
                                                  loginFunction();
                                                },
                                                child: Text("Login"),
                                              )*/
                                            ],
                                          ),
                                  ),
                                        ),
                    
                  ))
                  );
    
  }
   _displaySnackBar(BuildContext context,String a) {
  final snackBar = SnackBar(content: Text(a,textAlign: TextAlign.center,style: GoogleFonts.aBeeZee(color:Colors.blue[500]),),backgroundColor: Colors.black,);
   _scaffoldKey.currentState.showSnackBar(snackBar);
}
}
