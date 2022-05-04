import 'package:task_manager/Model/Components/tag_table.dart';
import 'package:task_manager/Model/Components/task_table.dart';
import 'package:task_manager/Model/Data/holder.dart';
import 'package:task_manager/Model/Data/sqlite_helper/tag_provider.dart';
import 'package:task_manager/Model/Data/sqlite_helper/task_provider.dart';
import 'package:task_manager/Model/Repositories/IRepo/i_repo_create_task_screen.dart';

class SqliteImplRepoCreateTaskScreen implements IRepoCreateTaskScreen
{
  @override
  void createNewTask(TaskTable table, OnCallRequest onCallRequest) async
  {
    TaskProvider taskProvider = TaskProvider();
    TaskTable response = await taskProvider.insert(table);
    onCallRequest.onSuccess(response);
  }

  @override
  void getAllTags(OnCallRequest onCallRequest) async
  {
    TagProvider tagProvider = TagProvider();
    List<TagTable> tags = await tagProvider.getAllTags();
    onCallRequest.onSuccess(tags);
  }

  @override
  void updateTask(TaskTable table, OnCallRequest onCallRequest) async
  {
    TaskProvider taskProvider = TaskProvider();
    int response = await taskProvider.update(table);
    if (response > 0)
    {
      onCallRequest.onSuccess();
    }
    else
    {
      onCallRequest.onFail("Something went wrong, try again later!");
    }
  }

  @override
  void createTag(TagTable tag, OnCallRequest onCallRequest) async
  {
    TagProvider tagProvider = TagProvider();
    await tagProvider.insert(tag);
    onCallRequest.onSuccess();
  }

  @override
  Future<bool> searchForTag(String tagName) async
  {
    TagProvider tagProvider = TagProvider();
    TagTable? tg = await tagProvider.getTagByName(tagName);
    if (tg != null)
    {
      return true;
    } else
    {
      return false;
    }
  }

}