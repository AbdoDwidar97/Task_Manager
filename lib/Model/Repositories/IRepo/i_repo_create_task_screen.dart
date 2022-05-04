import 'package:task_manager/Model/Components/tag_table.dart';
import 'package:task_manager/Model/Components/task_table.dart';
import 'package:task_manager/Model/Data/holder.dart';

abstract class IRepoCreateTaskScreen
{
  void getAllTags(OnCallRequest onCallRequest);
  void createNewTask(TaskTable task, OnCallRequest onCallRequest);
  void updateTask(TaskTable task, OnCallRequest onCallRequest);
  void createTag(TagTable tag, OnCallRequest onCallRequest);
  Future searchForTag(String tagName);
}