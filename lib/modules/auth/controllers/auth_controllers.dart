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

import 'package:myfirebaseproject/modules/auth/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AuthController extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isSignUp = false;
  bool isLogin = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isEmailVerified = false;
  Timer? timer;
  User? user;

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    userState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    notifyListeners();
    initState();
  }

  userState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    auth.authStateChanges().listen(
      (User? user) {
        if (user == null) {
          Get.toNamed(Routes.AUTH);
        } if (isEmailVerified == false) {
          sendVerificationEmail();
          timer = Timer.periodic(
            const Duration(seconds: 3),(_) => checkEmailVerified(),
          );
        } if (isEmailVerified == true){
          timer?.cancel();
        }
      },
    );
  }

  Future<void> signIn() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).whenComplete(() {
          readUser();
        });
    } on FirebaseAuthException catch (e) {
      print(e);
      if (e.message == 'There is no user record corresponding to this identifier. The user may have been deleted.') {
        Utils.showSnackBar("Email inconnu dans la base de donnée où l'utilsateur a été supprimer. Veuiller créer un compte.");
      } else if (e.message == "The email address is badly formatted.") {
        Utils.showSnackBar("Email invalide, veuillez entrer un email au bon format.");
      } else if (e.message == "Given String is empty or null") {
        Utils.showSnackBar("Entrer votre mot de passe, minimum 8 caractères.");
      } else if (e.message == "The password is invalid or the user does not have a password.") {
        Utils.showSnackBar("Mot de passe invalide.");
      } else {
        Utils.showSnackBar(e.message);
      }
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.toNamed(Routes.AUTH);
  }

  Future signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).whenComplete((){ 
        user = auth.currentUser;
        usersCollection
        .doc(user!.uid)
        .set(UserModel(
          id: user!.uid,
          email: email,
          name: name,
        ).toMap(),);

        userState(); 
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }

  //-----RESET PASSWORD-----//
  Future sendResetPassword(String email) async {
    if (email.isEmpty || !email.contains('@')) {
      Utils.showSnackBar("Veuillez entrer votre Email valide");
    } else {
      try {
        await auth.sendPasswordResetEmail(email: email)
        .then((value) => email)
        .whenComplete(() {
          Utils.showSnackBar("Email envoyer!");
          Get.toNamed(Routes.AUTH);
        });
      } on FirebaseAuthException catch (e) {
        if (e.message == 'There is no user record corresponding to this identifier.The user may have been deleted.') {
          Utils.showSnackBar("Aucun email enregistrer dans la base de donnée où l'utilsateur a été supprimer");
        } else {
          Utils.showSnackBar(e.message);
        }
      }
    }
  }

  //READ ONE USER
  Future<UserModel?> readUser() async {
    final docUser = FirebaseFirestore.instance.collection("users").doc(auth.currentUser!.uid);
    final snapshot = await docUser.get();
    if (snapshot.exists){
      return UserModel.fromJson(snapshot.data()!);
    } return null;
  }

  Future  deleteUser()async{
   
  await auth.currentUser!.delete().whenComplete(() => Get.toNamed(Routes.AUTH));

  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    timer?.cancel();
    super.dispose();
    notifyListeners();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user
          .sendEmailVerification()
          .whenComplete(() => Get.toNamed(Routes.VERIFY_EMAIL));
    } on Exception catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  Future checkEmailVerified() async {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    try {
      await auth.currentUser!.reload();
      if (isEmailVerified) {
        timer?.cancel();
        Get.toNamed(Routes.HOME);
      }
      notifyListeners();
    } on Exception catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  void onReady() {
    notifyListeners();
    timer?.cancel();
    onReady();
  }

  @override
  void close() {
    close();
  }
}
