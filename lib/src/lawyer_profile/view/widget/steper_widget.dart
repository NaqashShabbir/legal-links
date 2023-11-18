import 'package:flutter/material.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SteperWidget extends StatelessWidget {
  var currentStep;
  SteperWidget({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: 4,
      currentStep: currentStep,
      selectedColor: R.colors.primary,
      unselectedColor: R.colors.grey,
    );
  }
}
