import 'dart:async';

import 'package:feedme_assignment/model/bot_detail.dart';
import 'package:feedme_assignment/model/order_item.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderProviderType {
  List<OrderItem> orderList;
  List<BotDetail> botList;

  OrderProviderType({
    required this.orderList,
    required this.botList,
  });

  OrderProviderType copyWith({
    List<OrderItem>? orderList,
    List<BotDetail>? botList,
  }) {
    return OrderProviderType(
      orderList: orderList ?? this.orderList,
      botList: botList ?? this.botList,
    );
  }
}

class OrderProvider extends StateNotifier<OrderProviderType> {
  OrderProvider() : super(OrderProviderType(orderList: [], botList: []));

  void addOrder(OrderType type) {
    state = state.copyWith(
      orderList: [
        ...state.orderList,
        OrderItem(
          id: type == OrderType.normal
              ? 'N${state.orderList.length + 1}'
              : 'V${state.orderList.length + 1}',
          type: type,
          status: OrderStatus.pending,
          duration: type == OrderType.normal ? 10 : 5,
        )
      ],
    );
    checkOperation();
  }

  void addBot() {
    state = state.copyWith(
      botList: [
        ...state.botList,
        BotDetail(id: state.botList.length + 1, order: null)
      ],
    );
    checkOperation();
  }

  void deleteBot() {
    if (state.botList.isNotEmpty) {
      if (state.botList.last.order != null) {
        state = state.copyWith(
          orderList: state.orderList.map((order) {
            if (order.id == state.botList.last.order) {
              return order.copyWith(status: OrderStatus.pending);
            }
            return order;
          }).toList(),
        );
      }
      List<BotDetail> newBotList = state.botList;
      newBotList.removeLast();
      state = state.copyWith(botList: [...newBotList]);
    }
  }

  checkOperation() {
    var availableBotList =
        state.botList.where((bot) => bot.order == null).toList();
    var availableOrderList = state.orderList
        .where((order) => order.status == OrderStatus.pending)
        .toList();

    if (availableBotList.isNotEmpty && availableOrderList.isNotEmpty) {
      int vipSearcher =
          availableOrderList.indexWhere((order) => order.type == OrderType.vip);
      if (vipSearcher == -1) vipSearcher = 0;
      state = state.copyWith(
        orderList: state.orderList.map((order) {
          if (order.id == availableOrderList[vipSearcher].id) {
            return order.copyWith(
                status: OrderStatus.processing,
                duration: order.type == OrderType.normal ? 10 : 5);
          }
          return order;
        }).toList(),
        botList: state.botList.map((bot) {
          if (bot.id == availableBotList[0].id) {
            return bot.copyWith(order: availableOrderList[vipSearcher].id);
          }
          return bot;
        }).toList(),
      );
      processOperation(
          availableBotList[0].id, availableOrderList[vipSearcher].id);
      availableBotList.removeAt(0);
      availableOrderList.removeAt(vipSearcher);
    }
  }

  processOperation(
    int botId,
    String orderId,
  ) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.orderList.isEmpty) timer.cancel();
      if (state.orderList.firstWhere((order) => order.id == orderId).status ==
          OrderStatus.pending) {
        timer.cancel();
      }

      if (state.orderList.firstWhere((order) => order.id == orderId).duration ==
          0) {
        state = state.copyWith(
          orderList: state.orderList.map((order) {
            if (order.id == orderId) {
              return order.copyWith(
                status: OrderStatus.completed,
              );
            }
            return order;
          }).toList(),
          botList: state.botList.map((bot) {
            if (bot.id == botId) {
              return bot.copyWith(
                order: null,
              );
            }
            return bot;
          }).toList(),
        );
        checkOperation();
        timer.cancel();
      } else {
        state = state.copyWith(
          orderList: state.orderList.map((order) {
            if (order.id == orderId) {
              return order.copyWith(duration: order.duration - 1);
            }
            return order;
          }).toList(),
        );
      }
    });
  }
}
// import 'dart:async';
// import 'package:collection/collection.dart';
// import 'package:feedme_assignment/model/bot_detail.dart';
// import 'package:feedme_assignment/model/order_item.dart';
// import 'package:flutter/material.dart';

// class OrderProvider extends ChangeNotifier {
//   final List<OrderItem> _orders = [];
//   UnmodifiableListView<OrderItem> get orders => UnmodifiableListView(_orders);
//   final List<BotDetail> _bots = [];
//   UnmodifiableListView<BotDetail> get bots => UnmodifiableListView(_bots);

//   void addOrder(OrderType type) {
//     _orders.add(
//       OrderItem(
//         id: type == OrderType.normal
//             ? 'N${_orders.length + 1}'
//             : 'V${_orders.length + 1}',
//         type: type,
//         status: OrderStatus.pending,
//         duration: type == OrderType.normal ? 10 : 5,
//       ),
//     );
//     checkOperation();
//     notifyListeners();
//   }

//   void addBot() {
//     _bots.add(BotDetail(id: _bots.length + 1, order: null));
//     checkOperation();
//     notifyListeners();
//   }

//   void deleteBot() {
//     if (_bots.isNotEmpty) {
//       BotDetail newestBot = _bots.last;
//       if (newestBot.order != null) {
//         _orders.firstWhere((order) => order.id == newestBot.order).status =
//             OrderStatus.pending;
//       }
//       _bots.removeLast();
//     }
//     notifyListeners();
//   }

//   checkOperation() {
//     var availableBotList = bots.where((bot) => bot.order == null).toList();
//     var availableOrderList =
//         orders.where((order) => order.status == OrderStatus.pending).toList();
//     if (availableBotList.isNotEmpty && availableOrderList.isNotEmpty) {
//       int vipSearcher =
//           availableOrderList.indexWhere((order) => order.type == OrderType.vip);
//       if (vipSearcher == -1) vipSearcher = 0;
//       availableBotList[0].order = availableOrderList[0].id;
//       availableOrderList[vipSearcher].status = OrderStatus.processing;
//       processOperation(availableBotList[0], availableOrderList[vipSearcher]);
//       availableBotList.removeAt(0);
//       availableOrderList.removeAt(vipSearcher);
//     }
//   }

//   processOperation(BotDetail bot, OrderItem order) {
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       debugPrint(timer.tick.toString());
//       if (order.duration == 0) {
//         bot.order = null;
//         order.status = OrderStatus.completed;
//         checkOperation();
//         notifyListeners();
//         timer.cancel();
//       } else {
//         order.duration--;
//         notifyListeners();
//       }
//     });
//   }
// }

