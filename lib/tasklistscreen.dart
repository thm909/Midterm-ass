import 'package:flutter/material.dart';
import 'submitcompletionscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'loginscreen.dart';

class tasklistscreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<tasklistscreen> {
  List tasks = [];
  bool loading = true;

  Future<void> fetchTasks() async {
    setState(() {
      loading = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? workerString = prefs.getString('worker');
    if (workerString == null) {
      _logoutAndRedirect();
      return;
    }
    var worker = json.decode(workerString);

    final response = await http.post(
      Uri.parse('http://10.0.2.2/wtms/get_work.php'),
      body: {'worker_id': worker['id'].toString()},
    );

    var data = json.decode(response.body);
    if (data['status'] == 'success') {
      setState(() {
        tasks = data['tasks'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? "Failed to load tasks")),
      );
    }

    setState(() {
      loading = false;
    });
  }

  void _logoutAndRedirect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => loginscreen()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Text(
          "My Tasks",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        elevation: 4,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () {}),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              _logoutAndRedirect();
            },
          ),
        ],
      ),
      body:
          loading
              ? Center(child: CircularProgressIndicator(color: Colors.teal))
              : tasks.isEmpty
              ? Center(
                child: Text(
                  "No tasks assigned yet.",
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              )
              : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    var task = tasks[index];
                    return Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () async {
                          bool? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => SubmitCompletionScreen(task: task),
                            ),
                          );
                          if (result == true) {
                            fetchTasks();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task['title'],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal[800],
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                task['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[800],
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Due: ${task['due_date']}",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          task['status'] == 'pending'
                                              ? Colors.orangeAccent
                                              : Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      task['status'].toString().toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
