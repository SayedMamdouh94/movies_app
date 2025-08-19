import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCubit<T> extends Cubit<T> {
  CustomCubit(super.initialState);

  void emitState(T state) {
    if (!isClosed) emit(state);
  }
}
