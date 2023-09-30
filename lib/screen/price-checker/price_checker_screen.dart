import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/events_widget.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/gtin_information.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceCheckerScreen extends StatefulWidget {
  const PriceCheckerScreen({Key? key}) : super(key: key);

  @override
  State<PriceCheckerScreen> createState() => _PriceCheckerScreenState();
}

class _PriceCheckerScreenState extends State<PriceCheckerScreen> {
  String gtin = "6281000000113";
  String codeType = "1D";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Price Checker')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: context.height(),
                  width: context.width() * 0.6,
                  child: Column(
                    children: [
                      GtinInformationWidget(gtin: gtin, codeType: codeType),
                      20.height,
                      EventsWidget(gtin: gtin, codeType: codeType),
                    ],
                  ),
                ),
                Container(
                  height: context.height(),
                  width: context.width() * 0.4,
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
