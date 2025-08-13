import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage extends StatefulWidget {
  const LocalStorage({super.key});

  @override
  State<LocalStorage> createState() => _LocalstorageState();
}

class _LocalstorageState extends State<LocalStorage> {
  bool? isAuthenticated;

  @override
  void initState() {
    _loadData();

    super.initState();
  }

  void _loadData() async {
    // Simulate a delay to mimic fetching data from local storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
    });
  }

  void _changeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAuthenticated = !isAuthenticated!;
    });
    prefs.setBool('isAuthenticated', isAuthenticated!);
  }

  void _removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isAuthenticated = null;
    });
    prefs.remove('isAuthenticated');
  }

  @override
  Widget build(BuildContext context) {
    if (isAuthenticated == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(!isAuthenticated! ? "not Authenticated" : "Authenticated"),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _changeStatus,
              child: Text("Change Status"),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _removeData,
              child: const Text("Remove Data"),
            ),
          ],
        ),
      ),
    );
  }
}
