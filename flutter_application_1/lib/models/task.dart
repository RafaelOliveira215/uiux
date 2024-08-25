class Task {
  String description;
  String date;
  bool isCompleted;

  Task({
    required this.description,
    required this.date,
    this.isCompleted = false,
  });
}
