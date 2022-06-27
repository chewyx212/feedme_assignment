// ignore_for_file: prefer_const_constructors

import 'package:feedme_assignment/bloc/orders/order_bloc.dart';
import 'package:feedme_assignment/model/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {},
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<OrderBloc>().add(
                              AddOrder(
                                type: OrderType.normal,
                              ),
                            );
                      },
                      child: Text('Add Normal'),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<OrderBloc>().add(
                              AddOrder(
                                type: OrderType.vip,
                              ),
                            );
                      },
                      child: Text('Add VIP'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('+ Bot'),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('- Bot'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Active Bot: 0'),
                        Text('Processing Bot: 1'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                            'Pending Order: ${state.orderList.where((order) => order.status == OrderStatus.pending).length}'),
                        Text('Processing Order: 1'),
                      ],
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.orderList.length,
                      itemBuilder: (context, index) {
                        return Text(
                            '${state.orderList[index].id} - ${state.orderList[index].status.name}');
                      },
                    ),
                  ],
                );
              },
            ),
          ]),
        ),
      ),
    );
  }
}
