enum OrderType { normal, vip }

enum OrderStatus { pending, processing, completed }

class OrderItem {
  String id;
  OrderType type; // normal or vip
  OrderStatus status; // pending / processing / completed

  OrderItem({
    required this.id,
    required this.type,
    required this.status,
  });
}
