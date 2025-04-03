import 'dart:convert';

import 'package:jubilant_json_app/features/auth/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

final String baseUrl =
    "${dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1"}/users";

class UserService {
  /*
  * This method is used to get the user details from the server
  * @param id: The id of the user
  * @return User: The user object
  * */
  Future<User> getUser(String id) async {
    User user = User(
      id: 1,
      firstName: "John",
      lastName: "Doe",
      email: "jdoe@gmail.com",
      password: "123",
      createdAt: DateTime.parse("2023-10-01T00:00:00.000Z"),
    );

    return user;
    /*
    final token = await getToken();
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/$id"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return User.fromJson(jsonDecode(response.body));
      } else {
        final errorResponse = jsonDecode(response.body);
        throw errorResponse['error'] ?? 'Failed to update user';
      }
    } catch (e) {
      throw e.toString();
    }*/
  }
}
