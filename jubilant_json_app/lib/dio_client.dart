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

/*
class DioClient {
  static final Dio _dio = Dio();
  static final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  static late final PersistCookieJar cookieJar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(storage: FileStorage("${dir.path}/cookies"));
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  DioClient() {
    _dio.interceptors.add(CookieManager(cookieJar));
  }

  static Dio get dio {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        return handler.next(options);
      },
      onResponse: (Response response, handler) {
        return handler.next(response);
      },
      onError: (DioError error, handler) async {
        if (error.response?.statusCode == 401 && error.response?.data is Map<String, dynamic>) {
          print("Access Token expiré, tentative de rafraîchissement");
          var errorData = error.response?.data;
          print(errorData);
          if (errorData is Map<String, dynamic>) {
            String errorMessage = errorData['error'] ?? '';
            if (errorMessage.contains('invalid token')) {
              String? refreshToken = await secureStorage.read(
                  key: "refresh_token");
              print("refresh_token");
              print(refreshToken);
              if (refreshToken != null) {
                try {
                  final refreshResponse = await _dio.post(
                      "$apiUrl/tokens/renew"
                  );

                  if (refreshResponse.statusCode == 200) {
                    print("Refresh réussi, nouveau cookie d'accès");

                    final cookieHeader = refreshResponse.headers['set-cookie'];
                    final options = error.response!.requestOptions;
                    final newRequest = await _dio.fetch(options);
                    return handler.resolve(newRequest);
                  }
                } catch (e) {
                  print("Erreur lors du rafraîchissement du cookie : $e");
                }
              }
      }

          }
          return handler.next(error);
        }}));

    return _dio;
  }

  static Future<void> saveUserUUID(String userUUID) async {
    await secureStorage.write(key: "user_uuid", value: userUUID);
  }

  static Future<String?> getUserUUID() async {
    return await secureStorage.read(key: "user_uuid");
  }
}*/
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
      Response response = await _dio.post(url, data: data,options: Options(
          headers: {
            "Content-Type": "application/json",
            "x-api-key": apiKey,
          }));
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
