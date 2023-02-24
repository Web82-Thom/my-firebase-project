import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AuthController with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  
  bool isSignUp = false;
  bool isLogin = false;

  String newUserEmail = "";
  String newUserPassword = "";
  String newUserUsername = "";

  
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
