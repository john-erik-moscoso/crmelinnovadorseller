import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../models/seller_model.dart';
import '../providers/autenticator_provider.dart';
import '../providers/seller_provider.dart';
import '../widgets/custom_alert.dart';

class RegisterController {
  // Flutter
  final key = GlobalKey<ScaffoldState>();
  BuildContext? context;
  Function? refresh;
  ProgressDialog? _progressDialog;

  // Proveedores
  final _authProvider = AuthProvider();
  final _sellerProvider = SellerProvider();

  // Modelos
  Seller? _seller;

  // Datos de la empresa
  final nit = TextEditingController();
  final companyName = TextEditingController();
  String? companyType;
  final fullNames = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final repeatPassword = TextEditingController();
  final phoneNumber = TextEditingController();
  List<String> interest = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
  }

  bool validateForm() {
    // Verificar que el nombre completo no esté vacío
    if (fullNames.text.isEmpty) {
      _progressDialog?.close();
      CustomAlert.showMessage(context!, 'Error', 'Nombre completo vacío');
      return false;
    }

    // Verificar que el nombre de la compañía no esté vacío
    if (companyName.text.isEmpty) {
      _progressDialog?.close();
      CustomAlert.showMessage(context!, 'Error', 'Nombre de tu compañía no especificado');
      return false;
    }

    // Verificar que el NIT no esté vacío
    if (nit.text.isEmpty) {
      _progressDialog?.close();
      CustomAlert.showMessage(context!, 'Error', 'NIT no especificado');
      return false;
    }

    // Verificar que el número de teléfono no esté vacío y tenga al menos 10 dígitos
    if (phoneNumber.text.isEmpty || phoneNumber.text.length < 10) {
      _progressDialog?.close();
      CustomAlert.showMessage(context!, 'Error', 'Número de teléfono no válido');
      return false;
    }

    // Verificar que haya al menos un interés seleccionado
    if (interest.isEmpty) {
      _progressDialog?.close();
      CustomAlert.showMessage(context!, 'Error', 'Debe seleccionar al menos una categoría.');
      return false;
    }

    // Verificar que el correo electrónico no esté vacío y tenga un formato válido
    final emailPattern = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (email.text.isEmpty || !emailPattern.hasMatch(email.text)) {
      _progressDialog?.close();
      CustomAlert.showMessage(context!, 'Error', 'Correo electrónico no válido');
      return false;
    }

    // Verificar que la contraseña no esté vacía y tenga al menos 8 caracteres
    if (password.text.isEmpty || password.text.length < 6) {
      _progressDialog?.close();
      CustomAlert.showMessage(
          context!, 'Error', 'Contraseña no válida, debe tener al menos 6 caracteres');
      return false;
    }

    // Verificar que las contraseñas coincidan
    if (password.text != repeatPassword.text) {
      _progressDialog?.close();
      CustomAlert.showMessage(context!, 'Error', 'Las contraseñas no coinciden');
      return false;
    }

    // Si todos los campos son válidos, devolver true
    return true;
  }

  // Registrar
  Future<void> register() async {
    try {
      _progressDialog?.show(
        msg: 'Creando cuenta, aguarda un momento por favor.',
        msgMaxLines: 2,
        backgroundColor: CustomColors.colorPrimary,
        msgColor: Colors.white,
        progressValueColor: Colors.white,
        progressBgColor: CustomColors.colorPrimary,
      );
      if (validateForm()) {
        // Crea la cuenta
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
              nit: nit.text.trim(),
              companyName: companyName.text,
              companyType: companyType,
              fullNames: fullNames.text,
              email: email.text.trim(),
              password: password.text,
              phoneNumber: phoneNumber.text.trim(),
              interest: interest,
            );
            // Crea la base de datos
            await _sellerProvider.create(_seller!);
            _progressDialog?.close();
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
    _progressDialog?.close();
  }

  // Errores
  void _error(String title, String message) {
    _progressDialog?.close();
    CustomAlert.showMessage(context!, title, message);
    Navigator.of(context!).pushNamedAndRemoveUntil('register', (route) => false);
  }
}
