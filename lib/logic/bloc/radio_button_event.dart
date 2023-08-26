part of 'radio_button_bloc.dart';


// defining event  of the radio button widget.
@immutable
abstract class RadioButtonEvent {}

class RadioButtonClickedEvent extends RadioButtonEvent {
  final int radioValue;

  RadioButtonClickedEvent({required this.radioValue});
}
