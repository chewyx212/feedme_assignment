import 'package:feedme_assignment/model/order_item.dart';
import 'package:flutter/material.dart';

class OrderModel extends ChangeNotifier {
  List<OrderItem> _orderList = [];

  List<OrderItem> get orderList => _orderList;

  set addOrder(OrderItem value) {
    _orderList.add(value);
  }

  changeOrder(OrderItem value) {
    int result = _orderList.indexWhere((order) => order.id == value.id);
    if (result != -1) {
      _orderList[result] = value;
    }
  }
}
