import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:take_home/Screens/board_screen/components/board_templates.dart';
import 'package:take_home/Screens/board_screen/components/edit_task_dialoge.dart';
import 'package:take_home/utils/constants.dart';

import '../../utils/k_dialog.dart';

class KanbanBoard extends StatefulWidget {
  final title;
  const KanbanBoard({Key? key, this.title}) : super(key: key);

  @override
  State createState() => _KanbanBoardState();
}

class _KanbanBoardState extends State<KanbanBoard> {
  late List<InnerList> _lists;

  @override
  void initState() {
    super.initState();

    _lists =widget.title == 'Software Project'
            ? softwareProject
            : widget.title == 'Weekly Plan'
                ? weeklyPlan
                : widget.title == 'Quarterly Plan'?quarterlyPlan: [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xffF1F1F1),
        title: Text(widget.title, style: const TextStyle(
          // fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold
        ),),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'Montserrat'),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _lists.add(InnerList(name: 'New List', children: []));
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: InteractiveViewer(
        minScale: 0.002,
        maxScale: 5,
        scaleFactor: 100,
        child: DragAndDropLists(
          children: List.generate(_lists.length, (index) => _buildList(index)),
          onItemReorder: _onItemReorder,
          onListReorder: _onListReorder,
          axis: Axis.horizontal,
          listWidth: 280,
          listDraggingWidth: 150,
          listPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }

  _buildList(int outerIndex) {
    var innerList = _lists[outerIndex];
    return DragAndDropList(
      header: Row(
        children: [
          Expanded(
            child: Text(
              innerList.name,
              style: const TextStyle(
                color: Colors.black,
                  fontFamily: 'Montserrat',
                fontSize: 18
              ),
            ),
          ),
          Row(
            children: [
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  // popupmenu item 1
                  PopupMenuItem(
                    value: 1,
                    // row has two child icon and text.
                    child: Row(
                      children: const [
                        Icon(Icons.edit),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Edit")
                      ],
                    ),
                  ),
                  // popupmenu item 2
                  PopupMenuItem(
                    value: 2,
                    onTap: (){
                      setState(() {
                        _lists.removeAt(outerIndex);
                      });
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.delete),
                        SizedBox(
                          // sized box with width 10
                          width: 10,
                        ),
                        Text("Delete?")
                      ],
                    ),
                  ),
                ],
                icon: const Icon(Icons.more_horiz),
                offset: const Offset(0, 50),
                color: Colors.white,
                elevation: 2,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      innerList.children.add({'title': 'New Task', 'description': 'New Task Description'});
                    });
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.grey[600],
                  )),
            ],
          )
        ],
      ),

      children: List.generate(innerList.children.length,
          (index) => _buildItem(innerList.children[index], outerIndex)),
    );
  }

  _buildItem(item, outerIndex) {
    return DragAndDropItem(
      child: InkWell(
        onTap: () {
          _showCreateDialog(context, item, outerIndex);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            color: item.containsKey('color')? item['color']: Colors.white,

            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['title'], style: const TextStyle(
                    fontFamily: 'Montserrat', fontSize: 16
                  ),),
                  Text(item['description'], style: const TextStyle(
                      fontFamily: 'Montserrat', fontSize: 12,
                    color: Colors.black54
                  ),),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

  Future<void> _showCreateDialog(BuildContext context, var item, var outerIndex) {
    return showDialog<void>(
      context: context,
      builder: (context) => KDialog(
        color: Colors.white,
        title: const Text('Editing Task'),
        content: SizedBox(
          width: 400.0,
          height: 400.0,
          child: EditTaskDialog(
            item: item,
            onSelected: (value) {

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
          TextButton(
            child: const Text('SAVE', style: TextStyle(
                color: Colors.black87
            ),),
            onPressed: () {
              Navigator.pop(context);
              _lists[outerIndex].children.where((element) => false);
            },
          ),
        ],
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }
}

class InnerList {
  final String name;
  List<Map> children;
  InnerList({required this.name, required this.children});
}
