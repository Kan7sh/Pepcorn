// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pepcornsllp/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmPasswordController=TextEditingController();
  String error="";
  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
  void signup()async{
    if(passwordController.text.isEmpty||confirmPasswordController.text.isEmpty||nameController.text.isEmpty||emailController.text.isEmpty){
      setState(() {
        error="Please fill all the fields";
      });
    }else {
      if (passwordController.text != confirmPasswordController.text) {
        setState(() {
          error = "Password doesn't match";
        });
      } else {
        try {
          final credential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text,
          );
          var sharedPref = await SharedPreferences.getInstance();
          sharedPref.setBool("login", true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => const Home()));
        } on FirebaseAuthException catch (e) {
          setState(() {
            error = e.message.toString();
          });
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Container(
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
            const SizedBox(height: 60,),
            ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  "assets/images/intro.gif",
                  height: 250,
                  width: 250,
                  fit: BoxFit.cover,
                )
            ),
            const SizedBox(height: 14,),
            const Text(
              "SIGN UP",
              style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28)
                ),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Name",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      fillColor: const Color(0xffDBE2EF),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      )
                  ),
                  controller: nameController,
                ),
              ),
            ),
            const SizedBox(height: 10,),
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
                      hintText: "Confirm password",
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                      fillColor: const Color(0xffDBE2EF),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(28),
                      )
                  ),
                  controller: confirmPasswordController,
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
                  onPressed: ()=>signup(),
                  child:const Text("SIGN UP",style: TextStyle(color: Colors.black,fontSize: 17,),)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already Have account?",style: TextStyle(fontWeight: FontWeight.bold),),
                TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                }, child: const Text("Login",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xffDBE2EF)),))
              ],
            )
          ],
        ),
      ),
    );
  }
}
