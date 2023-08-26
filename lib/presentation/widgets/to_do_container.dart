// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:todo_bloc/data/repos/todo_repo.dart';
import 'package:todo_bloc/logic/bloc/todo_bloc.dart';

// To do container
class ToDoContainer extends StatefulWidget {
  const ToDoContainer({
    Key? key,
    required this.bloc,
    required this.docId,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.cat,
  }) : super(key: key);

  final TodoBloc bloc;
  final int docId;
  final String title;
  final String description;
  final String date;
  final String time;
  final String cat;

  @override
  State<ToDoContainer> createState() => _ToDoContainerState();
}

class _ToDoContainerState extends State<ToDoContainer> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // to do color
          Container(
            width: MediaQuery.of(context).size.width * 0.05,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              // the color should be different based on the category of to do
              color: widget.cat == 'Work'
                  ? Colors.blue.shade700
                  : widget.cat == 'Learning'
                      ? Colors.green.shade700
                      : Colors.yellow.shade700,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.82,
            margin: const EdgeInsets.only(left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  // to do title
                  title: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 20,
                          fontFamily: GoogleFonts.notoSans().fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  // to do description
                  subtitle: Text(
                    widget.description, // formatted date.
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 15,
                          fontFamily: GoogleFonts.notoSans().fontFamily,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                  ),
                  // checkbox to mark it done
                  trailing: Transform.scale(
                    scale: 1,
                    child: Checkbox(
                      shape: const CircleBorder(),
                      activeColor: Theme.of(context).primaryColor,
                      value: isChecked,
                      onChanged: (newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                        // deleting the to do when the checkbox is clicked
                        TodosRepo.deleteTodos(widget.docId);
                        /* 
                          adding the initial fetch event again so that 
                          the todos is fetched again after deletion
                        */
                        widget.bloc.add(TodoInitialFetchEvent());
                      },
                    ),
                  ),
                ),
                const Divider(
                  thickness: 0.9,
                ),
                // time period
                Text(
                  '${widget.date} ${widget.time}', // formatted date.
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 15,
                        fontFamily: GoogleFonts.notoSans().fontFamily,
                        fontWeight: FontWeight.w300,
                        color: const Color.fromARGB(255, 98, 98, 98),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
