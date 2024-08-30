import 'package:flutter/material.dart';

import '../models/seller_model.dart';
import '../providers/autenticator_provider.dart';
import '../providers/seller_provider.dart';
import '../widgets/custom_alert.dart';

class RegisterController {
  // Flutter
  final key = GlobalKey<ScaffoldState>();
  BuildContext? context;
  Function? refresh;

  // Proveedores
  final _authProvider = AuthProvider();
  final _sellerProvider = SellerProvider();

  // Modelos
  Seller? _seller;

  // Datos del usuario
  final fullNames = TextEditingController();
  final companyName = TextEditingController();
  final nit = TextEditingController();
  final phoneNumber = TextEditingController();
  List<String> interest = []; // Inicializamos la lista aquí
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
  }

  bool validateForm() {
    // Verificar que el nombre completo no esté vacío
    if (fullNames.text.isEmpty) {
      CustomAlert.showMessage(context!, 'Error', 'Nombre completo vacío');
      return false;
    }

    // Verificar que la edad sea un número válido y mayor a 0
    if (companyName.text.isEmpty) {
      CustomAlert.showMessage(context!, 'Error', 'Nombre de tu compañía no especificado');
      return false;
    }

    // Verificar que el género esté seleccionado
    if (nit.text.isEmpty) {
      CustomAlert.showMessage(context!, 'Error', 'NIT no especificado');
      return false;
    }

    // Verificar que el número de teléfono no esté vacío y tenga al menos 10 dígitos
    if (phoneNumber.text.isEmpty || phoneNumber.text.length < 10) {
      CustomAlert.showMessage(
          context!, 'Error', 'Número de teléfono no válido');
      return false;
    }

    // Verificar que haya al menos un interés seleccionado
    if (interest.isEmpty) {
      CustomAlert.showMessage(
          context!, 'Error', 'Debe seleccionar al menos una categoría.');
      return false;
    }

    // Verificar que el correo electrónico no esté vacío y tenga un formato válido
    if (email.text.isEmpty ||
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email.text)) {
      CustomAlert.showMessage(
          context!, 'Error', 'Correo electrónico no válido');
      return false;
    }

    // Verificar que la contraseña no esté vacía y tenga al menos 8 caracteres
    if (password.text.isEmpty || password.text.length < 8) {
      CustomAlert.showMessage(context!, 'Error',
          'Contraseña no válida, debe tener al menos 8 caracteres');
      return false;
    }

    // Verificar que las contraseñas coincidan
    if (password.text != repeatPassword.text) {
      CustomAlert.showMessage(
          context!, 'Error', 'Las contraseñas no coinciden');
      return false;
    }

    // Si todos los campos son válidos, devolver true
    return true;
  }

  // Registrar
  Future<void> register() async {
    try {
      if (validateForm()) {
        final bool isRegister = await _authProvider.register(
          email.text,
          password.text,
          context!,
        );

        if (isRegister) {
          final user = _authProvider.getUser();
          if (user != null) {
            _seller = Seller(
              id: user.uid,
              fullNames: fullNames.text,
              companyName: companyName.text,
              nit: nit.text.trim(),
              interest: interest,
              phoneNumber: phoneNumber.text,
              email: email.text.trim(),
              password: password.text,
            );

            await _sellerProvider.create(_seller!);
            Navigator.pushNamedAndRemoveUntil(
              context!,
              'DashboardView',
              (route) => false,
            );
          } else {
            throw 'Usuario no disponible';
          }
        }
      }
    } catch (error) {
      _error(
        'Error',
        'No se pudo crear la cuenta. Verifica nuevamente o comunícate con nosotros en nuestros canales oficiales.',
      );
    }
  }

  // Errores
  void _error(String title, String message) {
    CustomAlert.showMessage(context!, title, message);
    Navigator.of(context!).pushNamedAndRemoveUntil('register', (route)=>false);
  }
}
