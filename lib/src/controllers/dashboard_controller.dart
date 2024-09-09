import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardController {
  // flutter
  final key = GlobalKey<ScaffoldState>();
  BuildContext? context;
  Function? refresh;
  Future init(BuildContext context, Function refresh)async{
    this.context = context;
    this.refresh = refresh;
  }
}