import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'add_model.dart';
import 'add_task.dart';
import 'database_help.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  ConnectivityResult _connectivityStatus = ConnectivityResult.none;
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _checkConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityStatus = result;
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    setState(() {
      _connectivityStatus = result;
    });
  }

  Future<void> _refreshTasks() async {
    setState(() {});
  }

  Future<void> _deleteTask(int id) async {
    await DBHelper().deleteTask(id);
    _refreshTasks();
  }

  Future<void> _toggleCompletion(Task task) async {
    final updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      imagePath: task.imagePath,
      address: task.address,
      completed: !task.completed,
    );
    await DBHelper().updateTask(updatedTask);
    _refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          ' Add Task',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: _connectivityStatus == ConnectivityResult.wifi
                  ? const Icon(Icons.wifi, color: Colors.green)
                  : _connectivityStatus == ConnectivityResult.mobile
                      ? const Icon(
                          Icons.wifi,
                          color: Colors.green,
                          size: 30,
                        )
                      : const Icon(Icons.wifi_off_outlined, color: Colors.red),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<List<Task>>(
        future: DBHelper().getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final task = snapshot.data![index];
                return listItemView(task);
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()));
          if (result == true) {
            _refreshTasks();
          }
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget listItemView(Task task) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: task.imagePath != null
                ? Image.file(
                    File(task.imagePath!),
                    width: double.infinity,
                    // height: 50,
                    fit: BoxFit.cover,
                  )
                : Icon(Icons.image, size: 50),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      task.completed ? "Completed" : "Uncompleted",
                      style: TextStyle(
                          color:
                              task.completed ? Colors.green : Colors.redAccent),
                    ),
                    Checkbox(
                      value: task.completed,
                      onChanged: (bool? value) {
                        _toggleCompletion(task);
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTaskScreen(task: task),
                          ),
                        );
                        if (result == true) {
                          _refreshTasks();
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await _deleteTask(task.id!);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(task.description),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              task.address,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
