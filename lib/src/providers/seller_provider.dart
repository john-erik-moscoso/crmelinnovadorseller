import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/seller_model.dart';

class SellerProvider {
  final _ref = FirebaseFirestore.instance.collection('Sellers');

  // Crear cliente
  Future<void> create(Seller seller) async {
    try {
      await _ref.doc(seller.id).set(seller.toJson());
    } catch (error) {
      // Manejo de errores
      String errorMessage = error is FirebaseException
          ? error.message ?? 'Error desconocido'
          : 'Error desconocido';
      return Future.error(errorMessage);
    }
  }

  // Obtener informacion en tiempo real
  Stream<DocumentSnapshot> getInfoStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  // Obtener informacion
  Future<Seller?> getInfo(String id) async {
    try {
      DocumentSnapshot document = await _ref.doc(id).get();

      if (document.exists) {
        return Seller.fromJson(document.data() as Map<String, dynamic>);
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
