import 'package:crmelinnovadorseller/src/providers/autenticator_provider.dart';
import 'package:crmelinnovadorseller/src/providers/seller_provider.dart';
import 'package:crmelinnovadorseller/src/providers/shered_provider.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/seller_model.dart';

class EditProfileController {
  // Flutter
  final key = GlobalKey<ScaffoldState>();
  BuildContext? context;
  Function? refresh;
  // Proveedores
  final _sharedPref = SharedPref();
  final _sellerProvider = SellerProvider();
  final _authProvider = AuthProvider();
  // Modelo de datos (Datos de la cuenta del usuario)
  Seller? seller;
  // Datos de empresa
  final nit = TextEditingController();
  final companyName = TextEditingController();
  String? companyType;
  // Datos de usuario
  final fullNames = TextEditingController();
  final phoneNumber = TextEditingController();
  // Datos de la cuenta
  String? _id;
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();

  init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // Metodos de arranque
    await getInfoSeller();
  }

  // Obtener datos del usuario
  getInfoSeller() async {
    _id = await _sharedPref.read('id') ?? _authProvider.getUser()!.uid;
    if (_id != null) {
      seller = await _sellerProvider.getInfo(_id!);
      refresh!();
    } else {
      CustomAlert.showMessage(
        context!,
        'Error',
        'Error al encontrar el usuario. Revisa tu conexión a Internet.',
      );
    }
  }

  // Guardar los datos de la compañia
  saveDataCompany() async {}
  // Guardar los datos del usuario
  saveDataUser() async {}
  // Guardar credenciales
  saveCredentials() async {}
}
