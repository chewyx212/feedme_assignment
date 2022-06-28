// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:feedme_assignment/model/bot_detail.dart';
import 'package:feedme_assignment/model/order_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  List<BotDetail> botList = [];
  List<OrderItem> orderList = [];

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkOperation());
  }

  checkOperation() {
    if (botList.where((bot) => bot.queue.isEmpty).isNotEmpty &&
        orderList
            .where((order) => order.status == OrderStatus.pending)
            .isNotEmpty) {
      startOperation();
    }
  }

  startOperation() {
    List<BotDetail> availableBotList =
        botList.where((bot) => bot.queue.isEmpty).toList();
    List<OrderItem> availableOrderList = orderList
        .where((order) =>
            order.type == OrderType.vip && order.status == OrderStatus.pending)
        .toList();
    availableOrderList.addAll(orderList
        .where((order) =>
            order.type == OrderType.normal &&
            order.status == OrderStatus.pending)
        .toList());

    while (availableBotList.isNotEmpty && availableOrderList.isNotEmpty) {
      setState(() {
        botList
            .firstWhere((bot) => bot.id == availableBotList[0].id)
            .queue
            .add(availableOrderList[0].id);
        orderList
            .firstWhere((order) => order.id == availableOrderList[0].id)
            .status = OrderStatus.processing;
      });
      processOperation(availableBotList[0].id, availableOrderList[0].id);

      availableBotList.removeAt(0);
      availableOrderList.removeAt(0);
    }
  }

  processOperation(String botId, String orderId) {
    Future.delayed(const Duration(seconds: 10), () {
      if (botList.firstWhereOrNull((bot) => bot.id == botId) != null &&
          orderList.firstWhere((order) => order.id == orderId).status ==
              OrderStatus.processing) {
        setState(() {
          botList.firstWhere((bot) => bot.id == botId).queue.removeFirst();
          orderList.firstWhere((order) => order.id == orderId).status =
              OrderStatus.completed;
        });
      }
    });
  }

  addNormal() {
    setState(() {
      orderList.add(
        OrderItem(
            id: 'N${orderList.length + 1}',
            type: OrderType.normal,
            status: OrderStatus.pending),
      );
    });
  }

  addVip() {
    setState(() {
      orderList.add(
        OrderItem(
          id: 'V${orderList.length + 1}',
          type: OrderType.vip,
          status: OrderStatus.pending,
        ),
      );
    });
  }

  addBot() {
    setState(() {
      botList.add(
        BotDetail(
          id: '${botList.length + 1}',
          queue: Queue<String>(),
        ),
      );
    });
  }

  deleteBot() {
    BotDetail newestBot = botList.last;
    print('this is the newest bot');
    print(newestBot.id);
    print(newestBot.queue);
    print(newestBot.queue.first);
    setState(() {
      if (newestBot.queue.isNotEmpty) {
        orderList
            .firstWhere((order) => order.id == newestBot.queue.first)
            .status = OrderStatus.pending;
      }
      botList.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 40.0,
            left: 20.0,
            right: 20.0,
            bottom: 20.0,
          ),
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addNormal,
                    child: Text('Add Normal'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: addVip,
                    child: Text('Add VIP'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addBot,
                    child: Text('+ Bot'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: deleteBot,
                    child: Text('- Bot'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Active Bot: ${botList.length}'),
                    Text(
                        'Processing Bot: ${botList.where((bot) => bot.queue.isNotEmpty).length}'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                        'Pending Order: ${orderList.where((order) => order.status == OrderStatus.pending).length}'),
                    Text(
                        'Processing Order: ${orderList.where((order) => order.status == OrderStatus.processing).length}'),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return Text(
                        orderList[index].id + orderList[index].status.name);
                  },
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
