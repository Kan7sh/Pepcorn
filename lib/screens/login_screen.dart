// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pepcornsllp/screens/Home.dart';
import 'package:pepcornsllp/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var error=" ";
  void login()async{
    if(emailController.text.isEmpty||passwordController.text.isEmpty){
      setState(() {
        error="Please fill all the fields";
      });
    }else{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text
      );
      var sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool("login", true);
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>Home()) );
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = "Incorrect email or password";
      });
    }
  }
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset : false,
      body:Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xff3F72AF),
              Color(0xff112D4E),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  "assets/images/intro.gif",
                  height: 280,
                  width: 280,
                  fit: BoxFit.cover,
                )
            ),
            const SizedBox(height: 20,),
            const Text(
                "LOGIN",
              style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 25,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Email",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      fillColor: const Color(0xffDBE2EF),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      )
                  ),
                  controller: emailController,
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)
                ),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      fillColor: const Color(0xffDBE2EF),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      )
                  ),
                  controller: passwordController,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            Text(error,style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
            const SizedBox(height: 10,),
            SizedBox(
              height: 45,
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 4,
                  primary:const Color(0xffDBE2EF),
                  shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                  onPressed: ()=>login(),
                  child:const Text("LOGIN",style: TextStyle(color: Colors.black,fontSize: 17,),)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already a user?",style: TextStyle(fontWeight: FontWeight.bold),),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SignupScreen()));
                }, child: const Text("SignUp",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffDBE2EF)),))
              ],
            )

          ],
        ),
      ),
    );
  }
}
