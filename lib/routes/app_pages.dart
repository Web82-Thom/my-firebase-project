import 'package:get/get.dart';
import 'package:myfirebaseproject/modules/auth/views/auth_view.dart';
import 'package:myfirebaseproject/modules/auth/widgets/forgot_password.dart';
import 'package:myfirebaseproject/modules/auth/widgets/signin_widget.dart';
import 'package:myfirebaseproject/modules/auth/widgets/signup_widget.dart';
import 'package:myfirebaseproject/modules/auth/widgets/verify_email_view.dart';
import 'package:myfirebaseproject/modules/home/views/home_view.dart';
import 'package:myfirebaseproject/modules/profil/views/profile_view.dart';



part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupWidget(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SigninWidget(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPassword(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY_EMAIL,
      page: () => VerifyEmailView(),
      // binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      // binding: AuthBinding(),
    ),
  ];
}
