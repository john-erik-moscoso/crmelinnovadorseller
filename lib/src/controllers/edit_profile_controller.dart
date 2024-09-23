import 'package:crmelinnovadorseller/src/providers/autenticator_provider.dart';
import 'package:crmelinnovadorseller/src/providers/seller_provider.dart';
import 'package:crmelinnovadorseller/src/providers/shered_provider.dart';
import 'package:crmelinnovadorseller/src/tools/custom_colors.dart';
import 'package:crmelinnovadorseller/src/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
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
  ProgressDialog? _progressDialog;

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
    _progressDialog = ProgressDialog(context: context);
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
  saveDataCompany() async {
    if (nit.text.isEmpty || companyName.text.isEmpty || companyType == null) {
      CustomAlert.showMessage(
        context!,
        'Error',
        'Hay datos de la empresa vacíos. Revisa todos los campos, por favor.',
      );
      _progressDialog?.close();
      return;
    } else {
      _progressDialog?.show(
        msg: 'Actualizando datos...',
        msgMaxLines: 2,
        backgroundColor: CustomColors.colorPrimary,
        msgColor: Colors.white,
        progressValueColor: Colors.white,
        progressBgColor: CustomColors.colorPrimary,
      );
      final Map<String, String> data = {
        'nit': nit.text,
        'companyName': companyName.text,
        'companyType': companyType ?? 'Tipo no especificado',
      };

      final bool updateData = await _sellerProvider.update(data, _id!);
      if (updateData) {
        _progressDialog?.close();
        Navigator.of(context!).pop();
        CustomAlert.showMessage(
          context!,
          'Bien',
          'Los datos de tu empresa han sido actualizados.',
        );
      } else {
        _progressDialog?.close();
        CustomAlert.showMessage(
          context!,
          'Error',
          'Los datos de tu empresa no pudieron ser actualizados. Intenta nuevamente, por favor.',
        );
      }
      _progressDialog?.close();
    }
  }

  // Guardar los datos del usuario
  saveDataUser() async {
    if (fullNames.text.isEmpty || phoneNumber.text.isEmpty) {
      CustomAlert.showMessage(
        context!,
        'Error',
        'Hay datos de la personales vacíos. Revisa todos los campos, por favor.',
      );
      _progressDialog?.close();
      return;
    } else {
      _progressDialog?.show(
        msg: 'Actualizando datos...',
        msgMaxLines: 2,
        backgroundColor: CustomColors.colorPrimary,
        msgColor: Colors.white,
        progressValueColor: Colors.white,
        progressBgColor: CustomColors.colorPrimary,
      );
      final Map<String, String> data = {
        'fullNames': fullNames.text,
        'phoneNumber': phoneNumber.text,
      };

      final bool updateData = await _sellerProvider.update(data, _id!);
      if (updateData) {
        _progressDialog?.close();
        Navigator.of(context!).pop();
        CustomAlert.showMessage(
          context!,
          'Bien',
          'Los personales han sido actualizados.',
        );
      } else {
        _progressDialog?.close();
        CustomAlert.showMessage(
          context!,
          'Error',
          'Los datos personales no pudieron ser actualizados. Intenta nuevamente, por favor.',
        );
      }
      _progressDialog?.close();
    }
  }

  // Guardar credenciales
  saveCredentials() async {
    if (password.text != repeatPassword.text ||
        password.text.isEmpty ||
        repeatPassword.text.isEmpty) {
      CustomAlert.showMessage(
        context!,
        'Error',
        'Los campos contraseñas y repita contraseña deben ser idénticos. Revisa todos los campos, por favor.',
      );
      _progressDialog?.close();
      return;
    } else {
      _progressDialog?.show(
        msg: 'Actualizando datos...',
        msgMaxLines: 2,
        backgroundColor: CustomColors.colorPrimary,
        msgColor: Colors.white,
        progressValueColor: Colors.white,
        progressBgColor: CustomColors.colorPrimary,
      );
      final Map<String, String> data = {
        'password': password.text,
      };

      final bool updateData = await _sellerProvider.update(data, _id!);
      final bool updatePassword =
          await _authProvider.updatePassword(password.text);
      if (updateData && updatePassword) {
        _progressDialog?.close();
        Navigator.of(context!).pop();
        CustomAlert.showMessage(
          context!,
          'Bien',
          'La contraseña ha sido actualizada.',
        );
      } else {
        _progressDialog?.close();
        CustomAlert.showMessage(
          context!,
          'Error',
          'Las contraseñas no pudieron ser actualizados. Intenta nuevamente, por favor.',
        );
      }
      _progressDialog?.close();
    }
  }
}
