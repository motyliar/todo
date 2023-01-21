import 'package:flutter/material.dart';
import 'package:todoruska/bloc/bloc_export.dart';
import 'package:todoruska/screens/my_drawer.dart';
import 'package:todoruska/bloc/widgets/task_list.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});
  static const id = 'recycle_bin';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Recycle Bin'),
            actions: [
              PopupMenuButton(
                itemBuilder: (contex) => [
                  PopupMenuItem(
                    // ignore: sort_child_properties_last
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(
                        Icons.delete_forever,
                      ),
                      label: const Text('Delete All'),
                    ),
                    onTap: (() =>
                        context.read<TasksBloc>().add(DeleteAllTasks())),
                  ),
                ],
              )
            ],
          ),
          drawer: MyDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    'Tasks: ${state.removedTasks.length}',
                  ),
                ),
              ),
              TaskList(taskList: state.removedTasks),
            ],
          ),
        );
      },
    );
  }
}
