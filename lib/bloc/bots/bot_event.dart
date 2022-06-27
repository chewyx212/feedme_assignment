part of 'bot_bloc.dart';

abstract class BotEvent extends Equatable {
  const BotEvent();

  @override
  List<Object> get props => [];
}

class FetchBotList extends BotEvent {
  final List<BotDetail> botList;

  const FetchBotList({
    this.botList = const [],
  });
  @override
  List<Object> get props => [botList];
}

class AddBot extends BotEvent {
  final BotDetail bot;

  const AddBot({
    required this.bot,
  });
  @override
  List<Object> get props => [bot];
}

class DeleteBot extends BotEvent {
  const DeleteBot();
  @override
  List<Object> get props => [];
}
