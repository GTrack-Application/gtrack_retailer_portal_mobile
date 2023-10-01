import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/price_checker_portrait.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/price_checker_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class LandingScreen extends StatefulWidget {
  final String code, codeType;
  const LandingScreen({Key? key, required this.code, required this.codeType})
      : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    // if screen is portrait
    if (context.isPortrait) {
      return PriceCheckerPortrait(
        code: widget.code,
        codeType: widget.codeType,
      );
    } else {
      // if screen is landscape
      return PriceCheckerScreen(
        code: widget.code,
        codeType: widget.codeType,
      );
    }
  }
}
