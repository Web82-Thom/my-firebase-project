import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';
import 'package:myfirebaseproject/modules/home/views/home_view.dart';
import 'package:myfirebaseproject/ressources/widgets/image_loader_widget.dart';
import 'package:myfirebaseproject/ressources/widgets/user_image_picker.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';

import 'package:uuid/uuid.dart';

class SignupWidget extends StatefulWidget {
  @override
  _SignupWidgetState createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  AuthController authController = Get.put(AuthController());

  File? userImageFile;

  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;
  final _formKey = GlobalKey<FormState>();

  Color _underlineColor = Color(0xFFCCCCCC);
  Color _mainColor = Color(0xFF07ac12);
  Color _color1 = Color(0xFF515151);
  Color _color2 = Color(0xff777777);

  final formKey = GlobalKey<FormState>();
  
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText == true) {
        _iconVisible = Icons.visibility_off;
      } else {
        _iconVisible = Icons.visibility;
      }
    });
  }

  void _pickedImage(File image) {
    setState(() {
      userImageFile = image;
      authController.image = image;
      print("userImageFile = $userImageFile");
      print("authController.image = ${authController.image}");
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
          children: <Widget>[
            Center(
              child: 
              UserImagePicker(_pickedImage)
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Inscription',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.bold, color: _mainColor),
            ),
            TextFormField(
              key: ValueKey('userName'),
              controller: authController.nameController,
              keyboardType: TextInputType.text,
              style: TextStyle(color: _color1),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _mainColor, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _underlineColor),
                ),
                labelText: "Nom d'utilisateur",
                labelStyle: TextStyle(color: _color2),
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 4) {
                  return 'Minimum 4 caractères';
                }return null;
              },
              onSaved: (value) {
                setState(() {
                  authController.nameController.text = value! ;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
           
            TextFormField(
              key: ValueKey('emailController'),
              controller: authController.emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: _color1),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _mainColor, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _underlineColor),
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: _color2),
              ),
              validator: (email) {
                if (email!.isEmpty || !email.contains('@') ) {
                  return 'Entrer un adresse email valide';
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  authController.emailController.text = value!;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              key: ValueKey('password'),
              controller: authController.passwordController,
              obscureText: _obscureText,
              style: TextStyle(color: _color1),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _mainColor, width: 2.0)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _underlineColor),
                ),
                labelText: 'Mot de passe',
                labelStyle: TextStyle(color: _color2),
                suffixIcon: IconButton(
                    icon: Icon(_iconVisible, color: Colors.grey[400], size: 20),
                    onPressed: () {
                      _toggleObscureText();
                    }),
              ),
              validator: (value) {
                if (value!.isEmpty || value.length < 7) {
                  return 'Mot de passe trop court (7 min)';
                }
                return null;
              },
              onSaved: (value) {
                setState(() {
                  authController.passwordController.text = value!;
                });
              },
            ),
            SizedBox(height: 20,),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) => _mainColor,
                ),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
              ),
              onPressed: () {
                print(authController.emailController.text);
                print(authController.passwordController.text);
                // print(authController.confirmPasswordController.text);
                final isValid = _formKey.currentState!.validate();
                // authController.signUp(
                //   name: authController.nameController.text,
                //   email: authController.emailController.text,
                //   password: authController.passwordController.text,
                // );

                if (userImageFile != null) {
                  authController.signUp(
                    name: authController.nameController.text,
                    email: authController.emailController.text,
                    password: authController.passwordController.text,
                    url: userImageFile!.path,
                  );
                } else {
                  Get.snackbar(
                    "Attention",
                    "Veuillez prendre une photo !",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.grey[500],
                    duration: Duration(seconds: 3),
                  );
                  return;
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'INSCRIPTION',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    authController.isSignUp = false;
                    authController.isLogin = true;
                    FocusScope.of(context).unfocus();
                  });
                  print(authController.isSignUp);
                  print('isLogin ' + authController.isLogin.toString());
                  Get.toNamed(Routes.SIGNIN);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.arrow_back, size: 16, color: _mainColor),
                    Text(
                      ' Se connecter',
                      style: TextStyle(
                          color: _mainColor, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  
  }

 
}
 
