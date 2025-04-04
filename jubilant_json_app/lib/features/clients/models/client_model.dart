class Client {
  final int id;
  final String siret;
  final String name;

  Client({
    required this.id,
    required this.siret,
    required this.name,
  });

  //Transformation en User
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] ?? 0,
      siret: json['siret_number'] ?? '',
      name: json['Name'] ?? '',
    );
  }

  //Transformation en Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'siret_number': siret,
      'Name': name,
    };
  }
}
