import 'package:flutter/material.dart';
import 'package:jubilant_json_app/features/auth/services/auth_service.dart';
import 'package:jubilant_json_app/features/auth/services/user_service.dart';

import '../../features/auth/models/user_model.dart';
import '../constants/color.dart';

//Widget du header - utilisé dans toutes les pages de l'application
class MainHeader extends StatelessWidget {
  final String title;

  const MainHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Container(
            decoration: BoxDecoration(color: ColorConstant.lightGrey),
            child: Column(
              spacing: 12,
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/littleLogoCerfrance.png',
                        height: 30,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "John Doe",
                          style: TextStyle(
                            color: ColorConstant.darkGrey,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Text('No user data');
        }
      },
    );
  }

  Future<User?> _fetchUser() async {
    final userId = await getUserId();
    if (userId != null) {
      final userService = UserService();
      return userService.getUser(userId);
    }
    return null;
  }
}
