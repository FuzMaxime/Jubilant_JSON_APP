import 'dart:convert';
import 'package:jubilant_json_app/features/clients/models/client_model.dart';
import 'package:jubilant_json_app/features/auth/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiUrl =
    "${dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1"}/clients";

//Récupérer toutes les clients
Future<List<Client>> getAllClients() async {
  final token = await getToken();
  if (token == null) return [];

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Client> listClient =
        data.map((json) => Client.fromJson(json)).toList();
    return listClient;
  } else {
    return [];
  }
}

//Récupérer un client par son Id
Future<Client?> getClientById(int id) async {
  final token = await getToken();
  if (token == null) return null;

  final response = await http.get(
    Uri.parse("$apiUrl/$id"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(utf8.decode(response.bodyBytes));
    Client client = Client.fromJson(data);
    return client;
  } else {
    return null;
  }
}
