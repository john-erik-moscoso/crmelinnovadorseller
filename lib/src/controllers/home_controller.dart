import 'package:flutter/material.dart';

class HomeController{
  // Flutter
  final key = GlobalKey<ScaffoldState>();
  late final BuildContext? context;
  late final Function? refresh;
  // Datos del login
  final user = TextEditingController();
  final password = TextEditingController();

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
  }
}