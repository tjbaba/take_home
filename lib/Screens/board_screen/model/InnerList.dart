import 'package:take_home/Screens/board_screen/model/task.dart';

class InnerList {
  final String name;
  List<Task> children;
  InnerList({required this.name, required this.children});
}

