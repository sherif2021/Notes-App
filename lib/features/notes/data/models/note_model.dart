import 'package:clean_arch_example/features/notes/domain/entities/note.dart';

class NoteModel extends Note {
  const NoteModel({
    required super.title,
    required super.content,
    required super.createdAt,
    super.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'is_completed': isCompleted,
      'created_at': createdAt.toString(),
    };
  }

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
      content: map['content'] as String,
      title: map['title'] as String,
      isCompleted: map['is_completed'] as bool,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}
