import 'package:flutter/material.dart';
import 'package:task_manager/Model/Components/tag_table.dart';
import 'package:task_manager/Model/Components/task.dart';
import 'package:task_manager/Model/Components/task_table.dart';
import 'package:task_manager/Model/Data/holder.dart';
import 'package:task_manager/Model/Enums/task_status_enum.dart';
import 'package:task_manager/Model/Repositories/IRepo/i_repo_create_task_screen.dart';
import 'package:task_manager/Model/Repositories/ImplRepo/sqlite_impl_repo_create_task_screen.dart';

enum SCREEN_MODE
{
  create,
  update
}

class CreateTaskScreenViewModel with ChangeNotifier
{
  SCREEN_MODE _screen_mode = SCREEN_MODE.create;

  final IRepoCreateTaskScreen _iRepoCreateTaskScreen = SqliteImplRepoCreateTaskScreen();
  Task? _updatedTask;

  DateTime? dateFrom, dateTo;

  List<String> _myTags = [];

  final List<String> _taskStatus = [];

  String? _selectedTag;
  final List<String> _tags = ["CRM", "Dynamics 365", "Figma", "Flutter"];
  final RequestHolder<List<TagTable>> _allTags = RequestHolder();

  final RequestHolder<TaskTable> _createTaskRequestHolder = RequestHolder();

  final RequestHolder<TaskTable> _updateTaskRequestHolder = RequestHolder();

  Task? get updatedTask => _updatedTask;
  List<String> get tags => _tags;
  List<String> get myTags => _myTags;

  List<String> get taskStatus => _taskStatus;

  String? _selectedStatus;

  String? get selectedTag => _selectedTag;
  String? get selectedStatus => _selectedStatus;

  RequestHolder<List<TagTable>> get allTags => _allTags;

  RequestHolder<TaskTable> get createTaskRequestHolder => _createTaskRequestHolder;
  RequestHolder<TaskTable> get updateTaskRequestHolder => _updateTaskRequestHolder;

  SCREEN_MODE get screen_mode => _screen_mode;

  CreateTaskScreenViewModel()
  {
    initTaskStatus();
  }

  void initTaskStatus()
  {
    for (TaskStatus status in TaskStatus.values)
    {
      _taskStatus.add(status.getString());
    }
  }

  void setScreenMode(SCREEN_MODE mode)
  {
    _screen_mode = mode;
    notifyListeners();
  }

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

  void setMyTags(List<String> myTags)
  {
    _myTags = myTags;
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

  void setStatus(String status)
  {
    _selectedStatus = status;
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
        onSuccess: (taskTable) => createTaskOnSuccess(taskTable, task.tags!),
        onFail: (errMsg) => createTaskOnFail(errMsg)
    ));
  }

  void updateTask(Task task)
  {
    _iRepoCreateTaskScreen.updateTask(TaskTable(
        taskName: task.taskName,
        description: task.description,
        dateFrom: task.dateFrom,
        dateTo: task.dateTo,
        taskStatus: task.taskStatus
    ), OnCallRequest(
        onHold: () => updateTaskOnHold(),
        onSuccess: (task) => updateTaskOnSuccess(task),
        onFail: (errMsg) => updateTaskOnFail(errMsg)
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

  createTaskOnSuccess(TaskTable task, List<String> tags)
  {
    _createTaskRequestHolder.setRequestStatus(REQUEST_STATUS.onSuccess);
    _createTagsOfTask(task.id!, tags);
    notifyListeners();
  }

  Future<void> _createTagsOfTask(int taskID, List<String> tags) async
  {
    for (String tagName in tags)
    {
      bool result = await _iRepoCreateTaskScreen.searchForTag(tagName);
      if (!result)
      {
        _createTag(tagName, taskID);
      }
    }
  }

  createTaskOnFail(errMsg)
  {
    _createTaskRequestHolder.setRequestStatus(REQUEST_STATUS.onFail);
    notifyListeners();
  }

  void _createTag(String tagName, int taskID)
  {
    _iRepoCreateTaskScreen.createTag(TagTable(
        tagName: tagName,
        taskID: taskID
    ), OnCallRequest(
        onHold: () => {},
        onSuccess: () => {},
        onFail: (errMsg) => {}
    ));
  }

  /// -------------------------------------------------

  updateTaskOnHold()
  {
    _updateTaskRequestHolder.setRequestStatus(REQUEST_STATUS.onHold);
    notifyListeners();
  }

  updateTaskOnSuccess(task)
  {
    _updateTaskRequestHolder.setRequestStatus(REQUEST_STATUS.onSuccess);
    notifyListeners();
  }

  updateTaskOnFail(errMsg)
  {
    _updateTaskRequestHolder.setRequestStatus(REQUEST_STATUS.onFail);
    notifyListeners();
  }

}