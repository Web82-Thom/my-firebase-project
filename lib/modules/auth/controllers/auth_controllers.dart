import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myfirebaseproject/main.dart';
import 'package:myfirebaseproject/ressources/widgets/splash_screen.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';

class AuthController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  MyApp myApp = MyApp();
  bool isSignUp = false;
  bool isLogin = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signIn(BuildContext context) async{
    try{
      await auth.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
  
  Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
   
    initState();
  }

  @override
  void onReady() {
    onReady();
  }

  @override
  void close() {
    close();
  }
}
