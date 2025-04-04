import 'dart:io';

import 'package:jubilant_json_app/core/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:jubilant_json_app/core/widgets/navbar_widget.dart';
import 'package:jubilant_json_app/features/employees/models/employee_model.dart';

class CNIPage extends StatefulWidget {
  final Employee employee;

  const CNIPage({super.key, required this.employee});

  @override
  State<CNIPage> createState() => _CNIPageState();
}

class _CNIPageState extends State<CNIPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainHeader(
              title: "Employé",
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'CNI de ${widget.employee.first_name} ${widget.employee.last_name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
