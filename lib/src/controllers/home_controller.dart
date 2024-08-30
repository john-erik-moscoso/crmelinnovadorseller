import 'package:crmelinnovadorseller/src/models/seller_model.dart';
import 'package:crmelinnovadorseller/src/providers/autenticator_provider.dart';
import 'package:crmelinnovadorseller/src/providers/seller_provider.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_alert.dart';
import 'package:flutter/material.dart';

class HomeController {
  // Flutter
  final key = GlobalKey<ScaffoldState>();
  late final BuildContext? context;
  late final Function? refresh;

  // Proveedores
  final _authProvider = AuthProvider();
  final _sellerProvider = SellerProvider();

  // Modelo
  Seller? _seller;

  // Datos del login
  final email = TextEditingController();
  final password = TextEditingController();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // Metodos de arranque
    await isSignedIn();
  }

  // Validar si hay una cuenta ya iniciada
  Future isSignedIn() async {
    bool loginStatus = _authProvider.isSignedIn();
    if (loginStatus) {
      Navigator.of(context!).pushNamedAndRemoveUntil(
        'DashboardView',
        (route) => false,
      );
    }
  }

  // Iniciar secion
  Future login() async {
    try {
      bool login = await _authProvider.login(email.text, password.text);
      if (login) {
        _seller = await _sellerProvider.getById(_authProvider.getUser()!.uid);
        if (_seller!.id.isNotEmpty) {
          Navigator.of(context!).pushNamedAndRemoveUntil(
            'DashboardView',
            (route) => false,
          );
        } else {
          _error('Error', 'No se puede validar la cuenta, verifique nuevamente.');
        }
      }else{
        _error('Error', 'No existe cuenta para el módulo vendedor.');
      }
    } catch (error) {
      debugPrint('Error al iniciar secion $error'.toUpperCase());
      _error('Error', 'No se puede validar la cuenta, valide nuevamente.');
    }
  }

  void _error(String title, String message) {
    CustomAlert.showMessage(context!, title, message);
    Navigator.of(context!).pushNamedAndRemoveUntil('home', (route) => false);
  }
}
