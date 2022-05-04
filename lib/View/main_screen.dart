import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/App%20Recourses/app_colors.dart';
import 'package:task_manager/Model/Components/task.dart';
import 'package:task_manager/Model/Data/holder.dart';
import 'package:task_manager/Model/Enums/task_status_enum.dart';
import 'package:task_manager/View/create_task_screen.dart';
import 'package:task_manager/ViewModel/main_screen_view_model.dart';
import 'package:intl/intl.dart';

class MainScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State <MainScreen>
{
  double widthUnit = 0, heightUnit = 0;

  late MainScreenViewModel _mainScreenViewModel;

  @override
  void initState()
  {
    super.initState();
    initializeDateFormatting("en");

    WidgetsBinding.instance!.addPostFrameCallback((_)
    {
      Provider.of<MainScreenViewModel>(context, listen: false).getAllTasks();
    });

  }

  @override
  Widget build(BuildContext context)
  {
    widthUnit = MediaQuery.of(context).size.width / 50;
    heightUnit = MediaQuery.of(context).size.height / 50;

    _mainScreenViewModel = Provider.of<MainScreenViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Task Manager", style: TextStyle(fontSize: widthUnit * heightUnit * 0.16, color: Colors.black)),
        centerTitle: true,
      ),
      extendBody: true,
      floatingActionButton: SizedBox(
        width: widthUnit * 7,
        height: heightUnit * 6,
        child: FloatingActionButton(
          backgroundColor: AppColors.mainBackgroundColor,
          child: Icon(Icons.add, color: Colors.white, size: widthUnit * heightUnit * 0.2),
          onPressed: () => showCreateTaskScreen(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SizedBox(
        width: widthUnit * 50,
        height: heightUnit * 50,
        child: Consumer<MainScreenViewModel>(
          builder: (context, mainScreenViewModel, child)
          {
            if (mainScreenViewModel.myTableTasks.request_status == REQUEST_STATUS.onHold)
            {
              return SizedBox(
                width: widthUnit * 3.6,
                height: heightUnit * 3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            else if (mainScreenViewModel.myTableTasks.request_status == REQUEST_STATUS.onSuccess)
            {
              if (mainScreenViewModel.tasks.isNotEmpty)
              {
                return ListView.builder(
                  itemCount: mainScreenViewModel.tasks.length,
                  itemBuilder: (context, idx)
                  {
                    mainScreenViewModel.getTagOfTask(mainScreenViewModel.tasks[idx].id!);

                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: widthUnit * 1.5,
                            right: widthUnit * 1.5
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SizedBox(height: heightUnit * 1.5),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                /// Task Name & Status
                                Row(
                                  children: [

                                    Text(mainScreenViewModel.tasks[idx].taskName!, style: TextStyle(fontSize: widthUnit * heightUnit * 0.17, color: Colors.black, fontWeight: FontWeight.bold)),

                                    Text(" (${TaskStatus.values.elementAt(mainScreenViewModel.tasks[idx].taskStatus!).getString()})", style: TextStyle(fontSize: widthUnit * heightUnit * 0.17, color: Colors.blue[900])),

                                  ],
                                ),

                                /// Controls
                                Row(
                                  children: [

                                    InkWell(
                                        onTap: () => showUpdateTaskScreen(mainScreenViewModel.tasks[idx]),
                                        child: Icon(Icons.edit, color: Colors.blue[900], size: widthUnit * heightUnit * 0.28
                                      )
                                    ),

                                    SizedBox(width: widthUnit),

                                    InkWell(
                                        onTap: () => deleteTask(mainScreenViewModel.tasks[idx]),
                                        child: Icon(Icons.delete, color: Colors.red[800], size: widthUnit * heightUnit * 0.28),
                                    ),

                                  ],
                                ),

                              ],
                            ),

                            SizedBox(height: heightUnit),

                            Text(mainScreenViewModel.tasks[idx].description!, style: TextStyle(fontSize: widthUnit * heightUnit * 0.14, color: Colors.black)),

                            SizedBox(height: heightUnit),

                            /// Start Date
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Icon(Icons.date_range, color: Colors.blue[900], size: widthUnit * heightUnit * 0.18),

                                SizedBox(width: widthUnit * 0.7),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("Start Date", style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, fontWeight: FontWeight.bold, color: Colors.blue[900], height: 1.3)),

                                    Text(DateFormat("yMMMd").add_jm().format(mainScreenViewModel.tasks[idx].dateFrom!), style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, fontWeight: FontWeight.bold, color: Colors.black)),

                                  ],
                                ),

                              ],
                            ),

                            SizedBox(height: heightUnit),

                            /// End Date
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Icon(Icons.date_range, color: Colors.blue[900], size: widthUnit * heightUnit * 0.18),

                                SizedBox(width: widthUnit * 0.7),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text("End Date", style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, fontWeight: FontWeight.bold, color: Colors.blue[900], height: 1.3)),

                                    Text(DateFormat("yMMMd").add_jm().format(mainScreenViewModel.tasks[idx].dateTo!), style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, fontWeight: FontWeight.bold, color: Colors.black)),

                                  ],
                                ),

                              ],
                            ),

                            SizedBox(height: heightUnit),

                            SizedBox(
                              width: widthUnit * 50,
                              child: Divider(
                                color: Colors.blue[800]!,
                                thickness: heightUnit * 0.02,
                              ),
                            ),

                            SizedBox(height: heightUnit),

                            Wrap(
                              children: mainScreenViewModel.tasks[idx].tags!.map((e) {
                                return Padding(
                                  padding: EdgeInsets.only(right: widthUnit * 0.5),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: heightUnit * 0.5,
                                        bottom: heightUnit * 0.5,
                                        left: widthUnit,
                                        right: widthUnit
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(24),
                                        color: Colors.blue[900]
                                    ),
                                    child: Text(e, style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, color: Colors.white)),
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: heightUnit * 1.5),

                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              else
              {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info_outline, color: Colors.red[800], size: widthUnit * heightUnit * 0.6),
                      SizedBox(height: heightUnit),
                      Text("No Tasks Found!", style: TextStyle(fontSize: widthUnit * heightUnit * 0.16, color: Colors.black)),
                    ],
                  ),
                );
              }
            }
            else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_outlined, color: Colors.red[800], size: widthUnit * heightUnit * 0.3),
                    SizedBox(height: heightUnit),
                    Text("Something went wrong,\nTry again later.", style: TextStyle(fontSize: widthUnit * heightUnit * 0.17, color: Colors.black)),
                  ],
                ),
              );
            }
          }
        ),
      ),
    );

  }

  void showCreateTaskScreen()
  {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CreateTaskScreen()),
    );
  }

  void showUpdateTaskScreen(Task task)
  {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => CreateTaskScreen(myTask: task)),
    );
  }

  deleteTask(Task task)
  {

  }

}