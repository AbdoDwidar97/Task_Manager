import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget
{
  BuildContext? context;
  TextEditingController? myController;
  DateTime? initialDate, firstDate, endDate, selectedDate;

  @override
  State<StatefulWidget> createState() => DateTimePickerState();
}

class DateTimePickerState extends State <DateTimePicker>
{
  double widthUnit = 0, heightUnit = 0;

  @override
  void initState()
  {
    super.initState();
    widget.myController!.text = DateFormat("yMMMd").add_jm().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context)
  {
    widthUnit = MediaQuery.of(context).size.width / 50;
    heightUnit = MediaQuery.of(context).size.height / 50;

    return InkWell(
      onTap: () => _selectDate(widget.context!),
      child: TextFormField(
        controller: widget.myController,
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
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.initialDate!,
        firstDate: widget.firstDate!,
        lastDate: widget.endDate!
    );

    if (picked != null && picked != widget.selectedDate) {
      setState(() {
        widget.selectedDate = picked;
      });
    }
  }

}