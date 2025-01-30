import 'package:flutter/material.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function(String) onToggle;
  final Function(String) onDelete;

  const ToDoItem({
    super.key, 
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: () => onToggle(todo.id!),
        contentPadding: const EdgeInsets.fromLTRB(5, 10, 15, 10),
        title: Text(todo.title ?? ""),
        leading: IconButton(
            onPressed: () => onToggle(todo.id!), icon: todo.isDone? Icon(Icons.check_box, color: Color(0xFF6054ee),):Icon(Icons.check_box_outline_blank, color: Color(0xFF6054ee))),
        trailing: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
            child: IconButton(
                onPressed: () => onDelete(todo.id!),
                icon: const Icon(Icons.delete, color: Colors.white))),
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
