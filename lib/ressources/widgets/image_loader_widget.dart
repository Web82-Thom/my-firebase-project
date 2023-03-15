import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfirebaseproject/modules/auth/controllers/auth_controllers.dart';

class ImageLoaderWidget extends StatefulWidget {
  final String url;
  final double? height;
  final double? width;
  final bool isCircular;
  final Decoration? decoration;
  final double? radius;
  final BoxFit? fit;
  const ImageLoaderWidget({Key? key, required this.url, this.radius, this.decoration, this.fit, this.height, this.width, required this.isCircular}) : super(key: key);

  @override
  _ImageLoaderWidgetState createState() => _ImageLoaderWidgetState();
}

class _ImageLoaderWidgetState extends State<ImageLoaderWidget> {
  // PickerController pickerController = PickerController();
  AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: authController.downloadURL(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: CircleAvatar(
              radius: widget.radius,
              backgroundImage: NetworkImage(
                snapshot.data!,
              ),
            ),
          );
        } else if(snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const CircularProgressIndicator();
      },);
  }
}
