import 'package:feedme_assignment/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}


// import 'package:feedme_assignment/bloc/bots/bot_bloc.dart';
// import 'package:feedme_assignment/bloc/orders/order_bloc.dart';
// import 'package:feedme_assignment/home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (BuildContext context) => BotBloc()
//             ..add(
//               const FetchBotList(),
//             ),
//         ),
//         BlocProvider(
//           create: (BuildContext context) =>
//               OrderBloc()
//                 ..add(
//                   const FetchOrderList(),
//                 ),
//         ),
//       ],
//       child: MaterialApp(
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const HomeScreen(),
//       ),
//     );
//   }
// }
