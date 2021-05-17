import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'adafruit_state.dart';

class AdafruitCubit extends Cubit<AdafruitState> {
  AdafruitCubit() : super(AdafruitInitial());
}
