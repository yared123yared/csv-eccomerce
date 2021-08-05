import 'package:app/Widget/clients/Common/step_button.dart';
import 'package:flutter/material.dart';

class StepCreateClient extends StatelessWidget {
  final List<Step> steps;
  final int currentStep;
  final Function onStepTapped;
  final Function onStepContinue;

  StepCreateClient({
    required this.steps,
    required this.currentStep,
    required this.onStepTapped,
    required this.onStepContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Stepper(
      controlsBuilder: (BuildContext context,
          {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
        return StepperButton(
          onPressed: ()=>onStepContinue,
          title: this.currentStep < 2 ? 'Next' : 'Save',
        );
      },
      steps: steps,
      physics: ScrollPhysics(),
    
      type: StepperType.horizontal,
      currentStep: this.currentStep,
      onStepContinue: this.onStepContinue(),
      onStepTapped: (val) => this.onStepTapped(val),
    );
  }
}
