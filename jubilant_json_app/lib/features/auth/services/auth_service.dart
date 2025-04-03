import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final String apiUrl = dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1";

//Login de l'utilisateur
Future<bool> login(String email, String password) async {
  final response = await http.post(
    Uri.parse("$apiUrl/auth"),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({"email": email, "password": password}),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    await _saveToken(data["token"], data["userId"]);
    return true;
  } else {
    return false;
  }
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
Future<void> _saveToken(String token, int userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("auth_token", token);
  await prefs.setString("user_id", userId.toString());
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
