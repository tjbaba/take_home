import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_home/Screens/board_screen/components/board_templates.dart';
import 'package:take_home/Screens/board_screen/components/edit_task_dialoge.dart';
import 'package:take_home/providers/Firebase/Backend/backend.dart';
import 'package:take_home/providers/board_provider/board_provider.dart';
import 'package:take_home/providers/edit_task/edit_task_provider.dart';
import 'package:take_home/utils/constants.dart';

import '../../utils/k_dialog.dart';
import 'model/InnerList.dart';
import 'model/task.dart';

class KanbanBoard extends ConsumerStatefulWidget {
  final title;
  const KanbanBoard({Key? key, this.title}) : super(key: key);

  @override
  ConsumerState createState() => _KanbanBoardState();
}

class _KanbanBoardState extends ConsumerState<KanbanBoard> {
  @override
  void initState() {
    super.initState();
    ref.read(boardProvider).assignTemplate(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    final board = ref.watch(boardProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: const Color(0xffF1F1F1),
        title: Text(
          widget.title,
          style: const TextStyle(
              // fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold),
        ),
        actions: [
          InkWell(
            onTap: (){
              Backend().uploadData(board.lists);
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Center(
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Montserrat'),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            board.lists.add(InnerList(name: 'New List', children: []));
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
          children:
              List.generate(board.lists.length, (index) => _buildList(index)),
          onItemReorder: board.onItemReorder,
          onListReorder: board.onListReorder,
          axis: Axis.horizontal,
          listWidth: 280,
          listDraggingWidth: 150,
          listPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }

  _buildList(int outerIndex) {
    var innerList = ref.watch(boardProvider).lists[outerIndex];
    return DragAndDropList(
      header: Row(
        children: [
          Expanded(
            child: Text(
              innerList.name,
              style: const TextStyle(
                  color: Colors.black, fontFamily: 'Montserrat', fontSize: 18),
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
                    onTap: () {
                      setState(() {
                        ref.watch(boardProvider).lists.removeAt(outerIndex);
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
                      innerList.children.add(
                        Task(
                          title: 'New Task',
                          description: 'New Task Description'
                        )
                      );
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
          (index) => _buildItem(innerList.children[index], outerIndex, index)),
    );
  }

  _buildItem(Task item, outerIndex, innerIndex) {
    return DragAndDropItem(
      child: InkWell(
          onTap: () {
            _showCreateDialog(context, item, outerIndex, innerIndex);
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: item.color?? Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title!,
                      style: const TextStyle(
                          fontFamily: 'Montserrat', fontSize: 16),
                    ),
                    Text(
                      item.description!,
                      style: const TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: Colors.black54),
                    ),
                   item.label != null? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Chip(
                          backgroundColor: kBackgroundColor,
                          label: Text(
                            "${item.label}",
                            style: const TextStyle(
                                fontFamily: 'Montserrat', fontSize: 12),
                          ),
                          padding: const EdgeInsets.all(2),
                        )
                      ],
                    ) : const SizedBox()
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Future<void> _showCreateDialog(
      BuildContext context, var item, var outerIndex, var innerIndex) {
    return showDialog<void>(
      context: context,
      builder: (context) => KDialog(
        color: Colors.white,
        title: Row(
          children: [
            const Expanded(child: Text('Editing Task')),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                  ref.watch(boardProvider).deleteTask(outerIndex, innerIndex);
                },
                child: const Icon(
                  Icons.delete,
                  color: kPrimaryColor,
                ))
          ],
        ),
        content: SizedBox(
          width: 400.0,
          height: 400.0,
          child: EditTaskDialog(
            item: item,
            innerIndex: innerIndex,
            outerIndex: outerIndex,
            onSelected: (value) {},
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Colors.black87),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text(
              'SAVE',
              style: TextStyle(color: Colors.black87),
            ),
            onPressed: () {
              ref.watch(editTaskProvider).saveDate(innerIndex, outerIndex, ref);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}



