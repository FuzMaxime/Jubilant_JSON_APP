import 'package:jubilant_json_app/features/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jubilant_json_app/features/clients/pages/client_page.dart';
import 'package:jubilant_json_app/features/employees/pages/employee_page.dart';
import 'core/constants/color.dart';
//import 'core/widgets/generic_page_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env").catchError((error) {
    print("Erreur de chargement du fichier .env : $error");
  });
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jubilant JSON',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => ClientPage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: ColorConstant.white,
        fontFamily: 'Poppins',
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorConstant.white,
        ),
      ),
    );
  }
}
