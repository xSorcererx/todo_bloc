import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo_bloc/data/models/todo_model.dart';
import 'package:todo_bloc/data/repos/todo_repo.dart';

import 'package:todo_bloc/logic/bloc/datetime_bloc.dart';
import 'package:todo_bloc/logic/bloc/radio_button_bloc.dart';
import 'package:todo_bloc/logic/bloc/todo_bloc.dart';

import 'package:todo_bloc/presentation/modules/home/home_screen.dart';
import 'package:todo_bloc/presentation/utils/radio_list.dart';
import 'package:todo_bloc/presentation/utils/size_constants.dart';
import 'package:todo_bloc/presentation/widgets/date_time_widget.dart';
import 'package:todo_bloc/presentation/widgets/radio_button.dart';
import 'package:todo_bloc/presentation/widgets/title_text_field.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({
    super.key,
  });

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  // initializing text controllers.
  final titleController = TextEditingController();
  final descController = TextEditingController();

  // initializing required blocs.
  final DatetimeBloc dateBloc = DatetimeBloc();
  final DatetimeBloc timeBloc = DatetimeBloc();
  final TodoBloc todoBloc = TodoBloc();
  final RadioButtonBloc radioBtnBloc = RadioButtonBloc();

  String dateValue = '';
  String timeValue = '';
  bool isPosted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.766,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              'New Task To Do',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
            ),
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 1.2,
          ),
          SBC.xLH,
          // title and text field widget
          CustomTextField(
            title: 'Task Title',
            hintText: 'Add Task Name',
            maxLines: 1,
            textEditingController: titleController,
          ),
          SBC.xLH,
          CustomTextField(
            title: 'Task Description',
            hintText: 'Add Description',
            maxLines: 4,
            textEditingController: descController,
          ),
          SBC.xLH,
          Text(
            "Category",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
          ),
          // SBC.sH,

          // to do category section
          BlocBuilder<RadioButtonBloc, RadioButtonState>(
            builder: (context, state) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Row(
                  children: [
                    // using same bloc instance with list builder to manage the state.
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: RadioWidget(
                          radioTitle: radioTitle[index],
                          catColor: radioColor[index],
                          value: index + 1,
                          radioBloc: radioBtnBloc,
                          onChanged: () {
                            /*
                               adding an event to register the changed state of radio button widget
                               to emit the new state, new radio button value is passed to the event
                            */
                            radioBtnBloc.add(
                                RadioButtonClickedEvent(radioValue: index + 1));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // date and time section
          BlocBuilder<DatetimeBloc, DatetimeState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // initializing different bloc instances to manage state bc the widget is being instantiated twice separately.
                  DateTimeWidget(
                    title: 'Date',
                    value: 'dd/mm/yy',
                    icon: CupertinoIcons.calendar,
                    datetimeBloc: dateBloc,
                    onTap: () async {
                      // getting the date using date picker
                      final getDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(days: 6),
                        ),
                      );

                      if (getDate != null) {
                        // initializing date formatter in the format dd/mm/yyyy
                        final formatValue = DateFormat.yMd();
                        dateValue = formatValue.format(getDate);
                        /*
                          adding an event to register the changed state of date widget
                          to emit the new state, formatted date value is passed to the event
                        */
                        dateBloc.add(
                          DateValueChangeEvent(dateValue: dateValue),
                        );
                      }
                    },
                  ),
                  DateTimeWidget(
                    title: 'Time',
                    value: 'hh : mm',
                    icon: CupertinoIcons.clock,
                    datetimeBloc: timeBloc,
                    onTap: () async {
                      // getting time using time picker
                      final getTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (getTime != null) {
                        timeValue = getTime.format(context);
                        /*
                          adding an event to register the changed state of time widget
                          to emit the new state, formatted time value is passed to the event
                        */
                        timeBloc.add(
                          TimeValueChangeEvent(timeValue: timeValue),
                        );
                      }
                    },
                  )
                ],
              );
            },
          ),

          SBC.xxLH,
          // button section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(color: Theme.of(context).primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    // popping add todo screen from the screen stack.
                    Navigator.pop(context, true);
                  },
                  child: const Text('Cancel'),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    side: BorderSide(color: Colors.blue.shade900),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () async {
                    isPosted = await TodosRepo.addTodos(
                      TodoModel(
                        todoTitle: titleController.text,
                        description: descController.text,
                        category: radioBtnBloc.changedValue == 1
                            ? 'General'
                            : radioBtnBloc.changedValue == 2
                                ? 'Work'
                                : 'Learning',
                        date: dateValue,
                        time: timeValue,
                      ),
                    );

                    if (isPosted) {
                      // Routing to HomeScreen() after addition of new todo
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    } else if (isPosted ==  false) {
                      print('not posted');
                      // showing a snackbar informing the user that todo could not be posted
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Todo could not be posted.'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                  child: const Text('Create'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
