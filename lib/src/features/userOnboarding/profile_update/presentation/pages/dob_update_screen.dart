import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/data/models/update_profile_response.dart';
import 'package:unswipe/src/features/userOnboarding/profile_update/domain/repository/update_profile_repository.dart';

import '../../../../../../widgets/login/rounded_text_field.dart';
import '../../../../../core/router/app_router.dart';




class DOBUpdateScreen extends StatefulWidget {
  final UpdateProfileParams? params;
  const DOBUpdateScreen({super.key, this.params});

  @override
  _DOBUpdateScreenState createState() => _DOBUpdateScreenState();
}

class _DOBUpdateScreenState extends State<DOBUpdateScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  bool isButtonEnabled = false;

  var request = [];


  @override
  void initState() {
    super.initState();
    dateController.addListener(validateFields);
    monthController.addListener(validateFields);
    yearController.addListener(validateFields);
  }

  void validateFields() {
    // Enable or disable the button based on the validation status
    setState(() {
      isButtonEnabled = isValidDate(dateController.text)
          && isValidMonth(monthController.text)
          && isValidYear(yearController.text);
    });
  }

  bool isValidDate(String text) {
    if (text.isEmpty) return false;
    int val = int.parse(text);
    return val > 0 && val <= 31;
  }

  bool isValidMonth(text) {
    if (text.isEmpty) return false;

    int val = int.parse(text);
    return val > 0 && val <= 12;
  }

  bool isValidYear(text) {
    if (text.isEmpty) return false;
    int val = int.parse(text);
    return val > 1950 && val <= 2024;
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text(""),),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: LinearProgressIndicator(
                          color: Colors.black,

                          value: 0.35, // Set the progress to 10%
                        )
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        textAlign: TextAlign.start,
                        '35%',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(alignment: Alignment.topLeft,
                    child: Text(
                    textAlign: TextAlign.start,
                    'You were born on',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "We display only your age to potential matches.",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RoundedTextInput(
                          titleText: '',
                          hintText: '01',
                          controller: dateController,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: RoundedTextInput(
                          titleText: '',
                          hintText: '01',
                          controller: monthController,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: RoundedTextInput(
                          titleText: '',
                          hintText: '1990',
                          controller: yearController,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: CustomButton(
                    onPressed: () {
                      widget.params?.dob = getDOB(yearController.text,
                          monthController.text,
                          dateController.text
                      );

                      CustomNavigationHelper.router.push(
                        CustomNavigationHelper.onboardingGenderPath,
                          extra: UpdateProfileParams.getUpdatedParams(widget.params)
                      );


                    },
                    text: 'Next',
                    isEnabled: isButtonEnabled,
                  ),
                ),
              ],
            )
            ,)
    );
  }

  String? getDOB(String yearText, String monthText, String dateText) {

    return "$yearText-$monthText-$dateText";
  }


}
