// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_details_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieDetailsDbAdapter extends TypeAdapter<MovieDetailsDb> {
  @override
  final int typeId = 1;

  @override
  MovieDetailsDb read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieDetailsDb(
      id: fields[0] as int,
      title: fields[1] as String,
      imageUrl: fields[3] as String,
      overView: fields[4] as String,
      popularity: fields[5] as double,
      releaseDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MovieDetailsDb obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.releaseDate)
      ..writeByte(3)
      ..write(obj.imageUrl)
      ..writeByte(4)
      ..write(obj.overView)
      ..writeByte(5)
      ..write(obj.popularity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieDetailsDbAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
