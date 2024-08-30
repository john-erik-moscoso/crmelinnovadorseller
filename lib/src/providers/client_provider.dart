import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/client_model.dart';

class ClientProvider {
  final _ref = FirebaseFirestore.instance.collection('Clients');

  // Crear cliente
  Future<void> create(Client client) async {
    try {
      await _ref.doc(client.id).set(client.toJson());
    } catch (error) {
      // Manejo de errores
      String errorMessage = error is FirebaseException
          ? error.message ?? 'Error desconocido'
          : 'Error desconocido';
      return Future.error(errorMessage);
    }
  }

  // Obtener informacion en tiempo real
  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  // Obtener informacion
  Future<Client?> getById(String id) async {
    try {
      DocumentSnapshot document = await _ref.doc(id).get();

      if (document.exists) {
        return Client.fromJson(document.data() as Map<String, dynamic>);
      }
      return null; // Documento no encontrado
    } catch (error) {
      // Manejo de errores
      String errorMessage = error is FirebaseException
          ? error.message ?? 'Error desconocido'
          : 'Error desconocido';
      return Future.error(errorMessage);
    }
  }

  // Actualizar datos
  Future<void> update(Map<String, dynamic> data, String id) async {
    try {
      await _ref.doc(id).update(data);
    } catch (error) {
      // Manejo de errores
      String errorMessage = error is FirebaseException
          ? error.message ?? 'Error desconocido'
          : 'Error desconocido';
      return Future.error(errorMessage);
    }
  }
}
