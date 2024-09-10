import 'package:flutter/material.dart';

class EditProfileController{
  // Flutter
  final key = GlobalKey<ScaffoldState>();
  BuildContext? context;
  Function? refresh;

  init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
  }
}