import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../widgets/login/rounded_text_field.dart';
import '../../../../core/router/app_router.dart';

class InterestsUpdateScreen extends StatefulWidget {
  const InterestsUpdateScreen({super.key});

  @override
  _InterestsUpdateScreenState createState() => _InterestsUpdateScreenState();
}

class _InterestsUpdateScreenState extends State<InterestsUpdateScreen> {
  bool isButtonEnabled = true;
  List<ChipValues> weekendList = [
    ChipValues("Takeaway"),
    ChipValues("Outdoors"),
    ChipValues("Party"),
    ChipValues("Club hop"),
    ChipValues("Sleep in"),
    ChipValues("Cook"),
    ChipValues("Brunch"),
    ChipValues("Music"),
    ChipValues("Long Drive"),
    ChipValues("Fancy restaurants")
  ];

  List<ChipValues> petsList = [
    ChipValues("Dogs"),
    ChipValues("Cats"),
    ChipValues("Birds"),
    ChipValues("Fish"),
    ChipValues("Rabbits"),
    ChipValues("Turtle"),
  ];

  List<ChipValues> selfCareList = [
    ChipValues("Yoga"),
    ChipValues("Run"),
    ChipValues("Meditate"),
    ChipValues("Spa days"),
    ChipValues("Travel"),
    ChipValues("Gardening"),
    ChipValues("Cycling"),
    ChipValues("Journal"),
    ChipValues("Dance"),
    ChipValues("Photography"),
    ChipValues("Music"),
    ChipValues("Sing"),
  ];

  List<ChipValues> foodNDrinkList = [
    ChipValues("Chinese"),
    ChipValues("Thai"),
    ChipValues("Greek"),
    ChipValues("Korean"),
    ChipValues("Mexican"),
    ChipValues("Japanese"),
    ChipValues("Italian"),
    ChipValues("Vegan"),
  ];

  List<ChipValues> sportsList = [
    ChipValues("Pilates"),
    ChipValues("Gym"),
    ChipValues("Football"),
    ChipValues("Boxing"),
    ChipValues("Cricket"),
    ChipValues("Tennis"),
    ChipValues("Badminton"),
    ChipValues("Go kart"),
    ChipValues("Basketball"),
    ChipValues("Baseball"),
    ChipValues("Hockey"),
  ];

  List<String> weekendListString = [];
  List<String> petsListString = [];
  List<String> foodNDrinkListString = [];
  List<String> sportsListString = [];
  List<String> selfCareListString = [];
  int selectedLength = 0;


  @override
  void initState() {
    super.initState();
  }

  void updateSelectionState() {
    selectedLength = weekendListString.length
        + petsListString.length
        + foodNDrinkListString.length
        + sportsListString.length
        + selfCareListString.length;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(""),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: LinearProgressIndicator(
                          color: Colors.black,

                          value: 0.87, // Set the progress to 10%
                        )
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        textAlign: TextAlign.start,
                        '87%',
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
                  child: Text(
                    textAlign: TextAlign.start,
                    'Interests',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Select upto 8 things you love to do. They will be displayed on your profile.",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 24,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const Text(
                        "On Weekends you like to",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      ),
                      Wrap(
                        spacing: 8.0,
                        // Adjust spacing between chips as desired
                        children: weekendList
                            .map((label) => ActionChip(
                                side: const BorderSide(
                                    color: Colors.transparent),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                backgroundColor:
                                    label.isSelected ? Colors.black : Colors.grey[200],
                                labelStyle: TextStyle(
                                    color:
                                        label.isSelected ? Colors.white : Colors.black,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                                label: Text(label.val),
                            onPressed: () {
                              setState(() {
                                label.isSelected = !label.isSelected;
                                label.isSelected ? weekendListString.add(label.val):weekendListString.remove(label.val);
                                updateSelectionState();
                              });
                            }


                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 24,),
                      const Text(
                        "Pets",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      ),
                      Wrap(
                        spacing: 8.0,
                        // Adjust spacing between chips as desired
                        children: petsList
                            .map((label) => ActionChip(
                            side: const BorderSide(
                                color: Colors.transparent),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            backgroundColor:
                            label.isSelected ? Colors.black : Colors.grey[200],
                            labelStyle: TextStyle(
                                color:
                                label.isSelected ? Colors.white : Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0),
                            label: Text(label.val),
                            onPressed: () {
                              setState(() {
                                label.isSelected = !label.isSelected;
                                label.isSelected ? petsListString.add(label.val):petsListString.remove(label.val);
                                updateSelectionState();

                              });
                            }
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 24,),
                      const Text(
                        "Self-care",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      ),
                      Wrap(
                        spacing: 8.0,
                        // Adjust spacing between chips as desired
                        children: selfCareList
                            .map((label) => ActionChip(
                            side: const BorderSide(
                                color: Colors.transparent),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            backgroundColor:
                            label.isSelected ? Colors.black : Colors.grey[200],
                            labelStyle: TextStyle(
                                color:
                                label.isSelected ? Colors.white : Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0),
                            label: Text(label.val),
                            onPressed: () {
                              setState(() {
                                label.isSelected = !label.isSelected;
                                label.isSelected ? selfCareListString.add(label.val):selfCareListString.remove(label.val);
                                updateSelectionState();

                              });
                            }
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 24,),
                      const Text(
                        "Food & Drink",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      ),
                      Wrap(
                        spacing: 8.0,
                        // Adjust spacing between chips as desired
                        children: foodNDrinkList
                            .map((label) => ActionChip(
                            side: const BorderSide(
                                color: Colors.transparent),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            backgroundColor:
                            label.isSelected ? Colors.black : Colors.grey[200],
                            labelStyle: TextStyle(
                                color:
                                label.isSelected ? Colors.white : Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0),
                            label: Text(label.val),
                            onPressed: () {
                              setState(() {
                                label.isSelected = !label.isSelected;
                                label.isSelected ? foodNDrinkListString.add(label.val):foodNDrinkListString.remove(label.val);
                                updateSelectionState();

                              });
                            }
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 24,),
                      const Text(
                        "Sports",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.0),
                      ),
                      Wrap(
                        spacing: 8.0,
                        // Adjust spacing between chips as desired
                        children: sportsList
                            .map((label) => ActionChip(
                            side: const BorderSide(
                                color: Colors.transparent),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                            backgroundColor:
                            label.isSelected ? Colors.black : Colors.grey[200],
                            labelStyle: TextStyle(
                                color:
                                label.isSelected ? Colors.white : Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 14.0),
                            label: Text(label.val),
                            onPressed: () {
                              setState(() {
                                label.isSelected = !label.isSelected;
                                label.isSelected ? sportsListString.add(label.val):sportsListString.remove(label.val);
                                updateSelectionState();

                              });
                            }
                        ))
                            .toList(),
                      ),

                    ]),
                  ),
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 8),
                child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Selected",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0),
                    ),
                    Text(
                      "$selectedLength / 8",
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontFamily: 'lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0),
                    ),
                  ],
                ),),

                Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: isButtonEnabled
                        ? () {
                            CustomNavigationHelper.router.push(
                              CustomNavigationHelper.onboardingPronounPath,
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        disabledBackgroundColor: Colors.black.withOpacity(0.6),
                        disabledForegroundColor: Colors.white.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(2.0), // Rounded corners
                        ),
                        minimumSize:
                            const Size.fromHeight(48) // Set button text color
                        ),
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class ChipValues {
  final String val;
  bool isSelected = false;

  ChipValues(this.val);

  void setSelection(bool isSelected) {
    this.isSelected = isSelected;
  }
}
