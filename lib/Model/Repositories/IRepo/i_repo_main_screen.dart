import 'package:task_manager/Model/Data/holder.dart';

abstract class IRepoMainScreen
{
  void getAllTasks(OnCallRequest requestHolder);
  void getTagsOfTask(int taskID, OnCallRequest requestHolder);
}