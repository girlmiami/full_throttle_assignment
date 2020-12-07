import 'package:flutter/material.dart';
import 'package:full_throttle_assignment/screens/add_new_item.dart';

class FloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNewItem(
            addNewTask: true,
          ))),
      child: Container(
        height: 50,
        width: 200,
        child: Center(
          child: Text(
            "Add New Task",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    );
  }
}
