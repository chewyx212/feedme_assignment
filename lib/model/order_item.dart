// ignore_for_file: must_be_immutable
import 'package:equatable/equatable.dart';

enum OrderType { normal, vip }

enum OrderStatus { pending, processing, completed }

class OrderItem extends Equatable {
  String id;
  OrderType type; // normal or vip
  OrderStatus status; // pending / processing / completed

  OrderItem({
    required this.id,
    required this.type,
    required this.status,
  });

  OrderItem copyWith({
    String? id,
    OrderType? type, // normal or vip
    OrderStatus? status,
  }) {
    return OrderItem(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        status,
      ];
}
