import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? email;
  String? name;
  String? url;
  UserModel({this.id, this.email, this.name, this.url, }); 

  Map<String, dynamic> toMap()=> {
    "email": email,
    "id": id,
    "username": name ?? "NoName",
    "url": url ?? "users/profile.png",
  };

  UserModel.fromMap(DocumentSnapshot data) {
    id = data["id"];
    email = data["email"];
    name = data["username"];
    url = data["url"];
  }

  Map<String, dynamic>toJson() => {
    'id': id,
    'email' : email,
    'username' : name,
    'url': url,
  };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    email: json['email'],
    name: json['username'],
    url: json['url'],
  );
}
