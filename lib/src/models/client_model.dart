// To parse this JSON data, do
//
//     final client = clientFromJson(jsonString);

import 'dart:convert';

Client clientFromJson(String str) => Client.fromJson(json.decode(str));

String clientToJson(Client data) => json.encode(data.toJson());

class Client {
  String id;
  String? fullNames;
  String? age;
  String? gender;
  String? phoneNumber;
  List<String>? interest;
  String? email;
  String? password;

  Client({
    required this.id,
    this.fullNames,
    this.age,
    this.gender,
    this.phoneNumber,
    this.interest,
    this.email,
    this.password,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    fullNames: json["fullNames"],
    age: json["age"],
    gender: json["gender"],
    phoneNumber: json["phoneNumber"],
    interest: json["interest"] == null ? [] : List<String>.from(json["interest"]!.map((x) => x)),
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullNames": fullNames,
    "age": age,
    "gender": gender,
    "phoneNumber": phoneNumber,
    "interest": interest == null ? [] : List<dynamic>.from(interest!.map((x) => x)),
    "email": email,
    "password": password,
  };
}
