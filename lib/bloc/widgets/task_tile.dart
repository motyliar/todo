import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoruska/bloc/bloc_export.dart';
import 'package:todoruska/models/task.dart';
import 'package:todoruska/bloc/widgets/pop_up_menu.dart';
import 'package:todoruska/screens/edit_task_screen.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  void _editTask(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: EditTaskScreen(
                  oldTask: task,
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null,
                            fontSize: 18),
                      ),
                      Text(
                        DateFormat()
                            .add_yMMMd()
                            .add_Hms()
                            .format(DateTime.now()),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Checkbox(
                  value: task.isDone,
                  onChanged: task.isDeleted == false
                      ? (value) {
                          context.read<TasksBloc>().add(UpdateTask(task: task));
                        }
                      : null),
              PopUpMenu(
                task: task,
                cancel: () => _removeOrDeleteTask(context, task),
                likeOrDislike: () =>
                    context.read<TasksBloc>().add(FavoriteTask(task: task)),
                editCallBack: (() => _editTask(context)),
                restoredCallBack: (() =>
                    context.read<TasksBloc>().add(RestoreTask(task: task))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// ListTile(
//       title:
//       trailing: 
//     // )