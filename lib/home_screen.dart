// ignore_for_file: prefer_const_constructors
import 'package:feedme_assignment/model/order_item.dart';
import 'package:feedme_assignment/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final orderProvider =
    StateNotifierProvider<OrderProvider, OrderProviderType>((ref) {
  return OrderProvider();
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // use ref to listen to a provider
    final orderProviderState = ref.watch(orderProvider);
    final botList = orderProviderState.botList;
    final orderList = orderProviderState.orderList;
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
                    onPressed: () {
                       ref
                          .read(orderProvider.notifier)
                          .addOrder(OrderType.normal);
                    },
                    child: Text('Add Normal'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      
                      ref.read(orderProvider.notifier).addOrder(OrderType.vip);
                    },
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
                    onPressed: () {
                      
                      ref.read(orderProvider.notifier).addBot();
                    },
                    child: Text('+ Bot'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      
                      ref.read(orderProvider.notifier).deleteBot();
                    },
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
                        'Processing Bot: ${botList.where((bot) => bot.order != null).length}'),
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
                        "Order ${orderList[index].id} - ${orderList[index].status.name} - ${orderList[index].status == OrderStatus.processing ? orderList[index].duration : ''}");
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
