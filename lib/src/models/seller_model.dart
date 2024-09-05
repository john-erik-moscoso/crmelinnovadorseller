// To parse this JSON data, do
//
//     final seller = sellerFromJson(jsonString);

import 'dart:convert';

Seller sellerFromJson(String str) => Seller.fromJson(json.decode(str));

String sellerToJson(Seller data) => json.encode(data.toJson());

class Seller {
  String id;
  String nit;
  String companyName;
  String companyType;
  String fullNames;
  String email;
  String password;
  String phoneNumber;
  List<String> interest;

  Seller({
    required this.id,
    required this.nit,
    required this.companyName,
    required this.companyType,
    required this.fullNames,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.interest,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    nit: json["nit"],
    companyName: json["companyName"],
    companyType: json["companyType"],
    fullNames: json["fullNames"],
    email: json["email"],
    password: json["password"],
    phoneNumber: json["phoneNumber"],
    interest: List<String>.from(json["interest"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nit": nit,
    "companyName": companyName,
    "companyType": companyType,
    "fullNames": fullNames,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "interest": List<dynamic>.from(interest!.map((x) => x)),
  };
}
