import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/Model/Components/task.dart';
import 'package:task_manager/Model/Enums/task_status_enum.dart';
import 'package:task_manager/View/Widgets/date_time_picker.dart';
import 'package:task_manager/ViewModel/create_task_screen_view_model.dart';

class CreateTaskScreen extends StatefulWidget
{
  Task? myTask;

  CreateTaskScreen({Key? key, this.myTask}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CreateTaskScreenState();
}

class CreateTaskScreenState extends State <CreateTaskScreen>
{

  double widthUnit = 0, heightUnit = 0;
  late CreateTaskScreenViewModel _createTaskScreenViewModel;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final taskNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagController = TextEditingController();
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();

  @override
  void initState()
  {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_)
    {
      initScreen();
    });
  }

  void initScreen()
  {
    getAllTags();

    if (widget.myTask != null)
    {
      Provider.of<CreateTaskScreenViewModel>(context, listen: false).setScreenMode(SCREEN_MODE.update);

      taskNameController.text = widget.myTask!.taskName!;
      descriptionController.text = widget.myTask!.description!;
      dateFromController.text = DateFormat("yMMMd").add_jm().format(widget.myTask!.dateFrom!);
      dateToController.text = DateFormat("yMMMd").add_jm().format(widget.myTask!.dateTo!);

      Provider.of<CreateTaskScreenViewModel>(context, listen: false).setMyTags(widget.myTask!.tags!);
      Provider.of<CreateTaskScreenViewModel>(context, listen: false).setStatus(TaskStatus.values[widget.myTask!.taskStatus!].getString());
    }

  }

  void getAllTags()
  {
    Provider.of<CreateTaskScreenViewModel>(context, listen: false).getAllTags();
  }

  @override
  Widget build(BuildContext context)
  {
    widthUnit = MediaQuery.of(context).size.width / 50;
    heightUnit = MediaQuery.of(context).size.height / 50;

    _createTaskScreenViewModel = Provider.of<CreateTaskScreenViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Create Task", style: TextStyle(fontSize: widthUnit * heightUnit * 0.16, color: Colors.black)),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => screenClose(),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.close, color: Colors.black, size: widthUnit * heightUnit * 0.27),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(
              left: widthUnit * 1.5,
              right: widthUnit * 1.5,
            ),
            width: widthUnit * 50,
            height: heightUnit * 44.5,
            color: Colors.white,
            child: Column(
              children: [

                TextFormField(
                  controller: taskNameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                    ),
                    label: Text("Task Name", style: TextStyle(fontSize: widthUnit * heightUnit * 0.12, color: Colors.black))
                  ),
                  validator: (val) => val!.isEmpty ? "Required Field" : null,
                ),

                SizedBox(height: heightUnit),

                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 1,
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2.0,
                        ),
                      ),
                      label: Text("Description", style: TextStyle(fontSize: widthUnit * heightUnit * 0.12, color: Colors.black))
                  ),
                  validator: (val) => val!.isEmpty ? "Required Field" : null,
                ),

                SizedBox(height: heightUnit),

                /// Dates
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    SizedBox(
                      width: widthUnit * 22,
                      child: AppDateTimePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        endDate: DateTime(2100),
                        initialDate: DateTime.now(),
                        myController: dateFromController,
                        label: "Date Time From",
                      ),
                    ),

                    SizedBox(
                      width: widthUnit * 22,
                      child: AppDateTimePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        endDate: DateTime(2100),
                        initialDate: DateTime.now(),
                        myController: dateToController,
                        label: "Date Time To",
                      ),
                    ),

                  ],
                ),

                SizedBox(height: heightUnit),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Consumer<CreateTaskScreenViewModel>(
                        builder: (context, createTaskScreenViewModel, child)
                        {
                           return SizedBox(
                             width: widthUnit * 20,
                             child: DropdownButtonHideUnderline(
                               child: DropdownButton(
                                 alignment: Alignment.topLeft,
                                 hint: Text("Select Tag", style: TextStyle(fontSize: widthUnit * heightUnit * 0.13)),
                                 items: createTaskScreenViewModel.tags.map((e) {
                                   return DropdownMenuItem(
                                     value: e,
                                     child: Text(e, style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, color: Colors.black)),
                                   );
                                 } ).toList(),
                                 onChanged: (val) => createTaskScreenViewModel.setMyTag(val.toString()),
                                 value: createTaskScreenViewModel.selectedTag,
                               ),
                             ),
                           );
                        }
                    ),

                    SizedBox(
                      width: widthUnit * 20,
                      child: TextFormField(
                        controller: tagController,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 2.0,
                              ),
                            ),
                            label: Text("Add Tag", style: TextStyle(fontSize: widthUnit * heightUnit * 0.12, color: Colors.black))
                        ),
                      ),
                    ),

                    SizedBox(
                      width: widthUnit * 7,
                      height: heightUnit * 3,
                      child: ElevatedButton(
                          onPressed: () => btnAddTag(tagController.text.trim()),
                          child: Icon(Icons.add, color: Colors.white, size: widthUnit * heightUnit * 0.2)
                      )
                    ),

                  ],
                ),

                SizedBox(height: heightUnit),

                Consumer<CreateTaskScreenViewModel>(
                    builder: (context, createTaskScreenViewModel, child)
                    {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          children: createTaskScreenViewModel.myTags.map((e) {
                            return Padding(
                              padding: EdgeInsets.only(right: widthUnit * 0.5, bottom: heightUnit * 0.5),
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
                                child: RichText(
                                  text: TextSpan(
                                      children: [
                                        TextSpan(text: "$e   ", style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, color: Colors.white)),

                                        TextSpan(text: "x", style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, color: Colors.white),
                                            recognizer: TapGestureRecognizer()..onTap = ()
                                            {
                                              createTaskScreenViewModel.removeTag(e);
                                            }),
                                      ]
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                ),

                SizedBox(height: heightUnit),

                Consumer<CreateTaskScreenViewModel>(
                    builder: (context, createTaskScreenViewModel, child)
                    {
                      return SizedBox(
                        width: widthUnit * 50,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            alignment: Alignment.topLeft,
                            hint: Text("Select Status", style: TextStyle(fontSize: widthUnit * heightUnit * 0.13)),
                            items: createTaskScreenViewModel.taskStatus.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e, style: TextStyle(fontSize: widthUnit * heightUnit * 0.13, color: Colors.black)),
                              );
                            } ).toList(),
                            onChanged: (val) => createTaskScreenViewModel.setStatus(val.toString()),
                            value: createTaskScreenViewModel.selectedStatus,
                          ),
                        ),
                      );
                    }
                ),

                SizedBox(height: heightUnit * 2),

                (_createTaskScreenViewModel.screen_mode == SCREEN_MODE.create) ?
                SizedBox(
                    width: widthUnit * 50,
                    height: heightUnit * 3,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                        ),
                        onPressed: () => addTask(),
                        child: Text("Add Task", style: TextStyle(fontSize: widthUnit * heightUnit * 0.12, color: Colors.white))
                    )
                ) : SizedBox(
                    width: widthUnit * 50,
                    height: heightUnit * 3,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )),
                        ),
                        onPressed: () => updateTask(),
                        child: Text("Update Task", style: TextStyle(fontSize: widthUnit * heightUnit * 0.12, color: Colors.white))
                    )
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  screenClose()
  {
    Navigator.of(context).pop();
  }

  void btnAddTag(String tag)
  {
    if (tag.isNotEmpty)
    {
      _createTaskScreenViewModel.addNewMyTag(tag);
    }
  }

  addTask()
  {
    _createTaskScreenViewModel.createTask(Task(
      taskName: taskNameController.text.trim(),
      taskStatus: TaskStatus.values.indexWhere((element) => element.getString() == _createTaskScreenViewModel.selectedStatus),
      description: descriptionController.text.trim(),
      dateFrom: DateTime.parse(dateFromController.text.trim()),
      dateTo: DateTime.parse(dateToController.text.trim()),
      tags: _createTaskScreenViewModel.myTags
    ));
  }

  updateTask()
  {
    _createTaskScreenViewModel.updateTask(Task(
        id: widget.myTask!.id!,
        taskName: taskNameController.text.trim(),
        taskStatus: TaskStatus.values.indexWhere((element) => element.getString() == _createTaskScreenViewModel.selectedStatus),
        description: descriptionController.text.trim(),
        dateFrom: DateTime.parse(dateFromController.text.trim()),
        dateTo: DateTime.parse(dateToController.text.trim()),
        tags: _createTaskScreenViewModel.myTags
    ));
  }

}