// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'category.g.dart';

abstract class Category extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String img;

  Category(
    this.title,
    this.img,
  );

  @override
  String toString() => title;
}

@HiveType(typeId: 4)
class Expense extends Category {
  Expense(super.title, super.img);
}

@HiveType(typeId: 5)
class Income extends Category {
  Income(super.title, super.img);
}
