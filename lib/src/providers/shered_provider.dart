import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  // GUARDAR
  Future<void> save(String key, String value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString(key, json.encode(value));
  }

  // LEER
  Future<dynamic> read(String key) async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getString(key) == null) {
      return null;
    } else {
      return json.decode(preferences.getString(key).toString());
    }
  }

  // GUARDAR UN MAP
  Future<void> saveMap(String key, Map<String, dynamic> mapa) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mapaString = json.encode(mapa); // Convertir el mapa a una cadena JSON
    await prefs.setString(key, mapaString); // Guardar la cadena en SharedPreferences
  }

  // LEER UN MAP
  Future<Map<String, dynamic>?> readMap(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mapaString = prefs.getString(key); // Obtener la cadena del SharedPreferences
    if (mapaString != null) {
      Map<String, dynamic> mapa = json.decode(mapaString);
      return mapa;
    } else {
      return null;
    }
  }

  // CONTIENE
  Future<bool> contains(String key) async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(key);
  }

  // ELIMINAR
  Future<void> remove(String key) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(key);
  }
}