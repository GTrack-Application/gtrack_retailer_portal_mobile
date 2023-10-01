import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/common/colors/app_colors.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/digital_link_widget.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/events_widget.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/gtin_information.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceCheckerScreen extends StatefulWidget {
  final String code, codeType;
  const PriceCheckerScreen(
      {Key? key, required this.code, required this.codeType})
      : super(key: key);

  @override
  State<PriceCheckerScreen> createState() => _PriceCheckerScreenState();
}

class _PriceCheckerScreenState extends State<PriceCheckerScreen> {
  String? gtin;
  String? codeType;
  String? code;

  @override
  void initState() {
    codeType = widget.codeType;
    code = widget.code;
    if (codeType == "1D") {
      gtin = widget.code;
    } else {
      gtin = widget.code.substring(1, 14);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price Checker'),
      ),
      body: SingleChildScrollView(
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
                      Container(
                        width: context.width(),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.darkGold.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          gtin ?? "",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      GtinInformationWidget(
                          gtin: gtin ?? '', codeType: codeType ?? ''),
                      EventsWidget(gtin: gtin ?? '', codeType: codeType ?? ''),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.height(),
                  width: context.width() * 0.4,
                  child: Column(
                    children: [
                      DigitalLinkScreen(
                        gtin: gtin ?? '',
                        codeType: codeType ?? '',
                      ),
                    ],
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
