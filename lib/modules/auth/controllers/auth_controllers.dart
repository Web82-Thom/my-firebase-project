import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myfirebaseproject/main.dart';
import 'package:myfirebaseproject/ressources/widgets/snackBar_auth.dart';
import 'package:myfirebaseproject/ressources/widgets/splash_screen.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';

class AuthController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  MyApp myApp = MyApp();
  bool isSignUp = false;
  bool isLogin = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  // final confirmPasswordController = TextEditingController();

  void userState() {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print("User is currently signed out");
        Get.toNamed(Routes.AUTH);
      } else{
        Get.toNamed(Routes.HOME);
      }
    });
  }
  Future<void> signIn() async{
    try{
      await auth.signInWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    ).whenComplete(() => userState());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
  
  Future signOut() async{
    await FirebaseAuth.instance.signOut();
    Get.toNamed(Routes.AUTH);
  }

  Future<void> signUp() async{
    try{
      await auth.createUserWithEmailAndPassword(
      email: emailController.text, 
      password: passwordController.text,
    ).whenComplete(() => userState());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }

  //-----RESET PASSWORD-----//
  Future sendResetPassword(String email) async{
    if(email.isEmpty || !email.contains('@')) {
      Utils.showSnackBar("Veuillez entrer votre Email valide");
    } else {
      try {
      await auth.sendPasswordResetEmail(email: email).then((value) => email).whenComplete(() {
        Utils.showSnackBar("Email envoyer!");
        Get.toNamed(Routes.AUTH);
      });
      

    } on FirebaseAuthException catch (e) {
       if (e.message == 'There is no user record corresponding to this identifier.The user may have been deleted.'){ 
        Utils.showSnackBar(
        "Aucun email enregistrer dans la base de donnée où l'utilsateur a été supprimer"
      ); } else { 
      Utils.showSnackBar(
        e.message
      );}
    }
    }
    
  }
  
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    notifyListeners();
    super.dispose();
  }

  @override
  void initState() {
    userState();
   notifyListeners();
    initState();
  }

  @override
  void onReady() {
   notifyListeners();

    onReady();
  }

  @override
  void close() {
    close();
  }
}

// if (e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.'){ 
//         Utils.showSnackBar("Email inconnu dans la base de donnée où l'utilsateur a été supprimer. Veuiller créer un compte."); 
//       } else if (e.message == "The email address is badly formatted."){ 
//         Utils.showSnackBar("Email invalide, veuillez entrer un email au bon format."); 
//       } else if (e.message == "Given String is empty or null"){ 
//         Utils.showSnackBar("Entrer votre mot de passe, minimum 8 caractères."); 
//       } else if (e.message == "The password is invalid or the user does not have a password."){ 
//         Utils.showSnackBar("Mot de passe invalide."); 
//       } else {