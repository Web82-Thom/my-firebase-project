import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:myfirebaseproject/modules/auth/views/auth_view.dart';
import 'package:myfirebaseproject/modules/auth/widgets/forgot_password.dart';
import 'package:myfirebaseproject/modules/auth/widgets/signin_widget.dart';
import 'package:myfirebaseproject/modules/auth/widgets/signup_widget.dart';
import 'package:myfirebaseproject/modules/auth/widgets/verify_email_view.dart';
import 'package:myfirebaseproject/modules/home/views/home_view.dart';
import 'package:myfirebaseproject/ressources/widgets/snackBar_auth.dart';
import 'package:myfirebaseproject/ressources/widgets/splash_screen.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';

import 'firebase_options.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  
  final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'My firebase project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      getPages: AppPages.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', 'FR'),
        Locale('en, En'), // Français, no country code
      ],
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (userSnapshot.hasError){
            return const Center(child:Text('Une erreur est intervenue !'));
          } if (userSnapshot.hasData) {
            return VerifyEmailView();
          } else{
            return const AuthView();
          }
        },
      ),
      routes: {
        "/home": (context) => HomeView(),
        "/auth": (context) => const AuthView(),
        "/signin": (context) =>  SigninWidget(),
        "/signup": (context) =>  SignupWidget(),
        "/forgot_password": (context) => ForgotPassword(),
        "/verify_email": (context) => VerifyEmailView(),
      },
    );
  }
}
