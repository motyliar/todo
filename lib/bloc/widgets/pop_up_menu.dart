import 'package:flutter/material.dart';
import 'package:todoruska/models/task.dart';
import 'package:todoruska/bloc/bloc_export.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    required this.task,
    required this.cancel,
    required this.likeOrDislike,
    required this.editCallBack,
    required this.restoredCallBack,
    Key? key,
  }) : super(key: key);
  final Task task;
  final VoidCallback cancel;
  final VoidCallback likeOrDislike;
  final VoidCallback editCallBack;
  final VoidCallback restoredCallBack;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? ((context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: editCallBack,
                      icon: const Icon(Icons.edit),
                      label: const Text('Edit'),
                    ),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: task.isFavorite == false
                          ? const Icon(Icons.bookmark_add_outlined)
                          : const Icon(Icons.bookmark_remove),
                      label: task.isFavorite == false
                          ? const Text(' Add Bookmarks')
                          : const Text('Remove Bookmarks'),
                    ),
                    onTap: () {
                      likeOrDislike();
                    },
                  ),
                  PopupMenuItem(
                    onTap: cancel,
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete'),
                    ),
                  ),
                ])
            : (context) => [
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: restoredCallBack,
                      icon: const Icon(Icons.restore_from_trash),
                      label: const Text('Restore'),
                    ),
                    onTap: () {
                      null;
                    },
                  ),
                  PopupMenuItem(
                    child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Delete Forever'),
                    ),
                    onTap: () {
                      cancel();
                    },
                  ),
                ]);
  }
}
