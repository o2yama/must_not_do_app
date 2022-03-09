import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1)();
  TextColumn get detail => text().nullable()();
  BoolColumn get isTodo => boolean()();
}
