import 'package:flutter/material.dart';
import'package:flutter/services.dart';
import 'package:messaging/admin/listadmin.dart';
import 'package:messaging/loginregister.dart';
import 'package:messaging/preferences/preference.dart';
import 'package:messaging/user/chatting.dart';
void main() {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(MyApp());
          });
      }
      class MyApp extends StatefulWidget {
        @override
        _MyAppState createState() => _MyAppState();
      }
      
      class _MyAppState extends State<MyApp> {
         bool userIsLoggedIn;
         bool adminIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    getLogedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value){
      setState(() {
        userIsLoggedIn  = value;
        print(value);
      });
    });
  //   HelperFunctions.saveAdminLoggedInSharedPreference(false);
  }

  getLogedInState() async {
    await HelperFunctions.getAdminLoggedInSharedPreference().then((value){
      setState(() {
        adminIsLoggedIn  = value;
        print(value);
      });
    });
  //r  HelperFunctions.saveUserLoggedInSharedPreference(false);
  }
//  Widget home(){

// if(userIsLoggedIn!=null && userIsLoggedIn ==true)
// {
//   return Chatting();
// }
// else if(userIsLoggedIn!=null && userIsLoggedIn ==false)
// {
//   return Loginregister();
// }
// else if(adminIsLoggedIn!=null && adminIsLoggedIn== true){
//   return ChatAd();
// }
// else if(adminIsLoggedIn!=null && adminIsLoggedIn==false)
// {
//   return Loginregister();
// }
//  }
 
        @override
        Widget build(BuildContext context) {
          return MaterialApp(
         builder: (context, child) {
    return ScrollConfiguration(
      behavior: MyBehavior(),
            child: child,
          );
        },
home: userIsLoggedIn != null ?  userIsLoggedIn ? Chatting() : (adminIsLoggedIn != null ?  adminIsLoggedIn ? ChatAd() : Loginregister(): Loginregister()) :Loginregister(),
   
   
          
          
          
                debugShowCheckedModeBanner: false,
        );
        }
      }
     
        class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

