import 'package:take_home/Screens/board_screen/model/task.dart';

class InnerList {
  final String name;
  List<Task> children;
  InnerList({required this.name, required this.children});

  factory InnerList.fromJson(Map<String, dynamic> data) {
    List<dynamic> list = data['tasksList'] ?? [];

    final tasksList = list.map((e) => Task.fromJson(e)).toList();

    return InnerList(
      name: data['name'],
      children: tasksList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'tasksList': children.map((e) => e.toJson()).toList(),
    };
  }
}

