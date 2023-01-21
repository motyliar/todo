import 'package:flutter/material.dart';
import 'package:todoruska/bloc/bloc_export.dart';
import 'package:todoruska/models/task.dart';
import 'package:todoruska/services/guid_gen.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController addDescriptionController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(children: [
        const Text(
          'Add Task',
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
                  var task = Task(
                      title: titleController.text,
                      description: addDescriptionController.text,
                      id: GUIDGen.generate(),
                      date: DateTime.now().toString());
                  context.read<TasksBloc>().add(
                        AddTask(task: task),
                      );
                  titleController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add')),
          ],
        ),
      ]),
    );
  }
}
