class Account {
  String name;
  DateTime? builderFreeAt;
  List<Task> tasks;

  Account({required this.name, this.builderFreeAt, required this.tasks});

  Map<String, dynamic> toJson() => {
    'name': name,
    'builderFreeAt': builderFreeAt?.toIso8601String(),
    'tasks': tasks.map((t) => t.toJson()).toList(),
  };

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    name: json['name'],
    builderFreeAt: json['builderFreeAt'] != null ? DateTime.parse(json['builderFreeAt']) : null,
    tasks: (json['tasks'] as List).map((e) => Task.fromJson(e)).toList(),
  );
}

class Task {
  String title;
  bool done;

  Task({required this.title, this.done = false});

  Map<String, dynamic> toJson() => {
    'title': title,
    'done': done,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json['title'],
    done: json['done'],
  );
}
