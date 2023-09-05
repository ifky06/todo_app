import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem(
      {Key? key,
      required this.todo,
      required this.onToDoChanged,
      required this.onDeleteItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: ListTile(
        // tileColor: Colors.black,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(20),
        //   side: BorderSide(color: tdBlue, width: 2),
        // ),
        leading: Icon(
            todo.isDone! ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue),
        title: Text(
          todo.todoText!,
          style: TextStyle(
              color: tdBlack,
              decoration: todo.isDone! ? TextDecoration.lineThrough : null),
        ),
        trailing: Container(
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            icon: Icon(
              Icons.delete,
              color: tdRed,
            ),
          ),
        ),
        onTap: () {
          onToDoChanged(todo);
        },
      ),
    );
  }
}
