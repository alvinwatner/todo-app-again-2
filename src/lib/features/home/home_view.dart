import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_apps_v2/features/home/home_viewmodel.dart';
import 'package:todo_apps_v2/features/home/widgets/todo_item.dart';
import 'package:todo_apps_v2/ui/common/app_colors.dart';
import 'package:todo_apps_v2/ui/common/ui_helpers.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kcPrimaryColor,
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: viewModel.todos.isEmpty
                      ? const Center(
                          child: Text(
                            'No todos yet.\nAdd your first todo!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: kcMediumGrey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: viewModel.todos.length,
                          itemBuilder: (context, index) {
                            final todo = viewModel.todos[index];
                            return TodoItem(
                              todo: todo,
                              onDelete: () => viewModel.deleteTodo(todo.id),
                              onToggle: () =>
                                  viewModel.toggleTodoCompletion(todo.id),
                            );
                          },
                        ),
                ),
                verticalSpaceMedium,
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.showAddTodoSheet,
        backgroundColor: kcPrimaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
