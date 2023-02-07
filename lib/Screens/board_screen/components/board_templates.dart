import 'package:take_home/Screens/board_screen/board_screen.dart';

var softwareProject = [
  InnerList(name: 'To Do', children: [{'title':'Sample Task', 'description': 'Sample Task Description'}]),
  InnerList(name: 'In Progress', children: []),
  InnerList(name: 'Done', children: [])
];

var weeklyPlan = [
  InnerList(name: 'Monday', children: [{'title':'Sample Task', 'description': 'Sample Task Description'}]),
  InnerList(name: 'Tuesday', children: []),
  InnerList(name: 'Wednesday', children: []),
  InnerList(name: 'Thursday', children: []),
  InnerList(name: 'Friday', children: []),
  InnerList(name: 'Saturday', children: []),
  InnerList(name: 'Sunday', children: []),
];

var quarterlyPlan = [
  InnerList(name: 'Q1', children: [{'title':'Sample Task', 'description': 'Sample Task Description'}]),
  InnerList(name: 'Q2', children: []),
  InnerList(name: 'Q3', children: []),
  InnerList(name: 'Q4', children: []),
];
