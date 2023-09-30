import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/gtin_information.dart';

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
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GtinInformationWidget(gtin: gtin, codeType: codeType),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
