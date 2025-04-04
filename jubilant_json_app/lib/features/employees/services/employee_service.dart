import 'dart:convert';
import 'package:jubilant_json_app/features/employees/models/employee_model.dart';
import 'package:jubilant_json_app/features/auth/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:jubilant_json_app/features/clients/models/client_model.dart';
import 'package:jubilant_json_app/features/auth/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../dio_client.dart';
import 'package:dio/dio.dart';
final String apiUrl =
    "${dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1"}/auth/employes";

Future<List<Employee>> getAllEmployees(int id) async {
  try {
    final apiClient = ApiClient();
    var response = await apiClient.getRequest("$apiUrl/client/$id");
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data["data"]["allEmploye"];
      List<Employee> listClient = data.map((json) => Employee.fromJson(json)).toList();
      return listClient;
    } else {
      return [];
    }
  } on DioException catch (e) {
    print('Erreur : ${e.response?.statusCode} - ${e.message}');
  }
  return [];
}
