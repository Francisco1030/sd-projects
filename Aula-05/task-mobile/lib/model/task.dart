import 'dart:convert';

class Task {
  String id;
  String description;
  bool completed;

  Task({this.id, this.description, this.completed});

  factory Task.fromJson(Map<String, dynamic> map) {
    return Task(id: map["_id"], description: map["description"], completed: map["completed"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "description": description, "completed": completed};
  }

  @override
  String toString() {
    return 'Task{id: $id, description: $description, completed: $completed}';
  }

  static List<Task> taskFromJson(String jsonData) {
    final data = json.decode(jsonData);
    return List<Task>.from(data.map((item) => Task.fromJson(item)));
  }

  static String taskToJson(Task data) {
    final jsonData = data.toJson();
    return json.encode(jsonData);
  }

}
