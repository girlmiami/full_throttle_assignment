import 'package:flutter/material.dart';
import 'package:full_throttle_assignment/main.dart';
import 'package:full_throttle_assignment/models/todo_item.dart';
import 'package:full_throttle_assignment/screens/add_new_item.dart';

class SingleItemWidget extends StatefulWidget {
  final TodoItem item;

  SingleItemWidget({this.item});

  @override
  _SingleItemWidgetState createState() => _SingleItemWidgetState();
}

class _SingleItemWidgetState extends State<SingleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RawMaterialButton(
        onPressed: () {},
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xff232333),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.item.title}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${widget.item.description}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Color(0xffF69193),
                  ),
                  onPressed: () => goToNewTaskScreen(widget.item, false),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Color(0xff18C5B7),
                  ),
                  onPressed: () => _delete(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  goToNewTaskScreen(TodoItem item, bool newTask) {
    return Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddNewItem(
              item: item,
              addNewTask: newTask,
            )));
  }

  _delete(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Are you sure ?"),
              actions: [
                FlatButton(
                  child: Text("NO"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text("YES"),
                  onPressed: () async {
                    await databaseRef.doc(widget.item.itemId).delete();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}
