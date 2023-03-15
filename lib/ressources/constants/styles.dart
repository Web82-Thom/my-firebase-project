import 'package:flutter/material.dart';

///============== TextStyle ============

TextStyle whiteText = TextStyle(color: Colors.white,fontSize: 16.00);
TextStyle blackText = TextStyle(color: Colors.black,fontSize: 16.00);
TextStyle whiteBoldText = TextStyle(color: Colors.white, fontWeight: FontWeight.bold,);
TextStyle whiteText16 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0,);
TextStyle whiteBoldText16 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0,);
TextStyle whiteBoldText20 = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0,);
TextStyle blackBoldText = TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 16.00);
TextStyle blackBoldText20 = TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20.0,);
TextStyle primaryText = TextStyle(color: Colors.orange, fontWeight: FontWeight.bold,);
TextStyle primaryText16 = TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 16.0,);
TextStyle primaryTextColor = TextStyle(color: Colors.orange,);
TextStyle primaryBoldTextColor20 = TextStyle(color: Colors.orange, fontWeight: FontWeight.bold,fontSize: 20.0,);
TextStyle black12BoldText12 = TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.bold,);
TextStyle purpleBoldText16 = TextStyle(color: Colors.purple, fontSize: 16, fontWeight: FontWeight.bold,);
TextStyle redBoldText16 = TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold,);


///============== ButtonStyle ============

ButtonStyle lightPrimaryButtonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange[100]));
ButtonStyle lightTertiaryButtonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple[100]));
ButtonStyle lightGreyButtonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[400]));
ButtonStyle purpleButtonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple), textStyle: MaterialStateProperty.all(whiteBoldText),);
ButtonStyle redButtonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red), textStyle: MaterialStateProperty.all(whiteBoldText),);
ButtonStyle greenButtonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green), textStyle: MaterialStateProperty.all(whiteBoldText),);