// To parse this JSON data, do
//
//     final seller = sellerFromJson(jsonString);

import 'dart:convert';

Seller sellerFromJson(String str) => Seller.fromJson(json.decode(str));

String sellerToJson(Seller data) => json.encode(data.toJson());

class Seller {
  String id;
  String? fullNames;
  String? companyName;
  String? nit;
  String? phoneNumber;
  List<String>? interest;
  String? email;
  String? password;

  Seller({
    required this.id,
    this.fullNames,
    this.companyName,
    this.nit,
    this.phoneNumber,
    this.interest,
    this.email,
    this.password,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        fullNames: json["fullNames"],
        companyName: json["companyName"],
        nit: json["nit"],
        phoneNumber: json["phoneNumber"],
        interest: json["interest"] == null
            ? []
            : List<String>.from(json["interest"]!.map((x) => x)),
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullNames": fullNames,
        "companyName": companyName,
        "nit": nit,
        "phoneNumber": phoneNumber,
        "interest":
            interest == null ? [] : List<dynamic>.from(interest!.map((x) => x)),
        "email": email,
        "password": password,
      };
}
