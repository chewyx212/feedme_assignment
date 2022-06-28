import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedme_assignment/bloc/bots/bot_bloc.dart';
import 'package:feedme_assignment/model/order_item.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final BotBloc botBloc;
  late StreamSubscription botSubscription;
  OrderBloc({required this.botBloc}) : super(OrderState()) {
    on<FetchOrderList>(_fetchOrderList);
    on<AddOrder>(_addOrder);
    on<ChangeOrder>(_changeOrder);

    botSubscription = botBloc.stream.listen((state) {
      print('listening');
      print(state);
    });
  }

  void _fetchOrderList(FetchOrderList event, Emitter<OrderState> emit) {
    emit(
      OrderState(orderList: event.orderList),
    );
  }

  void _addOrder(AddOrder event, Emitter<OrderState> emit) {
    emit(
      OrderState(
        orderList: List.from(state.orderList)
          ..add(
            OrderItem(
              id: '${event.type == OrderType.normal ? 'N' : 'V'}${state.orderList.length + 1}',
              type: event.type,
              status: OrderStatus.pending,
            ),
          ),
      ),
    );
  }

  void _changeOrder(ChangeOrder event, Emitter<OrderState> emit) {
    final state = this.state;
    List<OrderItem> orderList = state.orderList.map((order) {
      return order.id == event.item.id ? event.item : order;
    }).toList();

    emit(
      OrderState(
        orderList: orderList,
      ),
    );
  }
}
