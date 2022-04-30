import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/App%20Recourses/app_colors.dart';
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
      body: Container(
        width: widthUnit * 50,
        height: heightUnit * 50,
        color: Colors.white,
        child: Consumer<MainScreenViewModel>(
          builder: (context, mainScreenViewModel, child)
          {
            return ListView.builder(
              itemCount: mainScreenViewModel.tasks.length,
              itemBuilder: (context, idx)
              {
                return Card(
                  color: Colors.blue[300],
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
                                Icon(Icons.edit, color: Colors.white, size: widthUnit * heightUnit * 0.28),
                                SizedBox(width: widthUnit),
                                Icon(Icons.delete, color: Colors.white, size: widthUnit * heightUnit * 0.28),
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

}