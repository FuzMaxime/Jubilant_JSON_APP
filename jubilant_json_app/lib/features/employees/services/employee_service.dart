import 'dart:convert';
import 'package:jubilant_json_app/features/employees/models/employee_model.dart';
import 'package:jubilant_json_app/features/auth/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiUrl =
    "${dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1"}/employees";

//Récupérer toutes les employees
Future<List<Employee>> getAllEmployees() async {
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

    List<Employee> listEmployees =
        data.map((json) => Employee.fromJson(json)).toList();
    return listEmployees;
  } else {
    return [];
  }
}

//Récupérer un employee par son Id
Future<Employee?> getEmployeeById(int id) async {
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
    Employee employee = Employee.fromJson(data);
    return employee;
  } else {
    return null;
  }
}
