import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/logic/bloc/radio_button_bloc.dart';

class RadioWidget extends StatefulWidget {
  const RadioWidget({
    super.key,
    required this.radioTitle,
    required this.catColor,
    required this.value,
    required this.onChanged,
    required this.radioBloc,
  });

  final String radioTitle;
  final Color catColor;
  final int value;
  final VoidCallback onChanged;

  final RadioButtonBloc radioBloc;

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: widget.catColor),
      child: BlocBuilder<RadioButtonBloc, RadioButtonState>(
        bloc: widget.radioBloc,
        builder: (context, state) {
          if (state is RadioButtonInitial) {
            // Initial state of the radio button
            return RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Transform.translate(
                // managing the gap between the title and the radio button
                offset: const Offset(-22, 0),
                child: Text(
                  widget.radioTitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: widget.catColor,
                      ),
                ),
              ),
              value: widget.value,
              // the group will be 0 in initial state
              groupValue: 0,
              activeColor: widget.catColor,
              onChanged: (value) => widget.onChanged(),
            );
          }
          if (state is RadioButtonChangeState) {
            // Changed state of the radio button
            final changeState = state;
            return RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Transform.translate(
                // managing the gap between the title and the radio button
                offset: const Offset(-22, 0),
                child: Text(
                  widget.radioTitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: widget.catColor,
                      ),
                ),
              ),
              value: widget.value,
              // Group value will be the changedRadioValue passed to the state while emitting it
              groupValue: changeState.changedRadioValue,
              activeColor: widget.catColor,
              onChanged: (value) => widget.onChanged(),
            );
          }
          // returning sizedbox to avoid null returning error raised by if statement
          return SizedBox();
        },
      ),
    );
  }
}
