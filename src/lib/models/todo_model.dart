import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
  });

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  @override
  List<Object?> get props => [id, title, description, isCompleted, createdAt];
}
