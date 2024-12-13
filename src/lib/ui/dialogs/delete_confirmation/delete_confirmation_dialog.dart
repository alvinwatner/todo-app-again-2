import 'package:flutter/material.dart';
import 'package:todo_apps_v2/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const DeleteConfirmationDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              request.title ?? 'Delete Todo?',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              request.description ??
                  'Are you sure you want to delete this todo?',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: kcMediumGrey),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcErrorColor,
                  ),
                  onPressed: () => completer(DialogResponse(confirmed: true)),
                  child: const Text(
                    'Delete',
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
