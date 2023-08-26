part of 'datetime_bloc.dart';

// defining different events states of the date/ time widget.
@immutable
abstract class DatetimeEvent {}

class DateValueChangeEvent extends DatetimeEvent {
  final String dateValue;

  DateValueChangeEvent({required this.dateValue});
}

class TimeValueChangeEvent extends DatetimeEvent {
  final String timeValue;

  TimeValueChangeEvent({required this.timeValue});
}
