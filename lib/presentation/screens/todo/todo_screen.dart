import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/todo.dart';
import '../../controller/todo_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/todo_controller.dart';

class TodoPage extends GetView<TodoController> {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final newTodoCtrl = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('My Todos')),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value != null) {
          return Center(
            child: Text(
              controller.error.value!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

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
                  decoration: t.completed
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(context, t),
                  ),
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.defaultDialog(
          title: 'Add Todo',
          content: TextField(
            controller: newTodoCtrl,
            decoration:
            const InputDecoration(hintText: 'What to do?'),
          ),
          textConfirm: 'Add',
          onConfirm: () {
            final text = newTodoCtrl.text.trim();
            if (text.isNotEmpty) {
              controller.add(text);
              newTodoCtrl.clear();
            }
            Get.back();
          },
          textCancel: 'Cancel',
        ),
      ),
    );
  }

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
              TextField(
                controller: editCtrl,
                decoration:
                const InputDecoration(hintText: 'Edit todo'),
              ),
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
        controller.toggleComplete(Todo(id: todo.id, todo: newText.isNotEmpty ? newText : todo.todo, completed: isCompleted));
        Get.back();
      },
      textCancel: 'Cancel',
    );
  }
}
