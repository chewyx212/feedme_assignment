// ignore_for_file: must_be_immutable

enum OrderType { normal, vip }

enum OrderStatus { pending, processing, completed }

class OrderItem {
  String id;
  OrderType type; // normal or vip
  OrderStatus status; // pending / processing / completed
  int duration;

  OrderItem({
    required this.id,
    required this.type,
    required this.status,
    required this.duration,
  });

  OrderItem copyWith({
    String? id,
    OrderType? type, // normal or vip
    OrderStatus? status,
    int? duration,
  }) {
    return OrderItem(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      duration: duration ?? this.duration,
    );
  }
}
