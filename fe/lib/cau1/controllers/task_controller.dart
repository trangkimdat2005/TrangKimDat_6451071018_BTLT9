import 'package:get/get.dart';
import 'package:fe/cau1/data/models/task_model.dart';
import 'package:fe/cau1/data/services/task_service.dart';

class TaskController extends GetxController {
  final TaskService _taskService = TaskService();
  final RxList<TaskModel> tasks = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _bindTasks();
  }

  void _bindTasks() {
    _taskService.getTasks().listen(
      (taskList) {
        tasks.assignAll(taskList);
      },
      onError: (error) {
        // ignore — stream error silently
      },
    );
  }

  Future<void> addTask(String title) async {
    if (title.trim().isEmpty) return;
    await _taskService.addTask(title.trim());
  }

  Future<void> toggleTask(String id, bool isDone) async {
    await _taskService.toggleTask(id, isDone);
  }

  Future<void> deleteTask(String id) async {
    await _taskService.deleteTask(id);
  }
}
