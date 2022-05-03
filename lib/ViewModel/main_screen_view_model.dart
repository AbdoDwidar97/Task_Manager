import 'package:flutter/material.dart';
import 'package:task_manager/Model/Components/tag_table.dart';
import 'package:task_manager/Model/Components/task.dart';
import 'package:task_manager/Model/Components/task_table.dart';
import 'package:task_manager/Model/Data/holder.dart';
import 'package:task_manager/Model/Repositories/IRepo/i_repo_main_screen.dart';
import 'package:task_manager/Model/Repositories/ImplRepo/sqlite_impl_repo_main_screen.dart';

class MainScreenViewModel with ChangeNotifier
{
  final IRepoMainScreen _iRepoMainScreen = SqliteImplRepoMainScreen();

  final List<Task> _tasks = [

    /*Task(
      taskName: "Task 1",
      description: "Better job descriptions attract better candidates. Optimized for job board approval and SEO, our 700+ job description templates boost exposure, provide inspiration and speed up hiring. Rich in the right kind of content, they also lead to more qualified applicants.",
      dateFrom: DateTime.now(),
      dateTo: DateTime.now().add(const Duration(days: 3)),
      taskStatus: 0,
      tags: [
        "CRM",
        "Dynamics 365"
      ]
    ),

    Task(
        taskName: "Task 2",
        description: "Better job descriptions attract better candidates. Optimized for job board approval and SEO, our 700+ job description templates boost exposure, provide inspiration and speed up hiring. Rich in the right kind of content, they also lead to more qualified applicants.",
        dateFrom: DateTime.now(),
        dateTo: DateTime.now().add(const Duration(days: 3)),
        taskStatus: 0,
        tags: [
          "Flutter",
          "API"
        ]
    ),

    Task(
        taskName: "Task 3",
        description: "Better job descriptions attract better candidates. Optimized for job board approval and SEO, our 700+ job description templates boost exposure, provide inspiration and speed up hiring. Rich in the right kind of content, they also lead to more qualified applicants.",
        dateFrom: DateTime.now(),
        dateTo: DateTime.now().add(const Duration(days: 3)),
        taskStatus: 0,
        tags: [
          "UI/UX Design",
          "Figma"
        ]
    ),*/

  ];

  final RequestHolder<List<TaskTable>> _myTableTasks = RequestHolder();
  final RequestHolder<Map<int, List<TagTable>>> _myTagsOfTasks = RequestHolder();

  List <Task> get tasks => _tasks;

  RequestHolder<List<TaskTable>> get myTableTasks => _myTableTasks;
  RequestHolder<Map<int, List<TagTable>>> get myTagsOfTasks => _myTagsOfTasks;

  void getAllTasks()
  {
    _iRepoMainScreen.getAllTasks(OnCallRequest(
        onHold: () => tasksOnHold(),
        onSuccess: (tasks) => tasksOnSuccess(tasks),
        onFail: (errMsg) => tasksOnFail(errMsg)
    ));
  }

  void getTagOfTask(int taskID)
  {
    _iRepoMainScreen.getTagsOfTask(taskID, OnCallRequest(
        onHold: () => tagsOnHold(),
        onSuccess: (tags) => tagsOnSuccess(taskID, tags),
        onFail: (errMsg) => tagsOnFail(errMsg)
    ));
  }

  void tasksOnHold()
  {
    _myTableTasks.setRequestStatus(REQUEST_STATUS.onHold);
    notifyListeners();
  }

  void tasksOnSuccess(List<TaskTable> tasks)
  {
    _myTableTasks.setRequestStatus(REQUEST_STATUS.onSuccess);
    _myTableTasks.setValue(tasks);

    _setTasks(tasks);

    notifyListeners();
  }

  void tasksOnFail(String errMsg)
  {
    _myTableTasks.setRequestStatus(REQUEST_STATUS.onFail);
    _myTableTasks.setErrorMessage(errMsg);
    notifyListeners();
  }

  /// --------------------------------------------------------------------------

  void tagsOnHold()
  {
    _myTagsOfTasks.setRequestStatus(REQUEST_STATUS.onHold);
    notifyListeners();
  }

  void tagsOnSuccess(int taskID, List<TagTable> tags)
  {
    _myTagsOfTasks.setRequestStatus(REQUEST_STATUS.onSuccess);

    Map<int, List<TagTable>> tagsMap = {};

    if (_myTagsOfTasks.value == null)
    {
      _myTagsOfTasks.setValue(tagsMap);

    }else {
      tagsMap = _myTagsOfTasks.value!;
    }

    tagsMap[taskID] = tags;

    _myTagsOfTasks.setValue(tagsMap);

    _setTagsIntoTask(taskID, tags);

    notifyListeners();
  }

  void tagsOnFail(String errMsg)
  {
    _myTagsOfTasks.setRequestStatus(REQUEST_STATUS.onFail);
    _myTagsOfTasks.setErrorMessage(errMsg);

    notifyListeners();
  }

  void _setTagsIntoTask(int taskID, List<TagTable> tags)
  {
    for (int idx = 0; idx < _tasks.length; idx++)
    {
      if (taskID == _tasks[idx].id)
      {
        _tasks[idx].tags = _getTagsString(tags);
      }
    }
  }

  List<String> _getTagsString(List<TagTable> tags)
  {
    List<String> sTags = [];
    for (TagTable itr in tags)
    {
      sTags.add(itr.tagName!);
    }

    return sTags;
  }

  void _setTasks(List<TaskTable> tasks)
  {
    _tasks.clear();
    for (TaskTable taskTable in tasks)
    {
      _tasks.add(taskTable.parseToTask());
    }
  }

}