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

class PriceCheckerScreen extends StatefulWidget {
  const PriceCheckerScreen({Key? key}) : super(key: key);

  @override
  State<PriceCheckerScreen> createState() => _PriceCheckerScreenState();
}

class _PriceCheckerScreenState extends State<PriceCheckerScreen> {
  String? gtin;
  String? codeType;
  String? code;

  bool isLoading = false;
  PriceCheckerBloc priceCheckerBloc = PriceCheckerBloc();

  getDataByGtin(String value) {
    // AppDialogs.loadingDialog(context);
    priceCheckerBloc = priceCheckerBloc..add(GlobalInitEvent());
    // setState(() {
    //   Future.delayed(const Duration(seconds: 2), () {
    //     isLoading = true;
    //   }).then((value) {
    //     setState(() {
    //       isLoading = true;
    //     });
    //   });
    //   // AppDialogs.closeDialog();
    // });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Checker'),
      ),
      body: BlocConsumer<PriceCheckerBloc, GlobalState>(
        bloc: priceCheckerBloc,
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GlobalLoadingState) {
            return const Center(child: LoadingWidget());
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: context.height(),
                        width: context.width() * 0.6,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: TextField(
                                controller: gtinController,
                                onSubmitted: getDataByGtin,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    labelText: 'Enter GTIN',
                                    fillColor:
                                        AppColors.darkGold.withOpacity(0.8)),
                              ),
                            ),
                            GtinInformationWidget(
                              gtin: gtinController.text.trim(),
                              codeType: codeType ?? '',
                              isLoading: true,
                            ),
                            EventsWidget(
                              gtin: gtinController.text.trim(),
                              codeType: codeType ?? '',
                              isLoading: isLoading,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: context.height(),
                        width: context.width() * 0.4,
                        child: Column(
                          children: [
                            DigitalLinkScreen(
                              gtin: gtinController.text.trim(),
                              codeType: codeType ?? '',
                              isLoading: isLoading,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
