import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
final String apiUrl = dotenv.env['API_URL'] ?? "http://localhost:8080/api/v1";
final String apiKey = dotenv.env['API_KEY'] ?? "x-api-key";

class ApiClient {
  late Dio _dio;  // Utilisation de "late" pour indiquer que la variable sera initialisée plus tard
  late CookieManager _cookieManager;  // Utilisation de "late" pour indiquer que la variable sera initialisée plus tard

  ApiClient() {
    _dio = Dio();
    _cookieManager = CookieManager(CookieJar());
    _dio.interceptors.add(_cookieManager);
  }

  Future<Response> getRequest(String url) async {
    try {
      List<Cookie> cookies = await _cookieManager.cookieJar.loadForRequest(Uri.parse(url));
      /*print("Cookies envoyés : ${cookies}");*/
      if (cookies.isNotEmpty) {
        String cookiesString = cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
        print("Cookies sauvegardés : $cookiesString");

        // Ajouter les cookies aux en-têtes de la prochaine requête
        String cookieHeader = cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
        _dio.options.headers['Cookie'] = cookieHeader;

        // Vérifiez que les cookies sont bien envoyés
        print("Cookies envoyés : ${_dio.options.headers['Cookie']}");
      }
      Response response = await _dio.get(url,options: Options(
        headers: {
          "Content-Type": "application/json",
          "x-api-key": apiKey,
        }));
      return response;
    } catch (e) {
      print("Erreur lors de la requête GET: $e");
      rethrow;
    }
  }

  Future<Response> postRequest(String url, Map<String, dynamic> data) async {
    // Effectuer une requête POST
    try {
      print("aaaaaaa");
      print(url);
      Response response = await _dio.post(url, data: data,options: Options(
          headers: {
            "Content-Type": "application/json",
            "x-api-key": apiKey,
          }));
      print("bbbbbbbbbbbbbb");
      print(response);
      List<Cookie> cookies = await _cookieManager.cookieJar.loadForRequest(Uri.parse(url));
      String cookiesString = cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
      print("Cookies sauvegardés : $cookiesString");

      // Ajoutez un en-tête "Cookie" pour envoyer les cookies avec la prochaine requête
      String cookieHeader = cookies.map((cookie) => '${cookie.name}=${cookie.value}').join('; ');
      _dio.options.headers['Cookie'] = cookieHeader;
      return response;
    } catch (e) {
      print("Erreur lors de la requête POST: $e");
      rethrow;
    }
  }

  Future<void> saveCookies(String url) async {
    final cookies = await _cookieManager.cookieJar.loadForRequest(Uri.parse(url));
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("cookies", cookies.toString()); // Sauvegarde des cookies
  }

  Future<void> loadCookies() async {
    final prefs = await SharedPreferences.getInstance();
    final cookieString = prefs.getString("cookies");

    if (cookieString != null) {
      final cookies = cookieString.split(";").map((cookie) => Cookie.fromSetCookieValue(cookie)).toList();
      _cookieManager.cookieJar.saveFromResponse(Uri.parse("https://votre.url"), cookies);
    }
  }
}
