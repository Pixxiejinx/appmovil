import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flu_app/presentation/providers/todo_provider.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  ConsumerState<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  final TextEditingController _textController = TextEditingController();

  void _mostrarDialogoNuevaTarea() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.pink.shade50,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('✍️ Escribe tu tarea',
              style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _textController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: '¿Qué vas a lograr hoy?',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () {
                if (_textController.text.isNotEmpty) {
                  ref.read(todoListProvider.notifier).addTarea(_textController.text);
                  _textController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Añadir 🎀'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tareas = ref.watch(todoListProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFCE4EC),
      appBar: AppBar(
        title: const Text('TO DO LIST CUTE', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.pink.shade700,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final tarea = tareas[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.pink.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Image.asset(
                      'assets/images/vecteezy_flat-design-pixel-art-pink-ribbon-illustration_55078105.png',
                      width: 35,
                    ),
                    title: Text(
                      tarea.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: tarea.isCompleted ? TextDecoration.lineThrough : null,
                        color: tarea.isCompleted ? Colors.grey : Colors.pink.shade900,
                      ),
                    ),
                    trailing: Wrap(
                      spacing: -7,
                      children: [
                        IconButton(
                          icon: Icon(tarea.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                              color: tarea.isCompleted ? Colors.green : Colors.pink.shade200),
                          onPressed: () => ref.read(todoListProvider.notifier).toggleTarea(tarea.id),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.pinkAccent),
                          onPressed: () => ref.read(todoListProvider.notifier).removeTarea(tarea.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          GestureDetector(
            onTap: _mostrarDialogoNuevaTarea,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 30),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    'assets/images/—Pngtree—pink retro typewriter_4544051.png',
                    width: 320,
                    fit: BoxFit.contain,
                  ),
                  
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.pink.shade200, width: 2),
                      ),
                      child: Text(
                        '¿qué sueños vas a cumplir hoy?',
                        style: TextStyle(
                          color: Colors.pink.shade800,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}