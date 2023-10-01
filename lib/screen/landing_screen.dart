import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/price_checker_portrait.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/price_checker_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    // if screen is portrait
    if (context.isPortrait) {
      return PriceCheckerPortrait();
    } else {
      // if screen is landscape
      return PriceCheckerScreen();
    }
  }
}
