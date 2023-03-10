import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Screens/board_screen/model/InnerList.dart';
import '../../board_provider/board_provider.dart';

class Backend extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void deleteProject(id){
    firestore.collection('Users').doc(auth.currentUser!.uid).collection('Projects').doc(id).delete();
  }

  void uploadData(List<InnerList> data, title, description) {
    Map<String, dynamic> toJson() {
      return {
        'name': title,
        'description': description,
        'createdAt': DateTime.now(),
        'data': data.map((e) => e.toJson()).toList()
      };
    }

    firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Projects')
        .add(toJson());
  }

  void updateData(List<InnerList> data, title, id) {
    Map<String, dynamic> toJson() {
      return {
        'name': title,
        'createdAt': DateTime.now(),
        'data': data.map((e) => e.toJson()).toList()
      };
    }

    firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Projects')
        .doc(id)
        .set(toJson(), SetOptions(merge: true));
  }

  void getData(WidgetRef provider, String id) {
    provider.read(boardProvider).lists.clear();
    var ref = firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Projects')
        .doc(id);
    ref.get().then((value) {
      provider.watch(boardProvider).name = value.get('name');
      provider.watch(boardProvider).description = value.get('description');
      value.get('data').forEach((e) {
        provider.watch(boardProvider).lists.add(InnerList.fromJson(e));
      });
    }).then((value) {
      provider.read(boardProvider).notifyListeners();
    });
  }
}

final backend = ChangeNotifierProvider((ref) => Backend());
