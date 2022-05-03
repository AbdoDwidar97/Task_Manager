import 'package:flutter/material.dart';
import 'package:task_manager/Model/Components/tag_table.dart';
import 'package:task_manager/Model/Components/task.dart';
import 'package:task_manager/Model/Components/task_table.dart';
import 'package:task_manager/Model/Data/holder.dart';
import 'package:task_manager/Model/Repositories/IRepo/i_repo_create_task_screen.dart';
import 'package:task_manager/Model/Repositories/ImplRepo/sqlite_impl_repo_create_task_screen.dart';

class CreateTaskScreenViewModel with ChangeNotifier
{
  final IRepoCreateTaskScreen _iRepoCreateTaskScreen = SqliteImplRepoCreateTaskScreen();
  Task? _updatedTask;

  DateTime? dateFrom, dateTo;

  final List<String> _myTags = [];

  String? _selectedTag;
  final List<String> _tags = ["CRM", "Dynamics 365", "Figma", "Flutter"];
  final RequestHolder<List<TagTable>> _allTags = RequestHolder();

  final RequestHolder<TaskTable> _createTaskRequestHolder = RequestHolder();

  Task? get updatedTask => _updatedTask;
  List<String> get tags => _tags;
  List<String> get myTags => _myTags;

  String? get selectedTag => _selectedTag;
  RequestHolder<List<TagTable>> get allTags => _allTags;

  RequestHolder<TaskTable> get createTaskRequestHolder => _createTaskRequestHolder;

  void setUpdatedTask(Task task)
  {
    _updatedTask = task;
    notifyListeners();
  }

  void setDateTimeFrom(DateTime from)
  {
    dateFrom = from;
    notifyListeners();
  }

  void setDateTimeTo(DateTime to)
  {
    dateTo = to;
    notifyListeners();
  }

  void setMyTag(String tag)
  {
    _myTags.add(tag);
    _selectedTag = tag;
    notifyListeners();
  }

  void addNewMyTag(String tag)
  {
    _myTags.add(tag);
    notifyListeners();
  }

  void removeTag(String tag)
  {
    _myTags.remove(tag);
    notifyListeners();
  }

  void getAllTags()
  {
    _iRepoCreateTaskScreen.getAllTags(OnCallRequest(
        onHold: () => tagsOnHold(),
        onSuccess: (tags) => tagsOnSuccess(tags),
        onFail: (errMsg) => tagsOnFail(errMsg)
    ));
  }

  void createTask(Task task)
  {
    _iRepoCreateTaskScreen.createNewTask(TaskTable(
      taskName: task.taskName,
      description: task.description,
      dateFrom: task.dateFrom,
      dateTo: task.dateTo,
      taskStatus: task.taskStatus
    ), OnCallRequest(
        onHold: () => createTaskOnHold(),
        onSuccess: (task) => createTaskOnSuccess(task),
        onFail: (errMsg) => createTaskOnFail(errMsg)
    ));
  }

  tagsOnHold()
  {
    _allTags.setRequestStatus(REQUEST_STATUS.onHold);
    notifyListeners();
  }

  tagsOnSuccess(List<TagTable> tags)
  {
    _allTags.setRequestStatus(REQUEST_STATUS.onSuccess);
    _allTags.setValue(tags);

    _setTags(tags);

    notifyListeners();
  }

  tagsOnFail(String errMsg)
  {
    _allTags.setRequestStatus(REQUEST_STATUS.onFail);
    _allTags.setErrorMessage(errMsg);
    notifyListeners();
  }

  void _setTags(List<TagTable> tags)
  {
    _tags.clear();
    for (TagTable tag in tags)
    {
      _tags.add(tag.tagName!);
    }
  }

  /// ------------------------------------------------

  createTaskOnHold()
  {
    _createTaskRequestHolder.setRequestStatus(REQUEST_STATUS.onHold);
    notifyListeners();
  }

  createTaskOnSuccess(task)
  {
    _createTaskRequestHolder.setRequestStatus(REQUEST_STATUS.onSuccess);

    /// here we should update tasks in UI
    notifyListeners();
  }

  createTaskOnFail(errMsg)
  {
    _createTaskRequestHolder.setRequestStatus(REQUEST_STATUS.onFail);
    notifyListeners();
  }

}