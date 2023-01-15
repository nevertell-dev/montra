// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionAdapter extends TypeAdapter<Transaction> {
  @override
  final int typeId = 0;

  @override
  Transaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transaction(
      amount: fields[0] as double,
      category: fields[1] as Category,
      date: fields[2] as DateTime,
      note: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Transaction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.note);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DailyAdapter extends TypeAdapter<Daily> {
  @override
  final int typeId = 1;

  @override
  Daily read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Daily(
      balance: fields[0] as double,
      income: fields[1] as double,
      expense: fields[2] as double,
      highestIncome: fields[3] as double,
      highestExpense: fields[4] as double,
      transactions: (fields[5] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Daily obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.income)
      ..writeByte(2)
      ..write(obj.expense)
      ..writeByte(3)
      ..write(obj.highestIncome)
      ..writeByte(4)
      ..write(obj.highestExpense)
      ..writeByte(5)
      ..write(obj.transactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MonthlyAdapter extends TypeAdapter<Monthly> {
  @override
  final int typeId = 2;

  @override
  Monthly read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Monthly(
      balance: fields[0] as double,
      income: fields[1] as double,
      expense: fields[2] as double,
      highestIncome: fields[3] as double,
      highestExpense: fields[4] as double,
      transactions: (fields[5] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Monthly obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.income)
      ..writeByte(2)
      ..write(obj.expense)
      ..writeByte(3)
      ..write(obj.highestIncome)
      ..writeByte(4)
      ..write(obj.highestExpense)
      ..writeByte(5)
      ..write(obj.transactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class YearlyAdapter extends TypeAdapter<Yearly> {
  @override
  final int typeId = 3;

  @override
  Yearly read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Yearly(
      balance: fields[0] as double,
      income: fields[1] as double,
      expense: fields[2] as double,
      highestIncome: fields[3] as double,
      highestExpense: fields[4] as double,
      transactions: (fields[5] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Yearly obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.balance)
      ..writeByte(1)
      ..write(obj.income)
      ..writeByte(2)
      ..write(obj.expense)
      ..writeByte(3)
      ..write(obj.highestIncome)
      ..writeByte(4)
      ..write(obj.highestExpense)
      ..writeByte(5)
      ..write(obj.transactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearlyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
