class BotDetail {
  int id;
  String? order;

  BotDetail({
    required this.id,
    required this.order,
  });

  BotDetail copyWith({
    int? id,
    String? order,
  }) {
    return BotDetail(
      id: id ?? this.id,
      order: order,
    );
  }
}
