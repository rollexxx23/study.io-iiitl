import 'package:flutter/cupertino.dart';

class ToDo {
  String taskText;
  String assignedBy;
  String date;
  String creditPoint;
  ToDo(
      {@required this.taskText,
      @required this.assignedBy,
      @required this.date,
      @required this.creditPoint});
}
