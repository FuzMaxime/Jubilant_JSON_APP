import 'package:camera/camera.dart';
import 'package:jubilant_json_app/features/employees/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:jubilant_json_app/features/employees/pages/CNI_page.dart';

import '../../../core/constants/color.dart';

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  const EmployeeCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToCNIPage(context, employee),
      child: Card(
        color: ColorConstant.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${employee.first_name} ${employee.last_name}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date de naissance : ${employee.birth_date}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date de fin de validité CNI : ${employee.expiry_date_CNI}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Numéro CNI : ${employee.number_CNI}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> navigateToCNIPage(
      BuildContext context, Employee employee) async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CNIPage(camera: firstCamera, employee: employee),
      ),
    );
  }
}
