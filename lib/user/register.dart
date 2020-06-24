import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messaging/loginregister.dart';
import 'package:messaging/services/auth.dart';
import 'package:messaging/user/loginuser.dart';


class LogoutOverlay extends StatefulWidget {
      @override
      State<StatefulWidget> createState() => LogoutOverlayState();
    }

    class LogoutOverlayState extends State<LogoutOverlay>
        with SingleTickerProviderStateMixin {
      AnimationController controller;
      Animation<double> scaleAnimation;

      @override
      void initState() {
        super.initState();

        controller =
            AnimationController(vsync: this, duration: Duration(milliseconds: 450));
        scaleAnimation =
            CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

        controller.addListener(() {
          setState(() {});
        });

        controller.forward();
      }

      @override
      Widget build(BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(15.0),
                  height: 180.0,

                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20.0, right: 20.0),
                        child: Text(
                          "Successfully Registered!",
                          style: TextStyle(color: Colors.black, fontSize: 16.0,fontWeight: FontWeight.bold),
                        ),
                      )),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                        
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                            child:  ButtonTheme(
                                height: 35.0,
                                minWidth: 110.0,
                                child: RaisedButton(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  splashColor: Colors.white.withAlpha(40),
                                  child: Text(
                                    'OK',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Loginregister()),
        (Route<dynamic> route) => false);});
                                  },
                                ))
                          ),
                        ],
                      ))
                    ],
                  )),
            ),
          ),
        );
      }
    }



class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Register();
  }
}

GlobalKey<FormState> validatekey = GlobalKey<FormState>();
AuthMethods authMethods= AuthMethods();
  
   final databaseReference = Firestore.instance;
class _Register extends State<Register> with TickerProviderStateMixin {
   bool isLoading= false;
  String name;
  String username;
  String phone;
  String email;
  String pass;
  String conpass;
  bool isLoadind= false;
  bool passwordVisible = true;
  bool _passwordVisible = true;
 bool validateAndSave() {
    final FormState form = validatekey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
 sigMeUp(String email, String password) async{

    setState(() {
      isLoading=true;
    });

   await authMethods.signUpwithEmailAndPassword(email, password).then((value){
      // print("${value.userId}"),
      //upload data to firestore
     if(value!=null){
        // databaseReference.collection("users")
        // .document()
        // .setData({
        //   'name': name,
        //   'email': email,
        //   'username':username,
        //   'password':password,
        //   'phone': phone,
        // }).then((onValue){
        //   print('ghf');
        
        // });


        
         
    databaseReference.collection("users")
        .add({
          'name': name,
          'email': email,
          'username':username,
          'password':password,
          'phone': phone,
        }).then((onValue){
                   setState(() {
      isLoading=false;
    });
     showDialog(
        context: context,
        builder: (_) => LogoutOverlay(),
      ); 
        });
    //print(ref.documentID);
      
    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>UserAd()));
     
     }
     else{
        showAlertDialog(context);
setState(() {
      isLoading=false;
    });
     }
     
    });


  }
  

  
final _scaffoldKey = GlobalKey<ScaffoldState>();
  showAlertDialog(BuildContext context) {

  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.pop(context); },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Already Registered!"),
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
    return isLoading?Container(child: Center(child: CircularProgressIndicator(),),):Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Color(0xff1f1f1f),
    title: Text(
      'REGISTER',
      style:
          GoogleFonts.aBeeZee(fontSize: 20, color: Colors.blue[500]),
    ),
    centerTitle: true,
        ),
        backgroundColor: Color(0xff1f1f1f),
        body: SingleChildScrollView(
    child: Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Form(
                    key: validatekey,
                      child: Center(
                        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return "Enter Name";
                              } else
                                return null;
                            },
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              // fillColor: Color(0xffefb168),
                              hintText: "Name",
                              alignLabelWithHint: true,
                              labelText: "Name",
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
                              name = value;
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
                                return "Enter Username";
                              } else
                                return null;
                            },
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              // fillColor: Color(0xffefb168),
                              hintText: "Username",
                              alignLabelWithHint: true,
                              labelText: "Username",
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
                              username = value;
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
                                return "Enter Phone Number";
                              } else
                                return null;
                            },
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              // fillColor: Color(0xffefb168),
                              hintText: "Phone No",
                              alignLabelWithHint: true,
                              labelText: "Phone No",
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
                              phone = value;
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
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.text,
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
                            obscureText: passwordVisible,
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
                            obscureText: _passwordVisible,
                            decoration: InputDecoration(
                              // fillColor: Color(0xffefb168),
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
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              hintText: "Confirm Password",
                              alignLabelWithHint: true,
                              labelText: "Confirm Password",
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
                              conpass = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            validatekey.currentState.save();
                            if(name?.isEmpty??true) 
                            {
                               {  _displaySnackBar(context, "Please enter your Name");
                                              
                                                }
                            }
                            else
                            if(username?.isEmpty??true) 
                            {
                               {  _displaySnackBar(context, "Please enter your Username");
                                              
                                                }
                            }
                            else
                            if(phone?.isEmpty??true) 
                            {
                               {  _displaySnackBar(context, "Please enter your Phone Number");
                                              
                                                }
                            }
                            else
                            if(email?.isEmpty??true) 
                            {
                               {  _displaySnackBar(context, "Please enter your Email");
                                              
                                                }
                            }else
                            if(pass?.isEmpty??true) 
                            {
                               {  _displaySnackBar(context, "Please enter your Password");
                                              
                                                }
                            }else
                            if(conpass?.isEmpty??true) 
                            {
                               {  _displaySnackBar(context, "Re-Enter password");
                                              
                                                }
                            }
                             else  
                                        if(pass.compareTo(conpass)!=0){
                                               _displaySnackBar(context, "Entered Password's don't match.");
                                        }
                                         else
                                        if(pass.length<8)
                                        _displaySnackBar(context, "Password must be atleast 8 characters long");
                              else if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email))
                                        _displaySnackBar(context, "Please Fill valid Email");
                                         else
                                        if(phone.length!=10)
                                        {_displaySnackBar(context, "Please Fill a valid mobile no.");}
                                        else
                                      {
                                        
                                       sigMeUp(email,pass);
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
                                          Icons.people,
                                          color: Colors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Register",
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
                  ),
                      )),
                )))),
        ),
      );
  }
   _displaySnackBar(BuildContext context,String a) {
  final snackBar = SnackBar(content: Text(a,textAlign: TextAlign.center,style: GoogleFonts.aBeeZee(color:Colors.blue[500]),),backgroundColor: Colors.black,);
   _scaffoldKey.currentState.showSnackBar(snackBar);
}
}
