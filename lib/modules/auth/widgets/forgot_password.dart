import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

AuthController authController = Get.put(AuthController());

bool _obscureText = true;
IconData _iconVisible = Icons.visibility_off;
 
@override
  void initState() {
    initState();
  }

@override
  void dispose(){
    _emailField.dispose();
    dispose();
  }

TextEditingController _emailField = TextEditingController();
Color _underlineColor = Color(0xFFCCCCCC);
Color _mainColor = Color(0xFF07ac12);
Color _color1 = Color(0xFF515151);
Color _color2 = Color(0xff777777);
Color _color3 = Color(0xFFaaaaaa);

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
          children: <Widget>[
            // Center(
            //     child: Image.asset(
            //   birdy_reset_email,
            // )),
            // SizedBox(
            //   height: 80,
            // ),
            Text("Réinitialisation du mot de passe",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: _mainColor)),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailField,
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
              validator: (value) {
                if (value!.isEmpty || !value.contains('@')) {
                  return 'Entrer un adresse email valide';
                }
                return null;
              },
              
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) => _mainColor,
                ),
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                )),
              ),
              onPressed: () {
                print(_emailField.text);
                authController.sendResetPassword(_emailField.text.trim());
                
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'MOT DE PASSE OUBLIE',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.AUTH);
                  FocusScope.of(context).unfocus();
                },
                child: Wrap(
                  children: [
                    Text(
                      ' Se connecter',
                      style: TextStyle(fontSize: 13, color: _mainColor),
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
