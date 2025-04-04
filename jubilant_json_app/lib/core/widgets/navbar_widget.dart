import 'package:flutter/material.dart';
import '../../features/auth/models/user_model.dart';
import '../constants/color.dart';
import 'package:jubilant_json_app/features/auth/services/auth_service.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 18.0),
      decoration: BoxDecoration(
        color: ColorConstant.lightGrey,
        boxShadow: [
          BoxShadow(
            color: ColorConstant.darkGrey,
            blurRadius: 4.0,
            spreadRadius: 0.0,
            offset: const Offset(0, -0.2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.search, color: ColorConstant.orange),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: ColorConstant.green),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}
