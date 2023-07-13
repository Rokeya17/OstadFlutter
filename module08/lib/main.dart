import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(TaskManagementApp());
}

class TaskManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),
    );
  }
}

class Task {
  String title;
  String description;
  DateTime deadline;

  Task(this.title, this.description, this.deadline);
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tasks[index].title),
            subtitle: Text(_tasks[index].description),
            onTap: () => _showTaskDetails(_tasks[index]),
            onLongPress: () => _showDeleteBottomSheet(_tasks[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog() async {
    String title = '';
    String description = '';
    DateTime deadline;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onChanged: (value) {
                  description = value;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      deadline = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      setState(() {
                        _tasks.add(Task(title, description, deadline));
                      });

                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTaskDetails(Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Description: ${task.description}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Deadline: ${DateFormat('yyyy-MM-dd HH:mm').format(task.deadline)}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _deleteTask(task);
                  Navigator.pop(context);
                },
                child: Text('Delete Task'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteBottomSheet(Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete Task',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure you want to delete this task?',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _deleteTask(task);
                  Navigator.pop(context);
                },
                child: Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }
}
