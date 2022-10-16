// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task()
      ..taskName = fields[0] as String
      ..taskDue = fields[1] as DateTime?
      ..taskETA = fields[2] as DateTimeRange?
      ..taskDescriptions = fields[3] as String?
      ..subtasks = (fields[4] as List?)?.cast<Subtask>()
      ..completedSubtasksNum = fields[5] as int?
      ..isCompleted = fields[6] as bool;
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.taskDue)
      ..writeByte(2)
      ..write(obj.taskETA)
      ..writeByte(3)
      ..write(obj.taskDescriptions)
      ..writeByte(4)
      ..write(obj.subtasks)
      ..writeByte(5)
      ..write(obj.completedSubtasksNum)
      ..writeByte(6)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
