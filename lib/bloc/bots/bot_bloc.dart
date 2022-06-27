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
  }
  void _fetchBotList(FetchBotList event, Emitter<BotState> emit) {
    emit(
      BotState(botList: event.botList),
    );
  }

  void _addBot(AddBot event, Emitter<BotState> emit) {
    emit(
      BotState(
        botList: List.from(state.botList)
          ..add(
            BotDetail(
              id: '${state.botList.length + 1}',
            ),
          ),
      ),
    );
  }

  void _deleteBot(DeleteBot event, Emitter<BotState> emit) {
    List<BotDetail> botList = state.botList;
    botList.removeLast();
    emit(
      BotState(botList: botList),
    );
  }
}
