import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';
import 'package:myfirebaseproject/ressources/widgets/snackBar_auth.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';

class ProfileController with ChangeNotifier{
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference usersCollection = FirebaseFirestore.instance.collection("users");
  AuthController authController = AuthController();

  void updateUsername({required String id, required String username}) {
    try {
      usersCollection.doc(id).update({
        "username": username,
      }).whenComplete(() {
        authController.readUser();
        notifyListeners();
        Get.snackbar("Modification réussie",
            "Votre nom d'utilisateur a bien été modifiée !",
            snackPosition: SnackPosition.BOTTOM);
      });
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  void updateEmail({required String id, required String email}) {
    try {
      usersCollection.doc(id).update({
        "email": email,
      }).whenComplete(() {
        authController.readUser();
        Get.snackbar("Modification réussie",
            "Votre email a bien été modifiée !",
            snackPosition: SnackPosition.BOTTOM);
      });
    } catch (e) {
      print(e);
    }
  }

  void userDeleteAccount({required String id}) async {
    await usersCollection.doc(id).delete().whenComplete(() {
      FirebaseAuth.instance.currentUser!.delete();
      Get.toNamed(Routes.AUTH);
      Get.snackbar("Suppression réussie",
          "Votre compte a bien été supprimé. On espère vous revoir bientôt !",
          snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.grey[500],
        );
    });
  }
}