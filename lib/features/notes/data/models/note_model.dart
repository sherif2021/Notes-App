import 'package:equatable/equatable.dart';
import 'package:drift/drift.dart';

class NoteModel extends Table with EquatableMixin {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  DateTimeColumn get createdAt => dateTime()();

  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  // NoteModel({
  //   required this.title,
  //   required this.content,
  //   required this.createdAt,
  //   this.isCompleted = false,
  // });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'is_completed': isCompleted,
      'created_at': createdAt.toString(),
    };
  }

  // factory NoteModel.fromJson(Map<String, dynamic> map) {
  //   return NoteModel(
  //     content: map['content'] as String,
  //     title: map['title'] as String,
  //     isCompleted: map['is_completed'] as bool,
  //     createdAt: DateTime.parse(map['created_at'] as String),
  //   );
  // }

  @override
  List<Object?> get props => [
        title,
        content,
        createdAt,
        isCompleted,
      ];
}
