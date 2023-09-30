import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrack_retailer_portal/blocs/global/global_states_events.dart';
import 'package:gtrack_retailer_portal/controller/Identity/GTIN/gtin_controller.dart';
import 'package:gtrack_retailer_portal/models/IDENTIFY/gtin_model.dart';
import 'package:nb_utils/nb_utils.dart';

class GtinBloc extends Bloc<GlobalEvent, GlobalState> {
  GtinBloc() : super(GlobalInitState()) {
    on<GlobalInitEvent>((event, emit) async {
      emit(GlobalLoadingState());
      try {
        bool networkStatus = await isNetworkAvailable();
        if (!networkStatus) {
          emit(GlobalErrorState(message: 'No internet connection'));
        } else {
          GTINModel data = await GTINController.getProducts();
          emit(GlobalLoadedState(data: data));
        }
      } catch (error) {
        emit(GlobalErrorState(message: error.toString()));
      }
    });
  }
}
