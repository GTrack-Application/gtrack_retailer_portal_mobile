import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/common/colors/app_colors.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/digital_link_widget.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/events_widget.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/widgets/gtin_information.dart';
import 'package:nb_utils/nb_utils.dart';

class PriceCheckerPortrait extends StatefulWidget {
  final String code, codeType;
  const PriceCheckerPortrait(
      {Key? key, required this.code, required this.codeType})
      : super(key: key);

  @override
  State<PriceCheckerPortrait> createState() => _PriceCheckerPortraitState();
}

class _PriceCheckerPortraitState extends State<PriceCheckerPortrait> {
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          title: const Text('Price Checker'),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
            GtinInformationWidget(gtin: gtin ?? "", codeType: codeType ?? ""),
            5.height,
            EventsWidget(gtin: gtin ?? "", codeType: codeType ?? ""),
            5.height,
            DigitalLinkScreen(gtin: gtin ?? "", codeType: codeType ?? ""),
          ],
        ),
      ),
    );
  }
}
