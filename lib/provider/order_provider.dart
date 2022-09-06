import 'dart:async';

import 'package:collection/collection.dart';
import 'package:feedme_assignment/model/bot_detail.dart';
import 'package:feedme_assignment/model/order_item.dart';
import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  final List<OrderItem> _orders = [];
  UnmodifiableListView<OrderItem> get orders => UnmodifiableListView(_orders);
  final List<BotDetail> _bots = [];
  UnmodifiableListView<BotDetail> get bots => UnmodifiableListView(_bots);

  void addOrder(OrderType type) {
    _orders.add(
      OrderItem(
        id: type == OrderType.normal
            ? 'N${_orders.length + 1}'
            : 'V${_orders.length + 1}',
        type: type,
        status: OrderStatus.pending,
        duration: type == OrderType.normal ? 10 : 5,
      ),
    );
    checkOperation();
    notifyListeners();
  }

  void addBot() {
    _bots.add(BotDetail(id: _bots.length + 1, order: null));
    checkOperation();
    notifyListeners();
  }

  void deleteBot() {
    if (_bots.isNotEmpty) {
      BotDetail newestBot = _bots.last;
      if (newestBot.order != null) {
        _orders.firstWhere((order) => order.id == newestBot.order).status =
            OrderStatus.pending;
      }
      _bots.removeLast();
    }
    notifyListeners();
  }

  checkOperation() {
    var availableBotList = bots.where((bot) => bot.order == null).toList();
    var availableOrderList =
        orders.where((order) => order.status == OrderStatus.pending).toList();
    if (availableBotList.isNotEmpty && availableOrderList.isNotEmpty) {
      int vipSearcher =
          availableOrderList.indexWhere((order) => order.type == OrderType.vip);
      if (vipSearcher == -1) vipSearcher = 0;
      availableBotList[0].order = availableOrderList[0].id;
      availableOrderList[vipSearcher].status = OrderStatus.processing;
      processOperation(availableBotList[0], availableOrderList[vipSearcher]);
      availableBotList.removeAt(0);
      availableOrderList.removeAt(vipSearcher);
    }
  }

  processOperation(BotDetail bot, OrderItem order) {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      debugPrint(timer.tick.toString());
      if (order.duration == 0) {
        bot.order = null;
        order.status = OrderStatus.completed;
        checkOperation();
        notifyListeners();
        timer.cancel();
      } else {
        order.duration--;
        notifyListeners();
      }
    });
  }
}
