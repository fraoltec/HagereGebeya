import 'package:flutter/material.dart';
import 'package:shopapp_tut/commons/common.dart';
import 'package:shopapp_tut/pages/home.dart';
import 'package:shopapp_tut/pages/splash.dart';
import 'package:shopapp_tut/provider/user_provider.dart';
import './pages/login.dart';
import 'package:provider/provider.dart';
import 'package:shopapp_tut/provider/user_provider.dart';

void main() {

  runApp(ChangeNotifierProvider(builder: (_)=>UserProvider.initialize(),
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: deepOrange 
      ),
      home: ScreenController(),
  ),

  ));
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    
     switch(user.status){
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}

