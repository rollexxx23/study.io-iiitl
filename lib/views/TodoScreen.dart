import 'package:flutter/material.dart';
import '../models/todoListModel.dart';
import '../widget/todoList.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<ToDo> todoList = [
    ToDo(
        taskText: "Complete exercise 2.4",
        assignedBy: "Physics",
        date: "13 April",
        creditPoint: "5"),
    ToDo(
        taskText: "Practice linear algebra",
        assignedBy: "Mathematics",
        date: "14 April",
        creditPoint: "10"),
    ToDo(
        taskText: "Do Yoga",
        assignedBy: "Physical Education",
        date: "15 April",
        creditPoint: "2"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(25, 23, 32, 1),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Homework",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 2, bottom: 2),
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.pink[50],
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.pink,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Add custom Homework",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: todoList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ToDoList(
                        taskText: todoList[index].taskText,
                        assignedBy: todoList[index].assignedBy,
                        date: todoList[index].date,
                        creditPoint: todoList[index].creditPoint,
                      );
                    },
                  ),
                ])));
  }
}
