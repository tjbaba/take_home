import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Screens/board_screen/components/board_templates.dart';
import '../../Screens/board_screen/model/InnerList.dart';

class BoardProvider extends ChangeNotifier {
  List<InnerList> lists = [];

  void assignTemplate(String title) {
    lists.clear();
    lists = title == 'Software Project'
        ? softwareProject
        : title == 'Weekly Plan'
            ? weeklyPlan
            : title == 'Quarterly Plan'
                ? quarterlyPlan
                : [];
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
