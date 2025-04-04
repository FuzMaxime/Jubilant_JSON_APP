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
      id: json['employeId'] ?? 0,
      client_id: json['clientId'] ?? 0,
      first_name: json['firstname'] ?? '',
      last_name: json['lastname'] ?? '',
      birth_date:
          DateTime.parse(json['birthdate'] ?? DateTime.now().toString()),
      expiry_date_CNI:
          DateTime.parse(json['CNIExpireAt'] ?? DateTime.now().toString()),
      number_CNI: json['CNICode'] ?? '',
    );
  }

  //Transformation en Json
  Map<String, dynamic> toJson() {
    return {
      'employeId': id,
      'clientId': client_id,
      'firstname': first_name,
      'lastname': last_name,
      'birthdate': birth_date.toIso8601String(),
      'CNIExpireAt': expiry_date_CNI.toIso8601String(),
      'CNICode': number_CNI,
    };
  }
}
