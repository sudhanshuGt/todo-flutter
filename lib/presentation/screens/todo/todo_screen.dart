import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/todo.dart';
import '../../controller/todo_controller.dart';

/// Todo screen displaying the list of user's todos.
///
/// Uses [TodoController] for state management and handles:
/// - Viewing todos
/// - Adding new todos
/// - Editing existing todos (including completion status)
/// - Deleting todos
class TodoPage extends GetView<TodoController> {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Controller for capturing new todo input text
    final newTodoCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('My Todo')),

      // Reactive body that rebuilds on state changes
      body: Obx(() {
        // Show loading indicator while fetching data
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show error message if any
        if (controller.error.value != null) {
          return Center(
            child: Text(
              controller.error.value!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // Show the list of todos
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: controller.todos.length,
          itemBuilder: (_, i) {
            final t = controller.todos[i];
            return ListTile(
              leading: const Icon(Icons.task_sharp),
              title: Text(
                t.todo,
                style: TextStyle(
                  // Strike-through completed todos
                  decoration: t.completed ? TextDecoration.lineThrough : null,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit todo button
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(context, t),
                  ),
                  // Delete todo button
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => controller.remove(t),
                  ),
                ],
              ),
            );
          },
        );
      }),

      // Floating action button to add new todos
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.defaultDialog(
          title: 'Add Todo',
          content: TextField(
            controller: newTodoCtrl,
            decoration: const InputDecoration(hintText: 'What to do?'),
          ),
          textConfirm: 'Add',
          onConfirm: () {
            final text = newTodoCtrl.text.trim();
            if (text.isNotEmpty) {
              controller.add(text); // Add new todo via controller
              newTodoCtrl.clear();  // Clear input field after adding
            }
            Get.back(); // Close dialog
          },
          textCancel: 'Cancel',
        ),
      ),
    );
  }

  /// Shows an editable dialog for updating [todo]'s text and completion status.
  void _showEditDialog(BuildContext context, Todo todo) {
    final editCtrl = TextEditingController(text: todo.todo);
    bool isCompleted = todo.completed;

    Get.defaultDialog(
      title: 'Edit Todo',
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Editable text field for todo text
              TextField(
                controller: editCtrl,
                decoration: const InputDecoration(hintText: 'Edit todo'),
              ),
              // Checkbox to toggle completion status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Completed'),
                  Checkbox(
                    value: isCompleted,
                    onChanged: (val) {
                      setState(() {
                        isCompleted = val ?? false;
                      });
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
      textConfirm: 'Save',
      onConfirm: () {
        final newText = editCtrl.text.trim();
        // Update todo with new text and completion status
        controller.toggleComplete(
          Todo(
            id: todo.id,
            todo: newText.isNotEmpty ? newText : todo.todo,
            completed: isCompleted,
          ),
        );
        Get.back(); // Close dialog after saving
      },
      textCancel: 'Cancel',
    );
  }
}
