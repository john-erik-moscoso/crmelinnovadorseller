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
      await _firebase.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (error) {
      // Manejo específico de errores de autenticación
      return Future.error(error.code);
    } catch (error) {
      // Manejo de otros errores, como problemas de conexión
      return Future.error("Ocurrió un error inesperado");
    }
  }

  // Actualizar contraseña
  Future<bool> updatePassword(String password) async {
    try {
      User? user = _firebase.currentUser; // Obtener usuario actual

      if (user != null) {
        await user.updatePassword(password);
        debugPrint('Contraseña actualizada correctamente'.toUpperCase());
        return true; // Devuelve true si la contraseña se actualizó correctamente
      } else {
        debugPrint('Usuario no encontrado.'.toUpperCase());
        return false; // Devuelve false si el usuario es null
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        debugPrint('Por favor, vuelve a iniciar sesión.'.toUpperCase());
      } else {
        debugPrint('Error: ${e.message}'.toUpperCase());
      }
      return false; // Devuelve false si hay una excepción
    } catch (e) {
      debugPrint('Error: $e'.toUpperCase());
      return false; // Devuelve false si hay cualquier otro error
    }
  }
}
