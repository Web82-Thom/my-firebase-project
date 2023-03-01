import 'dart:io';

import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';
import 'package:myfirebaseproject/modules/auth/models/user_model.dart';
import 'package:myfirebaseproject/modules/auth/views/auth_view.dart';
import 'package:myfirebaseproject/modules/profil/views/controllers/profile_controller.dart';
import 'package:myfirebaseproject/modules/profil/views/widgets/custom_text_field.dart';
import 'package:myfirebaseproject/ressources/constants/styles.dart';
import 'package:myfirebaseproject/ressources/dialogues/dialog_cancel_button.dart';
import 'package:myfirebaseproject/ressources/dialogues/dialog_confirm_button.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

Color _color1 = Color(0xFF07ac12);
Color _color2 = Color(0xff777777);
Color _color3 = Color(0xFF515151);
FirebaseAuth auth = FirebaseAuth.instance;
ProfileController profileController = ProfileController();
TextEditingController _usernameField = TextEditingController();
TextEditingController _emailField = TextEditingController();
class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref('users');
    final Size size = MediaQuery.of(context).size;
    final double profilePictureSize = MediaQuery.of(context).size.width / 3;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mon profil"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(onPressed: () {
            Get.toNamed(Routes.HOME);
          },icon: Icon(Icons.arrow_back) ),
        ),
        body: Column(
          children: [
            // ChangeNotifierProvider(create: (_) => AuthController(),
            //   child: Consumer<AuthController>(builder: (context, provider, child) {
            //     return SingleChildScrollView(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Center(
            //             child: Align(
            //           alignment: Alignment.center,
            //           child: Container(
            //             margin: EdgeInsets.only(top: 40),
            //             width: profilePictureSize,
            //             height: profilePictureSize,
            //             // child: GestureDetector(
            //             //   onTap: () {
            //             //     print('edit');
            //             //     provider.pickImageNew(context);
            //             //     // _showPopupUpdatePicture();
            //             //   },
            //             //   child: Stack(
            //             //     children: [
            //             //       ClipRRect(
            //             //         borderRadius: BorderRadius.circular(100),
            //             //         child: provider.image == null ?
            //             //         Image.asset("assets/images/birdy.png"): 
            //             //         Image.file(File(provider.image!.path).absolute),
                                
            //             //       ),
            //             //       // ImageLoaderWidget(
            //             //       //     height: 150,
            //             //       //     width: 150,
            //             //       //     url: "assets/images/birdy.png",
            //             //       //     isCircular: true),
            //             //       // create edit icon in the picture
            //             //       Container(
            //             //         width: 30,
            //             //         height: 30,
            //             //         margin: EdgeInsets.only(
            //             //             top: 0,
            //             //             left: MediaQuery.of(context).size.width / 4),
            //             //         child: Card(
            //             //           shape: RoundedRectangleBorder(
            //             //             borderRadius: BorderRadius.circular(30),
            //             //           ),
            //             //           elevation: 1,
            //             //           child: Icon(Icons.edit, size: 12, color: _color3),
            //             //         ),
            //             //       ),
            //             //     ],
            //             //   ),
            //             // ),
            //           ),
            //         )),
                    
            //       ],
            //     ),
            //   );
            //   },)
            // ),
            FutureBuilder<UserModel?>(
              future: authController.readUser(),
              builder: ((context, snapshot) {
                if(snapshot.hasData ) {
                  final user =snapshot.data;
                  return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const SizedBox(height: 40.0,),
                          Text(
                            "Nom d'utilisateur",
                            style: TextStyle(
                              fontSize: 15,
                              color: _color2,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(height: 8.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: user!.name == ''? const Text(
                                  "Modifier mon nom d'utilsateur",
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                ): Text(
                                  user.name.toString(),
                                  style: const TextStyle(fontSize: 16, color: Colors.black),
                                ) ,
                              ),
                              ///==========USERNAME==========///
                              GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: "Modifier le nom d'utilisateur",
                                    content: CustomTextField(
                                        controller: _usernameField,
                                        labelText: "Nom d'utilisateur",
                                        isObscure: false),
                                    cancel: const DialogCancelButton(),
                                    confirm: DialogConfirmButton(
                                      onPressed: () {
                                        profileController.updateUsername(
                                            id: user.id.toString(),
                                            username: _usernameField.text);
                                        _usernameField.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                                child: Text('Edit',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: _color1,
                                    )),
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0,),
                          Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 15,
                                color: _color2,
                                fontWeight: FontWeight.normal),
                          ),
                         const SizedBox(height: 8.0,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  user.email.toString(),
                                  style: const TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              ),
                              ///=============EMAIL=============///
                              GestureDetector(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: "Modifier l'email",
                                    content: CustomTextField(
                                        controller: _emailField,
                                        labelText: "Email",
                                        isObscure: false),
                                    cancel: const DialogCancelButton(),
                                    confirm: DialogConfirmButton(
                                      onPressed: () {
                                        profileController.updateEmail(
                                            id: user.id.toString(),
                                            email: _emailField.text);
                                        _emailField.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },child: Text('Edit',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: _color1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: "ATTENTION !",
                                    middleText:
                                    "Toute suppression de compte est définitive. Souhaitez-vous supprimer votre compte ?",
                                    cancel: const DialogCancelButton(),
                                    confirm: DialogConfirmButton(
                                      onPressed: () => authController.deleteUser()
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.red),
                                ),
                                child: Text(
                                  "Supprimer le compte",
                                  style: whiteBoldText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } return const Center(
                child: CircularProgressIndicator(),
              );
            })),
          ],
        ),
      ),
    );
  }
}
