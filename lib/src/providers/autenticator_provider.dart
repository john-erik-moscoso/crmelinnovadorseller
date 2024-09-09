import 'package:crmelinnovadorseller/src/widgets/custom_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider {
  final _firebase = FirebaseAuth.instance;

  // Obtener el UID
  User? getUser() {
    try {
      User? u = _firebase.currentUser;
      return u;
    } on FirebaseAuthException catch (error) {
      debugPrint('ERROR AL TENER UID: ${error.message}');
      return null;
    }
  }

  // Verificar si esta logeado
  bool isSignedIn() {
    return _firebase.currentUser != null;
  }

  // Cerrar secion
  Future<Future<List<void>>> signOut() async {
    return Future.wait([
      _firebase.signOut(),
    ]);
  }

  // Registrar usuario
  Future<bool> register(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true; // Registro exitoso
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return false;
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'CORREO ELECTRÓNICO INVÁLIDO.';
          CustomAlert.showMessage(context, 'Error', errorMessage);
          break;
        case 'weak-password':
          errorMessage = 'LA CONTRASEÑA ES DEMASIADO DÉBIL.';
          CustomAlert.showMessage(context, 'Error', errorMessage);
          break;
        case 'email-already-in-use':
          errorMessage = 'EL CORREO ELECTRÓNICO YA ESTÁ EN USO.';
          CustomAlert.showMessage(context, 'Error', errorMessage);
          break;
        case 'network-request-failed':
          errorMessage = 'NO HAY CONEXIÓN A INTERNET.';
          CustomAlert.showMessage(context, 'Error', errorMessage);
          break;
        default:
          errorMessage = 'SE PRODUJO UN ERROR: ${e.message?.toUpperCase()}';
          CustomAlert.showMessage(context, 'Error', errorMessage);
          break;
      }
      return false; // Error de autenticación
    } catch (e) {
      if (!context.mounted) return false;
      String generalError = 'OCURRIÓ UN ERROR INESPERADO: $e';
      CustomAlert.showMessage(context, 'Error', generalError);
      return false; // Error inesperado
    }
  }

  // Iniciar secion
  Future<bool> login(String email, String password) async {
    try {
      await _firebase.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      // Manejo específico de errores de autenticación
      return Future.error(error.code);
    } catch (error) {
      // Manejo de otros errores, como problemas de conexión
      return Future.error("Ocurrió un error inesperado");
    }
  }
}
