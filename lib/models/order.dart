
import 'package:sentaku_laundry_apk/models/user.dart';

class Order {
  final int id;
  final int userId;
  final int serviceManagesId;
  final int priceListsId;
  final String quantity;
  final int total;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final Pricelist pricelist;
  final Servicemanage servicemanage;

  Order({
    required this.id,
    required this.userId,
    required this.serviceManagesId,
    required this.priceListsId,
    required this.quantity,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.pricelist,
    required this.servicemanage,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    userId: json["user_id"],
    serviceManagesId: json["service_manages_id"],
    priceListsId: json["price_lists_id"],
    quantity: json["quantity"],
    total: json["total"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    user: User.fromJson(json["user"]),
    pricelist: Pricelist.fromJson(json["pricelist"]),
    servicemanage: Servicemanage.fromJson(json["servicemanage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "service_manages_id": serviceManagesId,
    "price_lists_id": priceListsId,
    "quantity": quantity,
    "total": total,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "user": user.toJson(),
    "pricelist": pricelist.toJson(),
    "servicemanage": servicemanage.toJson(),
  };
}

class Pricelist {
  final int id;
  final String quantity;
  final String harga;
  final String another;
  final String hargaanother;
  final DateTime createdAt;
  final DateTime updatedAt;

  Pricelist({
    required this.id,
    required this.quantity,
    required this.harga,
    required this.another,
    required this.hargaanother,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Pricelist.fromJson(Map<String, dynamic> json) => Pricelist(
    id: json["id"],
    quantity: json["quantity"],
    harga: json["harga"],
    another: json["another"],
    hargaanother: json["hargaanother"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "harga": harga,
    "another": another,
    "hargaanother": hargaanother,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class Servicemanage {
  final int id;
  final String title;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Servicemanage({
    required this.id,
    required this.title,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Servicemanage.fromJson(Map<String, dynamic> json) => Servicemanage(
    id: json["id"],
    title: json["title"],
    userId: json["user_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
