import 'package:flutter/material.dart';
import 'package:full_throttle_assignment/main.dart';
import 'package:full_throttle_assignment/models/todo_item.dart';
import 'package:full_throttle_assignment/widgets/text_form_field.dart';

class AddNewItem extends StatefulWidget {
  final TodoItem item;
  final bool addNewTask;

  AddNewItem({
    this.item,
    this.addNewTask,
  });

  @override
  _AddNewItemState createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  int titleLengthRemaining = 150;
  int descriptionLengthRemaining = 1000;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _titleController.addListener(() {
      setState(() {
        titleLengthRemaining = 150 - _titleController.text.length;
      });
    });
    _descriptionController.addListener(() {
      setState(() {
        descriptionLengthRemaining = 1000 - _descriptionController.text.length;
      });
    });

    if (!widget.addNewTask) {
      _titleController.text = widget.item.title;
      _descriptionController.text = widget.item.description;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addNewTask ? "Add New Task" : "Edit Task"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("TITLE *",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                Container(
                  height: 100,
                  child: TextFormFieldEntry(
                    radius: 5,
                    textInputType: TextInputType.multiline,
                    hintText: "title...",
                    controller: _titleController,
                    maxLength: 150,
                    counterText: "$titleLengthRemaining / 150",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("DESCRIPTION *",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
                Container(
                  height: 100,
                  child: TextFormFieldEntry(
                    radius: 5,
                    controller: _descriptionController,
                    textInputType: TextInputType.multiline,
                    hintText: "description...",
                    maxLength: 1000,
                    counterText: "$descriptionLengthRemaining / 1000",
                  ),
                ),
                saveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  saveButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 50,
            child: RaisedButton(
              child: Text(
                "Save",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  widget.addNewTask
                      ? databaseRef.add({
                          "title": _titleController.text,
                          "description": _descriptionController.text,
                          "timeOfActivity": DateTime.now(),
                        })
                      : databaseRef.doc(widget.item.itemId).update({
                          "title": _titleController.text,
                          "description": _descriptionController.text,
                        });
                  Navigator.of(context).pop();
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Mandatory* fields cannot be empty !"),
                            actions: [
                              FlatButton(
                                child: Text("OK"),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ));
                }
              },
              color: Theme.of(context).accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
