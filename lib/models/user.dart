import 'dart:convert';

class User {
  final int id;
  final String name;
  final String email;
  final Customer customer;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.customer,
  });

  factory User.fromJson(dynamic json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    customer: Customer.fromJson(json["customer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "customer": customer.toJson(),
  };
}

class Customer {
  final int id;
  final String nohp;
  final String alamat;
  final int userId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customer({
    required this.id,
    required this.nohp,
    required this.alamat,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer.fromJson(dynamic json) => Customer(
    id: json["id"],
    nohp: json["nohp"],
    alamat: json["alamat"],
    userId: json["user_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nohp": nohp,
    "alamat": alamat,
    "user_id": userId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
