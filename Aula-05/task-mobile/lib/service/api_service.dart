import '../model/task.dart';
import 'package:http/http.dart' show Client;

class ApiService {
  //final String baseUrl = "http://localhost:3000";
  final String baseUrl = "http://10.0.2.2:3000";  
  Client client = Client();

  Future<List<Task>> getTasks() async {
    final response = await client.get("$baseUrl/tasks");
    if (response.statusCode == 200) {
      return Task.taskFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createTask(Task data) async {
    final response = await client.post(
      "$baseUrl/tasks",
      headers: {"content-type": "application/json"},
      body: Task.taskToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateTask(Task data) async {
    final response = await client.put(
      "$baseUrl/tasks/${data.id}",
      headers: {"content-type": "application/json"},
      body: Task.taskToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteTask(String id) async {
    final response = await client.delete(
      "$baseUrl/tasks/$id",
      headers: {"content-type": "application/json"},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
