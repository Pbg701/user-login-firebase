import 'dart:developer';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'package:user_registration/view/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_registration/view/register_screen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State createState() => _LoginscreenState();
}

class _LoginscreenState extends State {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //String? myName;
  // String? myPassword;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              // Color.fromARGB(255, 198, 21, 151),
              Color.fromARGB(255, 245, 69, 128),
              Color.fromARGB(255, 225, 162, 216),
              Color.fromARGB(255, 235, 218, 231)
            ])),
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: const Text(
                          "Welcome Back",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                      FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: const Text(
                          "Login !",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: 900,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          FadeInUp(
                            duration: const Duration(milliseconds: 1400),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 125, 3, 147)
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: _emailController,
                                        style: const TextStyle(fontSize: 20),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.person),
                                          hintText: "Enter Name",
                                          hintStyle: const TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 228, 198, 222),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 239, 197, 231),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color.fromARGB(
                                                    255, 125, 3, 147)
                                                .withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: TextField(
                                        controller: _passwordController,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          prefixIcon:
                                              const Icon(Icons.password_sharp),
                                          hintText: "Enter Password",
                                          hintStyle: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 228, 198, 222),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 239, 197, 231),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FadeInUp(
                                    duration:
                                        const Duration(milliseconds: 1600),
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (_emailController.text
                                                .trim()
                                                .isNotEmpty &&
                                            _passwordController.text
                                                .trim()
                                                .isNotEmpty) {
                                          try {
                                            UserCredential userCredential =
                                                await _auth
                                                    .signInWithEmailAndPassword(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            );
                                            log("USER CREDENTIALS : $userCredential");
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    content: Text(
                                                        "User Login Succeessful"),),);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const HomeScreen()));
                                          } on FirebaseAuthException catch (error) {
                                            log(error.code);
                                            log("$error.message");
                                            
                                          }
                                        } else {
                                          print("PLEASE ENTER VALID FIELDS");
                                        }
                                      },
                                      height: 50,
                                      color: const Color.fromARGB(
                                          255, 245, 69, 128),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Login   ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Siginscreen()));
                                    },
                                    child: const Text(
                                      "Create New Account ? SignUp",
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
