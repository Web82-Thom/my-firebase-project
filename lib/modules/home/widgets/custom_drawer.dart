import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';
import 'package:myfirebaseproject/modules/auth/models/user_model.dart';
import 'package:myfirebaseproject/ressources/widgets/image_loader_widget.dart';
import 'package:myfirebaseproject/routes/app_pages.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return  Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              GestureDetector(
                onTap: ()=> Get.toNamed(Routes.PROFILE),
                child: FutureBuilder<UserModel?>(
                  future: authController.readUser(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      final user = snapshot.data;
                    return UserAccountsDrawerHeader(
                      accountName: Text(user!.name.toString()),
                      accountEmail: Text(user.email.toString()),
                      currentAccountPicture: ImageLoaderWidget(url:user.url.toString(), isCircular: true),
                    );
                    } return const CircularProgressIndicator(); 
                    
                    
                  }
                ),
              ),
              ListTile(
                title: const Text("Version alpha 0.0.1"),
                onTap: () {
                  Get.defaultDialog(
                      title: "Version alpha 0.0.1",
                      middleText: "Merci de nous soutenir dans cette aventure passionnante qu'est le lancement de Let's GO! \n\n Amusez-vous bien et à bientôt ! "
                  );
                },
              ),
              const Divider(
                thickness: 3,
              ),
              ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: const Text("Mon premium"),
                onTap: () {
                  Get.toNamed(Routes.PREMIUM);
                },
              ),
              const Divider(
                thickness: 3,
              ),
              ListTile(
                title: const Text('Boîte à idée'),
                leading: const Icon(Icons.lightbulb),
                onTap: () {
                  Get.defaultDialog(
                    title: "La boîte à idée",
                    middleText: "Pour soutenir le lancement et le développement de Let's GO!, dîtes-nous quelles améliorations et fonctions vous aimeriez voir apparaître d'ici les prochaines semaines. \n\n N'hésitez pas à nous laisser un message directement via le formulaire de contact. \n\n Merci encore pour votre soutien ! :-)"
                  );
                },
              ),
              ListTile(
                title: const Text('Contact'),
                leading: const Icon(Icons.email),
                onTap: () {
                  Get.toNamed(Routes.CONTACT);
                },
              ),
              const Divider(
                thickness: 3,
              ),
              const Divider(
                thickness: 3,
              ),
              ListTile(
                title: const Text('Fermer le menu'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('quality'),
                onTap: () {
                  Get.toNamed(Routes.QUALITY);
                  
                },
              ),
            ],
          )
    );
  }
}
