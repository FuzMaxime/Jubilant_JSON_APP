import 'dart:convert';
import 'package:jubilant_json_app/features/employees/models/employee_model.dart';
import 'package:jubilant_json_app/features/auth/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String apiUrl =
    "${dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1"}/employees";

//Récupérer toutes les employees
Future<List<Employee>> getAllEmployees() async {
  List<Employee> employees = [
    Employee(
      id: 1,
      client_id: 101,
      first_name: "John",
      last_name: "Doe",
      birth_date: DateTime(1990, 5, 20),
      expiry_date_CNI: DateTime(2030, 5, 20),
      number_CNI: "1234567890",
    ),
    Employee(
      id: 2,
      client_id: 102,
      first_name: "Jane",
      last_name: "Smith",
      birth_date: DateTime(1985, 7, 15),
      expiry_date_CNI: DateTime(2028, 7, 15),
      number_CNI: "2345678901",
    ),
    Employee(
      id: 3,
      client_id: 103,
      first_name: "Michael",
      last_name: "Brown",
      birth_date: DateTime(1995, 3, 10),
      expiry_date_CNI: DateTime(2032, 3, 10),
      number_CNI: "3456789012",
    ),
    Employee(
      id: 4,
      client_id: 104,
      first_name: "Emily",
      last_name: "Davis",
      birth_date: DateTime(1992, 11, 25),
      expiry_date_CNI: DateTime(2031, 11, 25),
      number_CNI: "4567890123",
    ),
    Employee(
      id: 5,
      client_id: 105,
      first_name: "Chris",
      last_name: "Miller",
      birth_date: DateTime(2000, 2, 5),
      expiry_date_CNI: DateTime(2035, 2, 5),
      number_CNI: "5678901234",
    ),
  ];

  return employees;
/*
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
  }*/
}
