import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fe/cau1/controllers/task_controller.dart';

class Cau1Screen extends StatefulWidget {
  const Cau1Screen({super.key});

  @override
  State<Cau1Screen> createState() => _Cau1ScreenState();
}

class _Cau1ScreenState extends State<Cau1Screen> {
  late final TaskController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = Get.put(TaskController());
  }

  void _showAddTaskDialog() {
    final textController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Them Cong Viec'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: 'Nhap tieu de cong viec',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Huy'),
          ),
          FilledButton(
            onPressed: () {
              _taskController.addTask(textController.text);
              Navigator.pop(context);
            },
            child: const Text('Luu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bai 1: To-do List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Obx(() {
        if (_taskController.tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_alt,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'Chua co cong viec nao',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Nhan + de them cong viec',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'MSSV: 6451071018',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                itemCount: _taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = _taskController.tasks[index];
                  return Dismissible(
                    key: Key(task.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      color: Colors.red,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      return await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Xac Nhan Xoa'),
                          content: const Text('Ban co chac chan muon xoa cong viec nay?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Huy'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(context, true),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Xoa'),
                            ),
                          ],
                        ),
                      );
                    },
                    onDismissed: (_) => _taskController.deleteTask(task.id),
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      child: CheckboxListTile(
                        value: task.isDone,
                        onChanged: (value) {
                          _taskController.toggleTask(task.id, value ?? false);
                        },
                        title: Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            decoration: task.isDone ? TextDecoration.lineThrough : null,
                            color: task.isDone
                                ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)
                                : null,
                          ),
                        ),
                        subtitle: Text(
                          _formatDate(task.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'MSSV: 6451071018',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddTaskDialog,
        icon: const Icon(Icons.add),
        label: const Text('Them'),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
