
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pepcornsllp/screens/Home.dart';
import 'package:pepcornsllp/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pepcorns",
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
  super.initState();
  whereToGo();
}

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
  void whereToGo( )async{
    var sharedPred = await SharedPreferences.getInstance();
    var isLoggedIn=sharedPred.getBool("login");

    if(isLoggedIn!=null){

      if(isLoggedIn){

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      }else{

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
    }else{

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
  }

}



