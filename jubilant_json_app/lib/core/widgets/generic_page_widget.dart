/*import 'package:jubilant_json_app/core/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/color.dart';

/// GenericPage is a reusable page template that can be used to wrap any child widget.
/// It provides a consistent layout with a header, bottom navigation bar, and a floating action button.
class GenericPage extends ConsumerStatefulWidget {
  final Widget child;

  const GenericPage(this.child, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenericPage();
}

class _GenericPage extends ConsumerState<GenericPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child, // The main content of the page
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: MainHeader(title: "titre")), // Custom header for the page
      bottomNavigationBar: BottomAppBar(
        height: 84,
        color: ColorConstant.black,
        // shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child:
                  NavBarLink(text: "Accueil", icon: Icons.home, link: "/home"),
            ),
            SizedBox(width: 40),
            SizedBox(
              child: NavBarLink(
                  text: "Profil", icon: Icons.person, link: "/profile"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSlideUpView,
        backgroundColor: ColorConstant.red,
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Widget for navigation bar links
class NavBarLink extends StatelessWidget {
  final String text;
  final String link;
  final IconData icon;

  const NavBarLink(
      {super.key, required this.text, required this.icon, required this.link});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(
            context, link); // Navigate to the specified link
      },
      style: TextButton.styleFrom(
        foregroundColor: ColorConstant.white,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: ColorConstant.white),
          SizedBox(height: 4),
          Text(text, style: TextStyle(color: ColorConstant.white)),
        ],
      ),
    );
  }
}*/
