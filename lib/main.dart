import 'package:flutter/material.dart';
import 'package:gtrack_retailer_portal/common/colors/app_colors.dart';
import 'package:gtrack_retailer_portal/screen/price-checker/price_checker_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gtrack Retailer Port',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const PriceCheckerScreen(),
    );
  }
}
