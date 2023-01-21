import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todoruska/bloc/bloc_export.dart';
import 'dart:convert';
import '../../models/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<FavoriteTask>(_onFavoriteTask);
    on<EditTask>(_onEditTask);
    on<RestoreTask>(_onRestoreTask);
    on<DeleteAllTasks>(_onDeleteAllTasks);
  }
  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)..add(event.task),
      removedTasks: state.removedTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTasks = state.pendingTasks;
    List<Task> completedTasks = state.completedTasks;
    List<Task> favoriteTasks = state.favoriteTasks;

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks = List.from(completedTasks)
          ..insert(0, task.copyWith(isDone: true));
      } else {
        var indexTasks = favoriteTasks.indexOf(task);
        pendingTasks = List.from(pendingTasks)..remove(task);
        completedTasks.insert(0, task.copyWith(isDone: true));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(indexTasks, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavorite == false) {
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var indexTasks = favoriteTasks.indexOf(task);
        completedTasks = List.from(completedTasks)..remove(task);
        pendingTasks = List.from(pendingTasks)
          ..insert(0, task.copyWith(isDone: false));
        favoriteTasks = List.from(favoriteTasks)
          ..remove(task)
          ..insert(indexTasks, task.copyWith(isDone: false));
      }
    }

    emit(TasksState(
      pendingTasks: pendingTasks,
      completedTasks: completedTasks,
      favoriteTasks: favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTasks: state.pendingTasks,
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
      removedTasks: List.from(state.removedTasks)..remove(event.task),
    ));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          pendingTasks: List.from(state.pendingTasks)..remove(event.task),
          completedTasks: List.from(state.completedTasks)..remove(event.task),
          favoriteTasks: List.from(state.favoriteTasks)..remove(event.task),
          removedTasks: List.from(state.removedTasks)
            ..add(
              event.task.copyWith(isDeleted: true),
            )),
    );
  }

  void _onFavoriteTask(FavoriteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTask = state.pendingTasks;
    List<Task> completedTask = state.completedTasks;
    List<Task> favoriteTask = state.favoriteTasks;

    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTask.indexOf(event.task);
        pendingTask = List.from(state.pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTask.insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = pendingTask.indexOf(event.task);
        pendingTask = List.from(state.pendingTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTask.remove(event.task);
        print('done');
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTask.indexOf(event.task);
        completedTask = List.from(state.completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: true));
        favoriteTask.insert(0, event.task.copyWith(isFavorite: true));
        print('done');
      } else {
        var taskIndex = completedTask.indexOf(event.task);
        completedTask = List.from(state.completedTasks)
          ..remove(event.task)
          ..insert(taskIndex, event.task.copyWith(isFavorite: false));
        favoriteTask.remove(event.task);
        print('done');
      }
    }
    emit(TasksState(
      pendingTasks: pendingTask,
      completedTasks: completedTask,
      favoriteTasks: state.favoriteTasks,
      removedTasks: state.removedTasks,
    ));
  }

  void _onEditTask(EditTask event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> favouriteTask = state.favoriteTasks;
    if (event.oldTask.isFavorite == true) {
      favouriteTask
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksState(
      pendingTasks: List.from(state.pendingTasks)
        ..remove(event.oldTask)
        ..insert(0, event.newTask),
      completedTasks: state.completedTasks..remove(event.oldTask),
      favoriteTasks: favouriteTask,
      removedTasks: state.removedTasks,
    ));
  }

  void _onRestoreTask(RestoreTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removedTasks: List.from(state.removedTasks)..remove(event.task),
      pendingTasks: List.from(state.pendingTasks)
        ..insert(
            0,
            event.task
                .copyWith(isDeleted: false, isDone: false, isFavorite: false)),
      completedTasks: state.completedTasks,
      favoriteTasks: state.favoriteTasks,
    ));
  }

  void _onDeleteAllTasks(DeleteAllTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
          removedTasks: List.from(state.removedTasks)..clear(),
          pendingTasks: state.pendingTasks,
          completedTasks: state.completedTasks,
          favoriteTasks: state.favoriteTasks),
    );
  }

  @override
  TasksState fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
