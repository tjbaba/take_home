import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_home/providers/board_provider/board_provider.dart';
import 'package:take_home/utils/constants.dart';

import '../../Screens/board_screen/model/task.dart';

class EditTaskProvider extends ChangeNotifier {
  String? title, description, label, note;
  Color? color;
  DateTime? dueDate, startDate;
  var timePassed;

  List<String> options = [
    'Important',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  void updateLabel(value) {
    label = value;
    notifyListeners();
  }

  void checkValues(Task item) {
    color = item.color??  Colors.white;
    title = item.title;
    description = item.description;
    dueDate = item.dueDate;
    label = item.label;
    note = item.note;
    notifyListeners();
  }

  Future<void> datePicker(context) async {
    dueDate = await showRoundedDatePicker(
      height: MediaQuery.of(context).size.height * 0.38,
      theme: ThemeData(colorSchemeSeed: kPrimaryColor),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
    );
    notifyListeners();
  }

  void saveDate(var innerIndex, var outerIndex, WidgetRef ref) {
    ref.watch(boardProvider).lists[outerIndex].children[innerIndex] = Task(
        title: title,
        description: description,
        color: color,
        dueDate: dueDate,
        startDate: startDate,
        label: label, note: note);
    notifyListeners();
  }

  void startTimer(){
    startDate = DateTime.now();
    checkTime();
    notifyListeners();
  }

  void checkTime(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
      timePassed = startDate!.difference(DateTime.now());
    });
    notifyListeners();
  }
}

final editTaskProvider = ChangeNotifierProvider((ref) => EditTaskProvider());
