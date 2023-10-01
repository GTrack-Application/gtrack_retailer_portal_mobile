import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtrack_retailer_portal/blocs/global/global_states_events.dart';
import 'package:gtrack_retailer_portal/blocs/price_checker/price_checker_bloc.dart';
import 'package:gtrack_retailer_portal/common/colors/app_colors.dart';
import 'package:gtrack_retailer_portal/global/variables/global_variables.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/digital_link_widget.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/events_widget.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/gtin_information.dart';
import 'package:gtrack_retailer_portal/widgets/loading/loading_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceCheckerPortrait extends StatefulWidget {
  const PriceCheckerPortrait({Key? key}) : super(key: key);

  @override
  State<PriceCheckerPortrait> createState() => _PriceCheckerPortraitState();
}

class _PriceCheckerPortraitState extends State<PriceCheckerPortrait> {
  String? gtin;
  String? codeType;
  String? code;

  bool isLoading = false;
  PriceCheckerBloc priceCheckerBloc = PriceCheckerBloc();

  getDataByGtin(String value) {
    priceCheckerBloc = priceCheckerBloc..add(GlobalInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: const Text('Price Checker'),
        ),
      ),
      body: BlocBuilder<PriceCheckerBloc, GlobalState>(
        bloc: priceCheckerBloc,
        builder: (context, state) {
          if (state is GlobalLoadingState) {
            return const Center(child: LoadingWidget());
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextField(
                      controller: gtinController,
                      onSubmitted: getDataByGtin,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Enter GTIN',
                          fillColor: AppColors.darkGold.withOpacity(0.8)),
                    ),
                  ),
                  GtinInformationWidget(
                    gtin: gtinController.text.trim(),
                    codeType: codeType ?? "",
                    isLoading: isLoading,
                  ),
                  5.height,
                  EventsWidget(
                    gtin: gtinController.text.trim(),
                    codeType: codeType ?? "",
                    isLoading: isLoading,
                  ),
                  5.height,
                  DigitalLinkScreen(
                    gtin: gtinController.text.trim(),
                    codeType: codeType ?? "",
                    isLoading: isLoading,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
