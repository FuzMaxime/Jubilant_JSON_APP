import 'dart:io';

import 'package:jubilant_json_app/core/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:jubilant_json_app/features/employees/models/employee_model.dart';
import 'package:jubilant_json_app/features/employees/services/employee_service.dart';
import 'package:jubilant_json_app/features/employees/widgets/employee_widget.dart';
import '../../../core/constants/color.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({super.key});

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  List<Employee> allEmployees = [];
  List<Employee> filteredEmployees = [];

  String nameFilter = "";

  @override
  void initState() {
    super.initState();
    loadEmployees();
  }

  // Asynchronous method to load Employees from an external service
  Future<void> loadEmployees() async {
    try {
      List<Employee> employeesData = await getAllEmployees();
      setState(() {
        allEmployees = employeesData;

        filteredEmployees = allEmployees; // Display all Employees by default
      });
    } catch (e) {
      // In case of an error, display an error message in the console
      stderr.writeln("Error loading Employees: $e");
    }
  }

  // Method to filter Employees
  void filterEmployees() {
    setState(() {
      filteredEmployees = allEmployees.where((employee) {
        final matchesName =
            employee.last_name.toLowerCase().contains(nameFilter.toLowerCase());
        return matchesName;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MainHeader(
                title: "Employés",
              ),
              const SizedBox(height: 30),
              buildLabel("Qui"),
              buildSearchField("Rechercher par nom", (value) {
                setState(() {
                  nameFilter = value;
                  filterEmployees();
                });
              }),
              const SizedBox(height: 20),

              // Display the filtered Employees
              Column(
                children: filteredEmployees
                    .map((employee) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: EmployeeCard(employee: employee),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to create a label with the given text
  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  // Method to create a search field with a hint text and a callback function
  Widget buildSearchField(String hintText, Function(String) onChanged) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: ColorConstant.darkGrey),
        ),
        filled: true,
        fillColor: ColorConstant.white,
      ),
    );
  }
}
