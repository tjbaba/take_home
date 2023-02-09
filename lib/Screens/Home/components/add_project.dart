import 'package:flutter/material.dart';
import 'package:take_home/Screens/board_screen/board_screen.dart';

import 'board_creation_list.dart';
import '../../../utils/k_dialog.dart';

class BuildAddProject extends StatefulWidget {
  const BuildAddProject({Key? key}) : super(key: key);

  @override
  State<BuildAddProject> createState() => _BuildAddProjectState();
}

class _BuildAddProjectState extends State<BuildAddProject> {

  Future<void> _showCreateDialog(BuildContext context, Color dialogColor) {
    return showDialog<void>(
      context: context,
      builder: (context) => KDialog(
        color: dialogColor,
        title: const Text('Create New Board'),
        content: SizedBox(
          width: 400.0,
          height: 400.0,
          child: BoardCreationList(
            onSelected: (value) {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => KanbanBoard(title: value,description: '',)));
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text('CANCEL', style: TextStyle(
                color: Colors.black87
            ),),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        _showCreateDialog(context, Colors.white);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => const KanbanBoard()));
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(10),
          height: 100,
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9FB),
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Center(
            child: Icon(Icons.add),
          )
      ),
    );
  }
}
