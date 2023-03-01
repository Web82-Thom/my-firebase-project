
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';
import 'package:myfirebaseproject/modules/home/views/home_view.dart';
import 'package:myfirebaseproject/ressources/widgets/snackBar_auth.dart';

class VerifyEmailView extends StatefulWidget with ChangeNotifier {
  VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
AuthController authController = AuthController();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: authController.checkEmailVerified(),
      builder: (context, snapshot) {
        return authController.isEmailVerified ? 
        HomeView() :
        Scaffold(
          appBar: AppBar(
            title: const Text("Verification Email"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Veuillez vérifier votre boite email, et activer votre accès en cliquant sur le lien.", 
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0,),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}



