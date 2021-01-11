import 'package:hive/hive.dart';

part 'history_item.g.dart';

@HiveType(typeId: 0)
class HistoryItem {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final String date;

  HistoryItem({this.description, this.date});
}
