import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';

class ChatRequestListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Padding(padding: EdgeInsets.all(16),
    child:Column(  // Changed Row to Column
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hyper Exclusive requests",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Playfair',
                          fontWeight: FontWeight.w600,
                          fontSize: 24.0)                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("View all requests",
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w300,
                            fontSize: 18.0)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        padding: EdgeInsets.all(16),
                        minimumSize:
                        Size(double.infinity, 50)),

                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Exclusive requests",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Playfair',
                          fontWeight: FontWeight.w600,
                          fontSize: 24.0)                  ),
                  Expanded(child: Container()),
                  ElevatedButton(
                    onPressed: () {
                      CustomNavigationHelper.router.push(
                        CustomNavigationHelper.chatRequestPath,
                      );
                    },
                    child: Text("View all requests",
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            fontWeight: FontWeight.w300,
                            fontSize: 18.0)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      padding: EdgeInsets.all(16),
                        minimumSize:
                        Size(double.infinity, 50)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}