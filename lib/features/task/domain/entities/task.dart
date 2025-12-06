class Task {
  final String id;
  final String title;
  final String description;
  final String status;
  final String createdAt;

  Task({
    required this.title,
    required this.id,
    required this.description,
    required this.status,
    required this.createdAt,
  });
}
