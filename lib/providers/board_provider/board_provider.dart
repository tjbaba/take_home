import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Screens/board_screen/components/board_templates.dart';
import '../../Screens/board_screen/model/InnerList.dart';

class BoardProvider extends ChangeNotifier {
  List<InnerList> lists = [];
  List<String> header = ['Name', 'description', 'createdAt', 'data'];
  String? name = '', description = '';


  void checkValues(Name, Description) {
    name = Name;
    description = Description;
    notifyListeners();
  }

  void assignTemplate(String title) {
    name = title;
    lists = title == 'Software Project'
        ? Templates.softwareProject
        : title == 'Weekly Plan'
            ? Templates.weeklyPlan
            : title == 'Quarterly Plan'
                ? Templates.quarterlyPlan
                : Templates.emptyProject;
  }

  void deleteTask(int outerIndex, int innerIndex){
    lists[outerIndex].children.removeAt(innerIndex);
    notifyListeners();
  }

  onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem = lists[oldListIndex].children.removeAt(oldItemIndex);
    lists[newListIndex].children.insert(newItemIndex, movedItem);
    notifyListeners();
  }

  onListReorder(int oldListIndex, int newListIndex) {
    var movedList = lists.removeAt(oldListIndex);
    lists.insert(newListIndex, movedList);
    notifyListeners();
  }
}

final boardProvider = ChangeNotifierProvider((ref) => BoardProvider());
