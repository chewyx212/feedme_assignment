import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedme_assignment/model/bot_detail.dart';

part 'bot_event.dart';
part 'bot_state.dart';

class BotBloc extends Bloc<BotEvent, BotState> {
  BotBloc() : super(BotState()) {
    on<FetchBotList>(_fetchBotList);
    on<AddBot>(_addBot);
    on<DeleteBot>(_deleteBot);
    on<AddOrderToBot>(_addOrderToBot);
  }
  void _fetchBotList(FetchBotList event, Emitter<BotState> emit) {
    emit(
      BotState(botList: event.botList),
    );
  }

  void _addBot(AddBot event, Emitter<BotState> emit) {
    print('added bot');
    emit(
      BotState(
        botList: List.from(state.botList)
          ..add(
            BotDetail(
              id: '${state.botList.length + 1}',
              queue: Queue<String>(),
            ),
          ),
      ),
    );
  }

  void _deleteBot(DeleteBot event, Emitter<BotState> emit) {
    final state = this.state;
    List<BotDetail> botList = state.botList;
    botList.removeLast();
    emit(
      BotState(botList: botList),
    );
  }

  void _addOrderToBot(AddOrderToBot event, Emitter<BotState> emit) {
    final state = this.state;
    List<BotDetail> botList = state.botList.map((bot) {
      if (bot.id == event.botId) {
        bot.queue.add(event.orderId);
      }
      return bot;
    }).toList();

    emit(
      BotState(botList: botList),
    );
    if (emit.isDone) {
      print(state.botList);
      Future.delayed(Duration(milliseconds: 10000), () {
        List<BotDetail> newBotList = state.botList.map((bot) {
          if (bot.id == event.botId) {
            bot.queue.remove(event.orderId);
          }
          return bot;
        }).toList();
        print('new bot list');
        print(newBotList);
        emit(
          BotState(botList: newBotList),
        );
      });
    }
  }
}
