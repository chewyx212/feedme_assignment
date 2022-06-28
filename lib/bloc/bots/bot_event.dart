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
  const AddBot();
  @override
  List<Object> get props => [];
}

class DeleteBot extends BotEvent {
  @override
  List<Object> get props => [];
}

class AddOrderToBot extends BotEvent {
  final String botId;
  final String orderId;

  const AddOrderToBot({
    required this.botId,
    required this.orderId,
  });

  @override
  List<Object> get props => [botId, orderId];
}
