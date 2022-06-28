part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => throw UnimplementedError();
}

class FetchOrderList extends OrderEvent {
  final List<OrderItem> orderList;

  const FetchOrderList({
    this.orderList = const [],
  });
  @override
  List<Object> get props => [orderList];
  // const FetchOrderList();
}

class AddOrder extends OrderEvent {
  final OrderType type;

  const AddOrder({
    required this.type,
  });

  @override
  List<Object> get props => [type];
}

class ChangeOrder extends OrderEvent {
  final OrderItem item;

  const ChangeOrder({
    required this.item,
  });

  @override
  List<Object> get props => [item];
}
