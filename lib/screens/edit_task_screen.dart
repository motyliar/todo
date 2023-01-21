import 'package:flutter/material.dart';
import 'package:todoruska/bloc/bloc_export.dart';
import 'package:todoruska/models/task.dart';
import 'package:todoruska/services/guid_gen.dart';

class EditTaskScreen extends StatelessWidget {
  final Task oldTask;
  const EditTaskScreen({
    Key? key,
    required this.oldTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController =
        TextEditingController(text: oldTask.title);
    TextEditingController addDescriptionController =
        TextEditingController(text: oldTask.description);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        const Text(
          'Edit Task',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
          ),
          child: TextField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                label: Text('title'), border: OutlineInputBorder()),
          ),
        ),
        TextField(
          autofocus: true,
          minLines: 2,
          maxLines: 4,
          controller: addDescriptionController,
          decoration: const InputDecoration(
              label: Text('description'), border: OutlineInputBorder()),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('cancel'),
            ),
            ElevatedButton(
                onPressed: () {
                  var editedTask = Task(
                      title: titleController.text,
                      description: addDescriptionController.text,
                      id: oldTask.id,
                      isDone: false,
                      isFavorite: oldTask.isFavorite,
                      date: DateTime.now().toString());
                  context.read<TasksBloc>().add(
                        EditTask(oldTask: oldTask, newTask: editedTask),
                      );
                  titleController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Save')),
          ],
        ),
      ]),
    );
  }
}
