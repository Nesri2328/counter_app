import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

//---------- Data Model and State Management (Keep these) ----------

class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  Priority priority;
  bool isCompleted;
  String category;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    this.category = '',
  });
}

enum Priority { low, medium, high }

class TaskProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }
}

//---------- Main App and Routing (Modified) ----------

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/', // Start with onboarding
      routes: {
        '/': (context) => const OnboardingScreen(), // Onboarding
        '/taskList': (context) => const TaskListScreen(), // Task list
        '/addTask': (context) => const AddTaskScreen(), // Add task
        '/settings': (context) => const SettingsScreen(), // Settings
        '/counter': (context) =>
            const MyHomePage(title: 'Flutter Demo Home Page'),
        //Counter Page
      },
    );
  }
}

//---------- Counter App Home Page (MyHomePage) - Kept Intact ----------

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      drawer: Drawer(
        // Add a Drawer to access other pages
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'TaskFlow Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Task List'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/taskList');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Counter'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/counter');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//---------- Onboarding Screen (Unchanged) ----------

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF28B82), // Coral background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to TaskFlow!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/taskList');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//---------- Task List Screen (Modified to include a Drawer) ----------

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Task List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        // Add a Drawer to access other pages
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'TaskFlow Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Task List'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/taskList');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/settings');
              },
              /*Add on home*/
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Counter'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/counter');
              },
            ),
          ],
        ),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No tasks yet. Add some!'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskItem(task: task);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

//---------- Task Item Widget (Unchanged) ----------

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Due: ${DateFormat('yyyy-MM-dd – kk:mm').format(task.dueDate)}', // Format date using intl
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

//---------- Add/Edit Task Screen (Modified) ----------

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();
  Priority _priority = Priority.medium;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Task',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  _description = value!;
                },
              ),
              Row(
                children: <Widget>[
                  Text(DateFormat('yyyy-MM-dd – kk:mm').format(_dueDate)),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context);
                    },
                  ),
                ],
              ),
              DropdownButtonFormField<Priority>(
                decoration: const InputDecoration(labelText: 'Priority'),
                value: _priority,
                items: Priority.values.map((Priority priority) {
                  return DropdownMenuItem<Priority>(
                    value: priority,
                    child: Text(priority.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (Priority? newValue) {
                  setState(() {
                    _priority = newValue!;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newTask = Task(
                      id: DateTime.now().toString(),
                      title: _title,
                      description: _description,
                      dueDate: _dueDate,
                      priority: _priority,
                    );
                    taskProvider.addTask(newTask);
                    Navigator.pop(context); // Navigate back to the task list
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//---------- Settings Screen (Modified to include a Drawer) ----------

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        // Add a Drawer to access other pages
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'TaskFlow Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('Task List'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/taskList');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/settings');
              },
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Counter'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/counter');
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Theme'),
            subtitle: const Text('Light / Dark'),
            onTap: () {
              // Implement theme selection logic
              print('Theme settings tapped');
            },
          ),
          ListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Enable / Disable Reminders'),
            onTap: () {
              // Implement notification settings logic
              print('Notification settings tapped');
            },
          ),
          ListTile(
            title: const Text('Data'),
            subtitle: const Text('Backup / Restore'),
            onTap: () {
              // Implement data backup/restore logic
              print('Data settings tapped');
            },
          ),
          // Add more settings options as needed
        ],
      ),
    );
  }
}
