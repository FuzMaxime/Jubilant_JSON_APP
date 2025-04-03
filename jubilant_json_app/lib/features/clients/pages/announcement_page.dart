import 'dart:io';

import 'package:jubilant_json_app/features/clients/models/client_model.dart';
import 'package:jubilant_json_app/features/clients/services/client_service.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/color.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  List<Client> allClients = [];
  List<Client> filteredClients = [];

  String titleFilter = "";
  String locationFilter = "";
  String? _address;

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

  // Method to filter Clients based on title and location
  void filterClients() {
    setState(() {
      filteredClients = allClients.where((client) {
        final matchesTitle =
            client.name.toLowerCase().contains(titleFilter.toLowerCase());
        final matchesLocation =
            client.siret.toLowerCase().contains(locationFilter.toLowerCase());
        return matchesTitle && matchesLocation;
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
              const SizedBox(height: 30),
              buildLabel("Qui"),
              buildSearchField("Rechercher le nom du client", (value) {
                setState(() {
                  titleFilter = value;
                  filterClients();
                });
              }),
              const SizedBox(height: 5),
              buildLabel("Numéro SIRET"),
              buildSearchField("Rechercher le numéro SIRET", (value) {
                setState(() {
                  locationFilter = value;
                  filterClients();
                });
              }),
              const SizedBox(height: 20),

              // Display the filtered Clients
              /* Column(
                children: filteredClients
                    .map((annonce) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AnnouncementDetails(announcement: annonce),
                        ))
                    .toList(),
              ),*/
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
