import 'dart:io';

import 'package:jubilant_json_app/core/widgets/header_widget.dart';
import 'package:jubilant_json_app/core/widgets/navbar_widget.dart';
import 'package:jubilant_json_app/features/clients/models/client_model.dart';
import 'package:jubilant_json_app/features/clients/services/client_service.dart';
import 'package:flutter/material.dart';
import 'package:jubilant_json_app/features/clients/widgets/client_widget.dart';
import '../../../core/constants/color.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  List<Client> allClients = [];
  List<Client> filteredClients = [];

  String nameFilter = "";
  String siretFilter = "";

  @override
  void initState() {
    super.initState();
    loadClients();
  }

  // Asynchronous method to load Clients from an external service
  Future<void> loadClients() async {
    try {
      List<Client> clientsData = await getAllClients();
      setState(() {
        allClients = clientsData;

        filteredClients = allClients; // Display all Clients by default
      });
    } catch (e) {
      // In case of an error, display an error message in the console
      stderr.writeln("Error loading clients: $e");
    }
  }

  // Method to filter Clients
  void filterClients() {
    setState(() {
      filteredClients = allClients.where((client) {
        final matchesName =
            client.name.toLowerCase().contains(nameFilter.toLowerCase());
        final matchesSiret =
            client.siret.toLowerCase().contains(siretFilter.toLowerCase());
        return matchesName && matchesSiret;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(280.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainHeader(
              title: "Clients",
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLabel("Qui"),
                  buildSearchField("Rechercher le nom du client", (value) {
                    setState(() {
                      nameFilter = value;
                      filterClients();
                    });
                  }),
                  const SizedBox(height: 5),
                  buildLabel("Numéro SIRET"),
                  buildSearchField("Rechercher le numéro SIRET", (value) {
                    setState(() {
                      siretFilter = value;
                      filterClients();
                    });
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavbarWidget(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the filtered Clients
              Column(
                children: filteredClients
                    .map((client) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: ClientCard(client: client),
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
