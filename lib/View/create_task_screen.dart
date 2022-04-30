import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/ViewModel/create_task_screen_view_model.dart';
import 'package:task_manager/ViewModel/main_screen_view_model.dart';

class CreateTaskScreen extends StatefulWidget
{
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
      body: Form(
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

              Row(
                children: [

                  SizedBox(
                    width: widthUnit * 22,
                    child: TextFormField(
                      controller: descriptionController,
                      readOnly: true,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2.0,
                            ),
                          ),
                          label: Text("Date From", style: TextStyle(fontSize: widthUnit * heightUnit * 0.12, color: Colors.black))
                      ),
                      validator: (val) => val!.isEmpty ? "Required Field" : null,
                    )
                  ),

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  screenClose()
  {
    Navigator.of(context).pop();
  }

}