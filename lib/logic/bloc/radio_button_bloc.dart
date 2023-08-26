import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_bloc/data/models/todo_color_cat.dart';

part 'radio_button_event.dart';
part 'radio_button_state.dart';

class RadioButtonBloc extends Bloc<RadioButtonEvent, RadioButtonState> {
  int changedValue = 1;
  RadioButtonBloc() : super(RadioButtonInitial()) {
    TodoColorModel color = TodoColorModel(colorCode: 0);
    // for the change event in radio button widget
    on<RadioButtonClickedEvent>((event, emit) {
      changedValue = event.radioValue;
      color.colorCode = changedValue;
      // radio button change state is emitted with new radio button value
      emit(RadioButtonChangeState(changedRadioValue: color.colorCode));
    });
  }
}
