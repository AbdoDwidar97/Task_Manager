import 'package:task_manager/Model/Components/tag_table.dart';
import 'package:task_manager/Model/Components/task_table.dart';
import 'package:task_manager/Model/Data/holder.dart';
import 'package:task_manager/Model/Data/sqlite_helper/tag_provider.dart';
import 'package:task_manager/Model/Data/sqlite_helper/task_provider.dart';
import 'package:task_manager/Model/Repositories/IRepo/i_repo_main_screen.dart';

class SqliteImplRepoMainScreen implements IRepoMainScreen
{

  @override
  void getAllTasks(OnCallRequest requestHolder) async
  {
    TaskProvider taskProvider = TaskProvider();
    List<TaskTable> tasks = await taskProvider.getAllTasks();

    requestHolder.onSuccess(tasks);
  }

  @override
  void getTagsOfTask(int taskID, OnCallRequest onCallRequest) async
  {
    TagProvider tagProvider = TagProvider();
    List<TagTable> tags = await tagProvider.getTagsOfTask(taskID);

    onCallRequest.onSuccess(tags);
  }

}