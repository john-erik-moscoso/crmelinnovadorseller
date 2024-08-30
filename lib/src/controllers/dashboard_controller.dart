import 'package:flutter/cupertino.dart';

class DashboardController {
  // flutter
  BuildContext? context;
  Function? refresh;
  Future init(BuildContext context, Function refresh)async{
    this.context = context;
    this.refresh = refresh;
  }
}