// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TutorHiveModelAdapter extends TypeAdapter<TutorHiveModel> {
  @override
  final int typeId = 1;

  @override
  TutorHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TutorHiveModel(
      id: fields[0] as String?,
      name: fields[1] as String,
      email: fields[2] as String,
      username: fields[3] as String,
      profileImage: fields[4] as String,
      bio: fields[5] as String,
      hourlyRate: fields[6] as double,
      description: fields[7] as String,
      rating: fields[8] as double,
      subjects: (fields[9] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TutorHiveModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.profileImage)
      ..writeByte(5)
      ..write(obj.bio)
      ..writeByte(6)
      ..write(obj.hourlyRate)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.subjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TutorHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
