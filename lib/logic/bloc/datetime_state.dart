// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'datetime_bloc.dart';

// defining different states states of the date/ time widget.
@immutable
abstract class DatetimeState {}

class DatetimeInitial extends DatetimeState {}

class DateChangeState extends DatetimeState {
  final String changedDate;
  
  DateChangeState({
    required this.changedDate,
  });
}


class TimeChangeState extends DatetimeState {
  final String changedTime;
  
  TimeChangeState({
    required this.changedTime,
  });
}

