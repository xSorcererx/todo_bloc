import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'datetime_event.dart';
part 'datetime_state.dart';

class DatetimeBloc extends Bloc<DatetimeEvent, DatetimeState> {
  DatetimeBloc() : super(DatetimeInitial()) {
    // for the change event in date widget
    on<DateValueChangeEvent>((event, emit) {
      var changedValue = event.dateValue;
      // date change state is emitted with changed date value
      emit(DateChangeState(changedDate: changedValue));
    });

    // for the change event in time widget
    on<TimeValueChangeEvent>((event, emit) {
      var changedValue = event.timeValue;
      // time change state is emitted with changed time value
      emit(TimeChangeState(changedTime: changedValue));
    });
  }
}