import 'package:google_fonts/google_fonts.dart';
import 'package:messaging/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:messaging/user/loginuser.dart';

GlobalKey<FormState> validatekey = GlobalKey<FormState>();
final _scaffoldKey = GlobalKey<ScaffoldState>();
class Forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  String email;
AuthMethods authMethods= AuthMethods();

reset(String email) async {
   if (validatekey.currentState.validate()) {
   validatekey.currentState.reset();
      await authMethods.resetPass(email).then((onValue){
       _showVerifyEmailSentDialog();
      });
   }
}
 void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Reset Password"),
          content:
              new Text("Link to reset password has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => UserAd()),
        (Route<dynamic> route) => false);
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            SizedBox(height: 20.0),
         
            GestureDetector(
              onTap: () {
                validatekey.currentState.save();
                 
                                  if(email?.isEmpty??true)
                                  {  _displaySnackBar(context, "Please enter your Email");
                                
                                  }
                                   else if(!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email))
                                    _displaySnackBar(context, "Please Fill valid Email");
                                else
                                    {
                                     reset(email);
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
                            
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "OK",
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



