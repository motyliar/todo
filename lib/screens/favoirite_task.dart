import 'package:flutter/material.dart';
import 'package:todoruska/bloc/bloc_export.dart';
import 'package:todoruska/models/task.dart';
import 'package:todoruska/screens/my_drawer.dart';
import '../bloc/widgets/task_list.dart';
import 'add_task_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  static const id = 'favorite_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.favoriteTasks;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  'Tasks: ${state.favoriteTasks.length}',
                ),
              ),
            ),
            TaskList(taskList: taskList)
          ],
        );
      },
    );
  }
}
