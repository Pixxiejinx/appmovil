import 'package:flutter_riverpod/legacy.dart';

// 1. Definimos qué es una Tarea Cute
class TodoTask {
  final String id;
  final String title;
  final bool isCompleted;

  TodoTask({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  // Copiar el objeto cambiando solo el estado de completado
  TodoTask copyWith({bool? isCompleted}) {
    return TodoTask(
      id: id,
      title: title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// 2. El Notifier que maneja la lista global
class TodoListNotifier extends StateNotifier<List<TodoTask>> {
  TodoListNotifier() : super([
    TodoTask(id: '1', title: 'Estudiar Flutter 🦄'),
    TodoTask(id: '2', title: 'Hacer la colada ✨', isCompleted: true),
  ]);

  void addTarea(String titulo) {
    final nuevaTarea = TodoTask(
      id: DateTime.now().toString(), // Un ID único usando el tiempo actual
      title: titulo,
    );
    state = [...state, nuevaTarea];
  }

  // Cambiar el estado de la tarea (el tick ✔️)
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

// 3. El Provider global que expondremos a la app
final todoListProvider = StateNotifierProvider<TodoListNotifier, List<TodoTask>>((ref) {
  return TodoListNotifier();
});