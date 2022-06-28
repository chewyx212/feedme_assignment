part of 'order_bloc.dart';

class OrderState extends Equatable {
  List<OrderItem> orderList;

  OrderState({
    this.orderList = const [],
  });

  OrderState copyWith({
    List<OrderItem>? orderList,
  }) {
    return OrderState(
      orderList: orderList ?? this.orderList,
    );
  }

  @override
  List<Object> get props => [orderList];
}
