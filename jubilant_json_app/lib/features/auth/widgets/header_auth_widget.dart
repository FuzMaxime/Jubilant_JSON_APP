import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';

class HeaderAuth extends StatelessWidget {
  final String title;

  const HeaderAuth({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 30.0,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: ClipRRect(
              child:
                  Image.asset('assets/images/logoCerfrance.png', height: 40)),
        ),
        Column(
          spacing: 20.0,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: ColorConstant.yellow,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                )),
          ],
        ),
      ],
    );
  }
}
