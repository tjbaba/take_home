import '../model/InnerList.dart';
import '../model/task.dart';

mixin Templates{
  static final emptyProject = [
    InnerList(name: 'Sample', children: [])
  ];

 static final softwareProject =  [
    InnerList(name: 'To Do', children: [
      Task(title: 'Sample Task', description: 'Sample Task Description')
    ]),
    InnerList(name: 'In Progress', children: []),
    InnerList(name: 'Done', children: [])
  ];

  static final weeklyPlan = [
    InnerList(name: 'Monday', children:[
      Task(title: 'Sample Task', description: 'Sample Task Description')
    ]),
    InnerList(name: 'Tuesday', children: []),
    InnerList(name: 'Wednesday', children: []),
    InnerList(name: 'Thursday', children: []),
    InnerList(name: 'Friday', children: []),
    InnerList(name: 'Saturday', children: []),
    InnerList(name: 'Sunday', children: []),
  ];

  static final quarterlyPlan = [
    InnerList(name: 'Q1', children: [
      Task(title: 'Sample Task', description: 'Sample Task Description')
    ]),
    InnerList(name: 'Q2', children: []),
    InnerList(name: 'Q3', children: []),
    InnerList(name: 'Q4', children: []),
  ];

}