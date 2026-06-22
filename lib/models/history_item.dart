import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'history_item.g.dart';

@HiveType(typeId: 0)
class HistoryItem {
  @HiveField(0)
  final String description;

  @HiveField(1)
  final String date;

  HistoryItem({required this.description, required this.date});
}
