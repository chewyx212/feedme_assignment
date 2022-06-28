import 'dart:collection';

import 'package:equatable/equatable.dart';

class BotDetail extends Equatable {
  String id;
  Queue<String> queue;

  BotDetail({
    required this.id,
    required this.queue,
  });

  BotDetail copyWith({
    String? id,
    Queue<String>? queue,
  }) {
    return BotDetail(
      id: id ?? this.id,
      queue: queue ?? this.queue,
    );
  }

  @override
  List<Object?> get props => [
        id,
        queue,
      ];
}
