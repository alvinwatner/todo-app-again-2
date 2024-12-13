import 'package:flutter/material.dart';
import 'package:todo_apps_v2/models/todo_model.dart';
import 'package:todo_apps_v2/ui/common/app_colors.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onDelete,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(),
          activeColor: kcPrimaryColor,
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? kcMediumGrey : Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.description,
              style: TextStyle(
                decoration:
                    todo.isCompleted ? TextDecoration.lineThrough : null,
                color: todo.isCompleted ? kcMediumGrey : kcDarkGreyColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Created: ${DateFormat('MMM dd, yyyy').format(todo.createdAt)}',
              style: const TextStyle(
                fontSize: 12,
                color: kcMediumGrey,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: kcErrorColor),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
