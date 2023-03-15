import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';
import 'package:myfirebaseproject/modules/auth/models/user_model.dart';
import 'package:myfirebaseproject/modules/home/widgets/custom_drawer.dart';
import 'package:myfirebaseproject/modules/profil/views/profile_view.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthController authController = AuthController();
  // final user = FirebaseAuth.instance.currentUser;
  // String? indexUser = user!.uid;

@override
  void initState() {
    authController.readUser();
    initState();
  }

class _HomeViewState extends State<HomeView> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Thom App's"),
        actions: [
          DropdownButton(
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                value: 'profil',
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Profil'),
                  ],
                ),
              ),
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const <Widget>[
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Déconnexion'),
                  ],
                ),
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'profil') {
                Get.toNamed(Routes.PROFILE,);
              }
              else if (itemIdentifier == 'logout') {
                authController.signOut();
              }
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder(
        future: authController.checkEmailVerified(),
        builder: (context, snapshot) {
          return Center(
            child: FutureBuilder<UserModel?>(
              future: authController.readUser(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  final user = snapshot.data;
                  return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello, ${auth.currentUser!.email}!'),
                        Text('Hello, ${user!.name.toString()}!'),
                  
                      ],
                    );
                } return CircularProgressIndicator();
                
              }
            )
              );
        }
      ),
    );
  }
}
