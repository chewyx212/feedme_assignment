// // ignore_for_file: prefer_const_constructors
// import 'package:collection/collection.dart';
// import 'dart:collection';

// import 'package:feedme_assignment/bloc/bots/bot_bloc.dart';
// import 'package:feedme_assignment/bloc/orders/order_bloc.dart';
// import 'package:feedme_assignment/model/order_item.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.only(
//             top: 40.0,
//             left: 20.0,
//             right: 20.0,
//             bottom: 20.0,
//           ),
//           constraints: BoxConstraints(
//             minHeight: MediaQuery.of(context).size.height,
//           ),
//           child: MultiBlocListener(
//             listeners: [
//               BlocListener<OrderBloc, OrderState>(
//                 listener: (context, state) {},
//               ),
//               BlocListener<BotBloc, BotState>(
//                 listener: (context, state) async {
//                   var availableBotList =
//                       state.botList.where((bot) => bot.queue.isEmpty);
//                   if (availableBotList.isNotEmpty &&
//                       BlocProvider.of<OrderBloc>(context)
//                           .state
//                           .orderList
//                           .where((order) => order.status == OrderStatus.pending)
//                           .isNotEmpty) {
//                     List<OrderItem> order;

//                     order = BlocProvider.of<OrderBloc>(context)
//                         .state
//                         .orderList
//                         .where((order) =>
//                             order.type == OrderType.vip &&
//                             order.status == OrderStatus.pending)
//                         .toList();
//                     if (order.isEmpty) {
//                       order = BlocProvider.of<OrderBloc>(context)
//                           .state
//                           .orderList
//                           .where((order) => order.status == OrderStatus.pending)
//                           .toList();
//                     }

//                     if (order.isNotEmpty) {
//                       for (var availableBot in availableBotList) {
//                         if (order.isNotEmpty) {
//                           context.read<OrderBloc>().add(
//                                 ChangeOrder(
//                                   item: order[0]
//                                       .copyWith(status: OrderStatus.processing),
//                                 ),
//                               );
//                           context.read<BotBloc>().add(
//                                 AddOrderToBot(
//                                   botId: availableBot.id,
//                                   orderId: order[0].id,
//                                 ),
//                               );
//                           order.removeAt(0);
//                           print('removed');
//                           print(order);
//                         }
//                       }
//                     }
//                   }
//                 },
//               ),
//             ],
//             child: Column(children: [
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         context.read<OrderBloc>().add(
//                               AddOrder(
//                                 type: OrderType.normal,
//                               ),
//                             );
//                       },
//                       child: Text('Add Normal'),
//                     ),
//                   ),
//                   const SizedBox(width: 10.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         context.read<OrderBloc>().add(
//                               AddOrder(
//                                 type: OrderType.vip,
//                               ),
//                             );
//                       },
//                       child: Text('Add VIP'),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 30.0,
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         context.read<BotBloc>().add(
//                               AddBot(),
//                             );
//                       },
//                       child: Text('+ Bot'),
//                     ),
//                   ),
//                   const SizedBox(width: 10.0),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: Text('- Bot'),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 30.0,
//               ),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                           'Active Bot: ${BlocProvider.of<BotBloc>(context, listen: true).state.botList.length}'),
//                       Text(
//                           'Processing Bot: ${BlocProvider.of<BotBloc>(context, listen: true).state.botList.where((bot) => bot.queue.isNotEmpty).length}'),
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                           'Pending Order: ${BlocProvider.of<OrderBloc>(context, listen: true).state.orderList.where((order) => order.status == OrderStatus.pending).length}'),
//                       Text(
//                           'Processing Order: ${BlocProvider.of<OrderBloc>(context, listen: true).state.orderList.where((order) => order.status == OrderStatus.processing).length}'),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 30.0,
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: BlocProvider.of<OrderBloc>(context, listen: true)
//                         .state
//                         .orderList
//                         .length,
//                     itemBuilder: (context, index) {
//                       return Text(
//                           '${BlocProvider.of<OrderBloc>(context).state.orderList[index].id} - ${BlocProvider.of<OrderBloc>(context).state.orderList[index].status.name}');
//                     },
//                   ),
//                 ],
//               )
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }
