import '../widget/todoList.dart';

import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  @override
  String taskText;
  String assignedBy;
  String date;
  String creditPoint;

  ToDoList({
    @required this.taskText,
    @required this.assignedBy,
    @required this.date,
    @required this.creditPoint,
  });
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      height: 200,
      width: double.maxFinite,
      child: Card(
          color: Color.fromRGBO(84, 104, 255, 1),
          elevation: 5,
          child: new InkWell(
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  title: new Text(widget.assignedBy,
                      style: new TextStyle(
                          color: new Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto')),
                  subtitle: new Text(
                    widget.taskText,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                new Container(
                  padding: const EdgeInsets.only(left: 250.0, bottom: 20.0),
                  child: new Column(
                    children: <Widget>[
                      new Row(children: <Widget>[
                        new Text(
                          'Credit:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        new Text(
                          widget.creditPoint,
                          style: TextStyle(fontSize: 15),
                        ),
                      ]),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_view_day,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            widget.date,
                            style: TextStyle(color: Colors.red, fontSize: 20),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
