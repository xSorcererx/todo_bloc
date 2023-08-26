// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'radio_button_bloc.dart';

// defining different states  of the radio button widget.
@immutable
abstract class RadioButtonState {}

class RadioButtonInitial extends RadioButtonState {}

class RadioButtonChangeState extends RadioButtonState {
  final int changedRadioValue;
  
  RadioButtonChangeState({
    required this.changedRadioValue,
  });
}
