import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging/preferences/preference.dart';
import 'package:messaging/services/auth.dart';
import 'package:messaging/user/chatting.dart';
import 'package:messaging/user/forgotpass.dart';
import 'package:shared_preferences/shared_preferences.dart';



class UserAd extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserAd();
  }
}



class _UserAd extends State<UserAd> {

  GlobalKey<FormState> validatekey = GlobalKey<FormState>();
AuthMethods authMethods= AuthMethods();
AuthMethods authService = new AuthMethods();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username;
  String email;
  String pass;
  bool passwordVisible = true;
  bool isLoading=false;
  
  


   bool validateAndSave() {
    final FormState form = validatekey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

signMeIn(String email, String pass) async {
    if (validatekey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInwithEmailAndPassword(email,pass).then((value) async {

      if(value!=null){
          setState(() {
        isLoading = true;
      });
    
           HelperFunctions.saveUserLoggedInSharedPreference(true);
           HelperFunctions.saveAdminLoggedInSharedPreference(false);
       HelperFunctions.saveUserEmailSharedPreference(email);
           Navigator.of(context).pushAndRemoveUntil(
                    
        MaterialPageRoute(builder: (context) =>Chatting()),
        (Route<dynamic> route) => false);
        setState(() {
        isLoading = false;
      });

      }
      else
     showAlertDialog(context);
      setState(() {
        isLoading = false;
      });

      });

    }
  }
 

showAlertDialog(BuildContext context) {

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pop(context); },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Invalid Details!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) :Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xff1f1f1f),
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
            // Padding(
            //     padding: EdgeInsets.only(bottom: 30, top: 30),
            //     child: Text(
            //       ' USER',
            //       style: GoogleFonts.aBeeZee(
            //           fontSize: 25, color: Colors.white),
            //     )),
            // Padding(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10.0),
            //   child: TextFormField(
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //     validator: (value) {
            //       if (value == null) {
            //         return "Enter Username";
            //       } else
            //         return null;
            //     },
            //     cursorColor: Colors.white,
            //     keyboardType: TextInputType.text,
            //     decoration: InputDecoration(
            //       // fillColor: Color(0xffefb168),
            //       hintText: "Username",
            //       alignLabelWithHint: true,
            //       labelText: "Username",
            //       hintStyle:
            //           GoogleFonts.aBeeZee(color: Colors.grey),

            //       labelStyle:
            //           GoogleFonts.aBeeZee(color: Colors.white),
            //       enabledBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //             color: Colors.blue[500],
            //             style: BorderStyle.solid,
            //             width: 1),
            //         borderRadius: BorderRadius.circular(15.0),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderSide: BorderSide(
            //             color: Color(0xffffffff),
            //             style: BorderStyle.solid,
            //             width: 1),
            //         borderRadius: BorderRadius.circular(25.0),
            //       ),
            //     ),
            //     onSaved: (value) {
            //       username = value;
            //     },
            //   ),
            // ),
            // SizedBox(height: 10.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                ),
                validator: (value) {
                  if (value == null) {
                    return "Enter Email";
                  } else
                    return null;
                },
                keyboardType: TextInputType.text,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  // fillColor: Color(0xffefb168),
                  hintText: "Email",
                  alignLabelWithHint: true,
                  labelText: "Email",
                  hintStyle:
                      GoogleFonts.aBeeZee(color: Colors.grey),

                  labelStyle:
                      GoogleFonts.aBeeZee(color: Colors.white),
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
                  email = value;
                },
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                  hintStyle:
                      GoogleFonts.aBeeZee(color: Colors.grey),
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
                  labelStyle:
                      GoogleFonts.aBeeZee(color: Colors.white),
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
                  pass = value;
                },
              ),
            ),
            GestureDetector(
              onTap:(){
 Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Forgot()),
        (Route<dynamic> route) => false);
              },
           child:   Padding(
             padding: const EdgeInsets.all(8.0),
             child: Align(alignment: Alignment.bottomRight,child: Text('Forgot Password?',style:GoogleFonts.aBeeZee(color: Colors.white)),),
           )
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                validatekey.currentState.save();
                 
                                  if(email?.isEmpty??true)
                                  {  _displaySnackBar(context, "Please enter your Email");
                                
                                  }
                                  else
                                  if(pass?.isEmpty??true)
                                  {  _displaySnackBar(context, "Please enter your Password");
                                
                                  }
                                   
                          else if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email))
                                    _displaySnackBar(context, "Please Fill valid Email");
                                else
                                    {
                                     signMeIn(email,pass);
                                    }
              },
              child: Card(
                  color: Colors.blue[500],
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                      width:
                          MediaQuery.of(context).size.width / 1.5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          crossAxisAlignment:
                              CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Login",
                                style: GoogleFonts.aBeeZee(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ))),
            ),
          ],
        ))))),
    );
  }

  _displaySnackBar(BuildContext context, String a) {
    final snackBar = SnackBar(
      content: Text(
        a,
        textAlign: TextAlign.center,
        style: GoogleFonts.aBeeZee(color: Colors.blue[500]),
      ),
      backgroundColor: Colors.black,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

}
