class Todo {
  final int id;
  final String todo;
  final bool completed;
  const Todo({required this.id, required this.todo, required this.completed});

  Todo copyWith({int? id, String? todo, bool? completed}) => Todo(
    id: id ?? this.id,
    todo: todo ?? this.todo,
    completed: completed ?? this.completed,
  );
}
