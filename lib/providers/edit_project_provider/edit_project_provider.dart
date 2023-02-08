
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EditProjectProvider extends ChangeNotifier{

  String? title, description;

  void checkValues(name, Description) {
    title = name;
    description = Description;
    notifyListeners();
  }

}

final editProjectProvider = ChangeNotifierProvider((ref) => EditProjectProvider());
