import 'package:crmelinnovadorseller/src/providers/autenticator_provider.dart';
import 'package:crmelinnovadorseller/src/providers/seller_provider.dart';
import 'package:crmelinnovadorseller/src/providers/shered_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/seller_model.dart';

class DashboardController {
  // flutter
  final key = GlobalKey<ScaffoldState>();
  BuildContext? context;
  Function? refresh;
  // Proveedores
  final _authProvider = AuthProvider();
  final _sellerProvider = SellerProvider();
  final _sharedPreference = SharedPref();
  // Modelos
  Seller? seller;
  String? _id;

  Future init(BuildContext context, Function refresh)async{
    this.context = context;
    this.refresh = refresh;
    // Metodos de arranque
    await saveIdFirebase();
    await getInfoCompany();
  }

  // Guardar id
  saveIdFirebase() async{
    _id = _authProvider.getUser()!.uid;
    await _sharedPreference.save('id', _id!);
  }

  // Obtener datos de la empresa
  getInfoCompany() async{
    seller = await _sellerProvider.getById(_id ?? _authProvider.getUser()!.uid);
    seller?.toJson().forEach((value, key){
      debugPrint('$key - $value');
    });
  }

  // Cerrar secion
  exitApp(){
    _authProvider.signOut();
    Navigator.of(context!).pushNamedAndRemoveUntil('home', (route)=> false);
  }

}