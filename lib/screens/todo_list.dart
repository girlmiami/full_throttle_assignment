import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_throttle_assignment/main.dart';
import 'package:full_throttle_assignment/models/todo_item.dart';
import 'package:full_throttle_assignment/widgets/single_item_widget.dart';

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: StreamBuilder(
          stream: databaseRef
              .orderBy("timeOfActivity", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<TodoItem> allItems = getAllItems(snapshot.data);
              return todoList(allItems);
            }
          },
        ),
      ),
    );
  }

  todoList(List<TodoItem> allItems) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: allItems.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleItemWidget(
                  item: allItems[index],
                ),

              ],
            );
          }),
    );
  }

  getAllItems(QuerySnapshot snap) {
    List<TodoItem> allItems = [];

    snap.docs.forEach((element) {
      if (element.id == "noOfDocuments") {
        return;
      }
      var data = element.data();
      allItems.add(TodoItem(
        title: data["title"],
        description: data["description"],
        timeOfActivity: data["timeOfActivity"].toDate(),
        itemId: element.id,
      ));
    });

    return allItems;
  }
}
