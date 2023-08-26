import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/logic/bloc/datetime_bloc.dart';
import 'package:todo_bloc/presentation/utils/size_constants.dart';

class DateTimeWidget extends StatefulWidget {
  const DateTimeWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
    required this.datetimeBloc,
  });

  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  final DatetimeBloc datetimeBloc;

  @override
  State<DateTimeWidget> createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
          ),
          SBC.lH,

          // Date/ time picker container
          Material(
            child: Ink(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: widget.onTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: BlocBuilder<DatetimeBloc, DatetimeState>(
                    bloc: widget.datetimeBloc,
                    builder: (context, state) {
                      if (state is DatetimeInitial) {
                        // Initial state of the container
                        return Row(
                          children: [
                            Icon(widget.icon),
                            SBC.lW,
                            Text(widget.value),
                          ],
                        );
                      }
                      if (state is DateChangeState) {
                        // Changed state when the date is changed
                        final dateChangeState = state;
                        return Row(
                          children: [
                            Icon(widget.icon),
                            SBC.lW,
                            Text(dateChangeState.changedDate),
                          ],
                        );
                      }
                      if (state is TimeChangeState) {
                        // Changed state when the time is changed
                        final timeChangeState = state;
                        return Row(
                          children: [
                            Icon(widget.icon),
                            SBC.lW,
                            Text(timeChangeState.changedTime),
                          ],
                        );
                      }
                      // returning sizedbox to avoid null returning error raised by if statement
                      return SizedBox();
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
