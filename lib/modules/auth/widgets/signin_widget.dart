import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';

class SigninWidget extends StatefulWidget {
  @override
  _SigninWidgetState createState() => _SigninWidgetState();
}

class _SigninWidgetState extends State<SigninWidget> {
  AuthController authController = Get.put(AuthController());

  bool _obscureText = true;
  IconData _iconVisible = Icons.visibility_off;

  final _formKey = GlobalKey<FormState>();

  Color _underlineColor = Color(0xFFCCCCCC);
  Color _mainColor = Color(0xFF07ac12);
  Color _color1 = Color(0xFF515151);
  Color _color2 = Color(0xff777777);
  Color _color3 = Color(0xFFaaaaaa);

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
    Size size = MediaQuery.of(context).size;
    // ScreenSize screenSize = MakeItResponsive().getScreenSize(context);

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.fromLTRB(30, 120, 30, 30),
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Text(
              'Connexion',
              style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: _mainColor),
            ),
            TextFormField(
              key: ValueKey('emailController'),
              controller: authController.emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: _color1),
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _mainColor, width: 2.0),
                ),
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
              onSaved: (value) {
                final isValid = _formKey.currentState!.validate();

                authController.emailController.text = value!;
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              key: ValueKey('passwordController'),
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
                authController.passwordController.text = value!;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                child: GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.FORGOT_PASSWORD);
                    print('forgot');
                  },
                  child: Text(
                    'Mot de passe oublié ?',
                    style: TextStyle(color: _mainColor, fontSize: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
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
                  print('controller ' + authController.emailController.text);
                  print('controller ' + authController.passwordController.text);
                  final isValid = _formKey.currentState!.validate();
                  authController.signIn();
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'CONNEXION',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    authController.isSignUp = true;
                    authController.isLogin = false;
                    FocusScope.of(context).unfocus();
                    print(authController.isSignUp);
                    print('isLogin ' + (authController.isLogin.toString()));
                  });
                  Get.toNamed(Routes.SIGNUP);
                },
                child: Wrap(
                  children: [
                    Text(
                      'Pas encore de compte ? ',
                      style: TextStyle(fontSize: 13, color: _color3),
                    ),
                    Text(
                      'Créer un compte',
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
