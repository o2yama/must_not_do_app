import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1)();
  TextColumn get purpose => text().withLength(min: 1)();
  TextColumn get detail => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updateAt => dateTime()();
  IntColumn get breakCount => integer().withDefault(const Constant(0))();
}
