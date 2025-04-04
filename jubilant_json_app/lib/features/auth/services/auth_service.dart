import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../dio_client.dart';
import 'package:dio/dio.dart';

final String apiUrl = dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1";
final String apiKey = dotenv.env['API_KEY'] ?? "x-api-key";

//Login de l'utilisateur
Future<bool> login(String email, String password) async {
  try {
    /*var response = await DioClient.dio.post(
      "$apiUrl/login",
      data: {
        "email": email,
        "password": password,
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "x-api-key": apiKey,
        },
      ),
    );*/
    final apiClient = ApiClient();
    var response = await apiClient.postRequest("$apiUrl/login",
      {
        "email": email,
        "password": password,
      });
    if (response.statusCode == 200) {
      await apiClient.saveCookies("$apiUrl/login");
      final data = response.data["data"];
      /*
      await DioClient.saveUserUUID(data["user_uuid"]);
*/
      print("Connexion réussie !");
      return true;
    }
  } catch (e) {
    print("Erreur de connexion : $e");
  }
  return false;
}

//Demande si l'utilisateur est authentifié
Future<bool> isAuthenticated() async {
  String? token = await getToken();
  if (token == null) return false;

  final response = await http.get(
    Uri.parse("$apiUrl/auth/protected"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    },
  );

  return response.statusCode == 200;
}

//déconnexion
Future<void> logout() async {
  await _removeToken();
}

//Sauvegarder le token
Future<void> _saveToken(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("user_uuid", userId.toString());
}

//récupérer le token
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("auth_token");
}

//récupérer l'Id de l'utilisateur connecté
Future<String?> getUserId() async {
  return "0"; /*
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("user_id");*/
}

//Supprime le token
Future<void> _removeToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("auth_token");
  await prefs.remove("user_id");
}
