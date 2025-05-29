import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitCompletionScreen extends StatefulWidget {
  final Map task;

  SubmitCompletionScreen({required this.task});

  @override
  _SubmitCompletionScreenState createState() => _SubmitCompletionScreenState();
}

class _SubmitCompletionScreenState extends State<SubmitCompletionScreen> {
  final TextEditingController submissionController = TextEditingController();
  bool isSubmitting = false;

  Future<void> submitWork() async {
    if (submissionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter your work completion description"),
        ),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? workerString = prefs.getString('worker');
    if (workerString == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("User not logged in")));
      setState(() {
        isSubmitting = false;
      });
      return;
    }

    var worker = json.decode(workerString);
    var workerId = worker['id'];

    var response = await http.post(
      Uri.parse('http://10.0.2.2/wtms/submit_work.php'),
      body: {
        'worker_id': workerId.toString(),
        'work_id': widget.task['id'].toString(),
        'submission_text': submissionController.text,
      },
    );

    var data = json.decode(response.body);
    setState(() {
      isSubmitting = false;
    });

    if (data['status'] == 'success') {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Work submitted successfully!")));
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? "Submission failed")),
      );
    }
  }

  Widget _buildTextField() {
    return TextField(
      controller: submissionController,
      maxLines: 5,
      decoration: InputDecoration(
        labelText: "What did you complete?",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Submit Completion"),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Task",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[700],
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    widget.task['title'],
                    style: TextStyle(fontSize: 16, color: Colors.teal[900]),
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: isSubmitting ? null : submitWork,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        isSubmitting
                            ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                            : Text("Submit", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
