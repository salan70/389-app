// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_condition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchConditionAdapter extends TypeAdapter<SearchCondition> {
  @override
  final int typeId = 1;

  @override
  SearchCondition read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchCondition(
      teamList: (fields[0] as List).cast<String>(),
      minGames: fields[1] as int,
      minHits: fields[3] as int,
      minHr: fields[4] as int,
      selectedStatsList: (fields[5] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, SearchCondition obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.teamList)
      ..writeByte(1)
      ..write(obj.minGames)
      ..writeByte(3)
      ..write(obj.minHits)
      ..writeByte(4)
      ..write(obj.minHr)
      ..writeByte(5)
      ..write(obj.selectedStatsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchConditionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
