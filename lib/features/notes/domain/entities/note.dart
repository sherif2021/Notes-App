import 'package:clean_arch_example/core/database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int? id;
  final String title;
  final String content;
  final bool isCompleted;
  final DateTime createdAt;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [title, content, createdAt, isCompleted];

  factory Note.fromData(NoteModelData data) => Note(
        id: data.id,
        title: data.title,
        content: data.content,
        createdAt: data.createdAt,
        isCompleted: data.isCompleted,
      );

  NoteModelCompanion toCompanion() => NoteModelCompanion(
        id: id == null ? const Value.absent() : Value(id!),
        title: Value(title),
        content: Value(content),
        createdAt: Value(createdAt),
        isCompleted: Value(isCompleted),
      );
}
