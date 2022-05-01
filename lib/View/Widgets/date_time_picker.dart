import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateTimePicker extends StatefulWidget
{
  BuildContext? context;
  TextEditingController? myController;
  DateTime? initialDate, firstDate, endDate, selectedDate;
  String? label;

  AppDateTimePicker({
    this.context,
    this.myController,
    this.endDate,
    this.firstDate,
    this.initialDate,
    this.label
  });

  @override
  State<StatefulWidget> createState() => AppDateTimePickerState();
}

class AppDateTimePickerState extends State <AppDateTimePicker>
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

    return TextFormField(
      onTap: () => _selectDate(widget.context!),
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
          label: Text(widget.label!, style: TextStyle(fontSize: widthUnit * heightUnit * 0.12, color: Colors.black))
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async
  {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.initialDate!,
        firstDate: widget.firstDate!,
        lastDate: widget.endDate!
    );

    if (picked != null && picked != widget.selectedDate)
    {
      TimeOfDay? selectedTime = TimeOfDay(hour: picked.hour, minute: picked.minute);
      selectedTime = await showTimePicker(
        initialTime: TimeOfDay.now(),
        context: widget.context!,
      );

      setState(() {
        widget.selectedDate = picked;
        widget.myController!.text = DateFormat("yMMMd").add_jm().format(picked.add(Duration(hours: selectedTime!.hour, minutes: selectedTime.minute)));
      });
    }
  }

}