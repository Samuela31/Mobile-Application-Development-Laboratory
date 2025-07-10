import 'dart:io';

class Task {
  String name;
  String description;
  bool completed;

  Task(this.name, this.description, this.completed);
}

void main() {
  final List<Task> tasks = [];

  while (true) {
    print('Select an option:');
    print('1 - Add Task');
    print('2 - Mark Task as Completed');
    print('3 - Remove Task');
    print('4 - Show All Tasks');
    print('5 - Show Completed Tasks');
    print('6 - Show Incomplete Tasks');
    print('7 - Quit');

    String choice = stdin.readLineSync() ?? '';
    switch (choice) {
      case '1':
        addTask(tasks);
        break;
      case '2':
        markTaskAsCompleted(tasks);
        break;
      case '3':
        removeTask(tasks);
        break;
      case '4':
        showTasks(tasks);
        break;
      case '5':
        showCompletedTasks(tasks);
        break;
      case '6':
        showIncompleteTasks(tasks);
        break;
      case '7':
        return;
      default:
        print('Invalid option. Please try again.');
    }
  }
}

void addTask(List<Task> tasks) {
  print('Enter the task name:');
  String name = stdin.readLineSync() ?? '';
  print('Enter the task description:');
  String description = stdin.readLineSync() ?? '';

  tasks.add(Task(name, description, false));
  print('Task added successfully.');
}

void markTaskAsCompleted(List<Task> tasks) {
  print('Enter the task name to mark as completed:');
  String taskName = stdin.readLineSync() ?? '';

  bool found = false;
  for (var task in tasks) {
    if (task.name == taskName) {
      task.completed = true;
      print('Task marked as completed.');
      found = true;
      break;
    }
  }

  if (!found) {
    print('Task not found.');
  }
}

void removeTask(List<Task> tasks) {
  print('Enter the task name to remove:');
  String taskName = stdin.readLineSync() ?? '';

  bool found = false;
  tasks.removeWhere((task) {
    if (task.name == taskName) {
      found = true;
      return true;
    }
    return false;
  });

  if (found) {
    print('Task removed successfully.');
  } else {
    print('Task not found.');
  }
}

void showTasks(List<Task> tasks) {
  if (tasks.isEmpty) {
    print('No tasks found.');
  } else {
    for (var task in tasks) {
      printTask(task);
    }
  }
}

void showCompletedTasks(List<Task> tasks) {
  final completedTasks = tasks.where((task) => task.completed);
  if (completedTasks.isEmpty) {
    print('No completed tasks found.');
  } else {
    for (var task in completedTasks) {
      printTask(task);
    }
  }
}

void showIncompleteTasks(List<Task> tasks) {
  final incompleteTasks = tasks.where((task) => !task.completed);
  if (incompleteTasks.isEmpty) {
    print('No incomplete tasks found.');
  } else {
    for (var task in incompleteTasks) {
      printTask(task);
    }
  }
}

void printTask(Task task) {
  print('Task Name: ${task.name}');
  print('Task Description: ${task.description}');
  print('Completed: ${task.completed ? "Yes" : "No"}');
  print('---------------------------');
}