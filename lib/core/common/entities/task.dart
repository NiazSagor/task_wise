class Task {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final String hexColor;
  final DateTime dueAt;

  Task({
    required this.title,
    required this.id,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.hexColor,
    required this.dueAt,
  });
}
