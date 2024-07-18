import 'package:flutter/material.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';

class FullscreenSwipeDialog extends StatefulWidget {
  final VoidCallback onButtonPressed;

  const FullscreenSwipeDialog({super.key, required this.onButtonPressed});

  @override
  State<FullscreenSwipeDialog> createState() => _FullscreenSwipeDialogState();
}

class _FullscreenSwipeDialogState extends State<FullscreenSwipeDialog> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  List<String> dos = [
    "1. A head shot works great for display picture.",
    "2. Include at least one full length body shot.",
    "3. Add a picture of you doing something you love.",
    "4. Wear colourful outfits to catch attention."
  ];
  List<String> donts = [
    "1. Avoid group photos at all costs.",
    "2. Avoid selfies, photos with filters, mirror selfies.",
    "3. Poor image quality.",
    "4. Don’t have messy backgrounds that draw attention away from you.",
    "5. No nudity or obscene images."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5), // Optional background
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.width *1.2,

          width: MediaQuery.of(context).size.width * 0.8,
          // Adjust as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "The Dos",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Playfair',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dos[0],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dos[1],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dos[2],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                dos[3],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "The Donts",
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Playfair',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24.0),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                donts[0],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                donts[1],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                donts[2],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                donts[3],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.all(8),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                donts[4],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'lato',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.0),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  2, // Replace with total number of pages
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              CustomButton(
                onPressed: () {
                  widget.onButtonPressed();
                  Navigator.of(context).pop(true);
                },
                text: 'Got it',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
