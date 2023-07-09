import 'package:clean_arch_example/features/notes/data/models/note_model.dart';
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String title;
  final String content;
  final bool isCompleted;
  final DateTime createdAt;

  const Note({
    required this.title,
    required this.content,
    required this.createdAt,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [title, content];

  NoteModel get toModel => NoteModel(
        title: title,
        content: content,
        createdAt: createdAt,
        isCompleted: isCompleted,
      );
}
