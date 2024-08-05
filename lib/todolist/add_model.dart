class Task {
  int? id;
  String title;
  String description;
  String? imagePath;
  String address;
  bool completed; // New field

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.address,
    this.completed = false, // Default value
  });

  // Convert a Task into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'address': address,
      'completed': completed ? 1 : 0, // Store as 1 for true, 0 for false
    };
  }

  // Convert a Map into a Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imagePath: map['imagePath'],
      address: map['address'],
      completed: map['completed'] == 1, // Convert back to boolean
    );
  }
}