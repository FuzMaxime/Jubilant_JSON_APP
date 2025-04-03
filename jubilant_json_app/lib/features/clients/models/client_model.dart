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
      siret: json['siret'] ?? '',
      name: json['name'] ?? '',
    );
  }

  //Transformation en Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'siret': siret,
      'name': name,
    };
  }
}
