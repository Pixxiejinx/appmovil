import 'package:flutter_riverpod/legacy.dart';


class TodoTask {
  final String id;
  final String title;
  final bool isCompleted;

  TodoTask({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  TodoTask copyWith({bool? isCompleted}) {
    return TodoTask(
      id: id,
      title: title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class TodoListNotifier extends StateNotifier<List<TodoTask>> {
  TodoListNotifier() : super([
    TodoTask(id: '1', title: 'Estudiar Flutter 🦄'),
    TodoTask(id: '2', title: 'Hacer la colada ✨', isCompleted: true),
  ]);

  void addTarea(String titulo) {
    final nuevaTarea = TodoTask(
      id: DateTime.now().toString(),
      title: titulo,
    );
    state = [...state, nuevaTarea];
  }

  void toggleTarea(String id) {
    state = [
      for (final tarea in state)
        if (tarea.id == id) tarea.copyWith(isCompleted: !tarea.isCompleted) else tarea
    ];
  }

  void removeTarea(String id) {
    state = state.where((tarea) => tarea.id != id).toList();
  }
}


final todoListProvider = StateNotifierProvider<TodoListNotifier, List<TodoTask>>((ref) {
  return TodoListNotifier();
});