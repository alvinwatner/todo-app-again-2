import 'package:flutter/material.dart';
import 'package:todo_apps_v2/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

class AddTodoSheet extends StatefulWidget {
  final Function(SheetResponse)? completer;
  final SheetRequest request;

  const AddTodoSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.request.title ?? 'Add New Todo',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => widget.completer?.call(
                    SheetResponse(confirmed: false),
                  ),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimaryColor,
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      widget.completer?.call(
                        SheetResponse(
                          confirmed: true,
                          data: {
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                          },
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Add Todo',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
