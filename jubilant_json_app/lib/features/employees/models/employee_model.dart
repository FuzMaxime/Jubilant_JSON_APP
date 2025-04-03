class Employee {
  final int id;
  final int client_id;
  final String first_name;
  final String last_name;
  final DateTime birth_date;
  final DateTime expiry_date_CNI;
  final String number_CNI;

  Employee({
    required this.id,
    required this.client_id,
    required this.first_name,
    required this.last_name,
    required this.birth_date,
    required this.expiry_date_CNI,
    required this.number_CNI,
  });

  //Transformation en User
  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] ?? 0,
      client_id: json['client_id'] ?? 0,
      first_name: json['first_name'] ?? '',
      last_name: json['last_name'] ?? '',
      birth_date:
          DateTime.parse(json['birth_date'] ?? DateTime.now().toString()),
      expiry_date_CNI:
          DateTime.parse(json['expiry_date_CNI'] ?? DateTime.now().toString()),
      number_CNI: json['number_CNI'] ?? '',
    );
  }

  //Transformation en Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_id': client_id,
      'first_name': first_name,
      'last_name': last_name,
      'birth_date': birth_date.toIso8601String(),
      'expiry_date_CNI': expiry_date_CNI.toIso8601String(),
      'number_CNI': number_CNI,
    };
  }
}
