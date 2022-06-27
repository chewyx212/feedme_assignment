// ignore_for_file: must_be_immutable

part of 'bot_bloc.dart';

class BotState extends Equatable {
  List<BotDetail> botList;

  BotState({
    this.botList = const [],
  });

  BotState copyWith({
    List<BotDetail>? botList,
  }) {
    return BotState(
      botList: botList ?? this.botList,
    );
  }

  @override
  List<Object> get props => [botList];
}
