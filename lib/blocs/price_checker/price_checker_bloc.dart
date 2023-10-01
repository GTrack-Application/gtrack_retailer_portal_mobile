import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrack_retailer_portal/blocs/global/global_states_events.dart';

class PriceCheckerBloc extends Bloc<GlobalEvent, GlobalState> {
  PriceCheckerBloc() : super(GlobalInitState()) {
    on<GlobalInitEvent>((event, emit) async {
      emit(GlobalLoadingState());
      await Future.delayed(const Duration(seconds: 2), () {});
      emit(GlobalLoadedState(data: "data loaded successfully"));
    });
  }
}
