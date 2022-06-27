import 'package:equatable/equatable.dart';

class BotDetail extends Equatable {
  String id;
  String? processingOrder;

  BotDetail({
    required this.id,
    this.processingOrder,
  });

  @override
  List<Object?> get props => [
        id,
        processingOrder,
      ];
}
