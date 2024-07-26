import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoRequestScreen extends StatelessWidget {
  const NoRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 2/3,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/images/fingers_crossed.svg"),
              SizedBox(
                height: 20,
              ),
              Text("None at the moment",
                  style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Playfair',
                      fontWeight: FontWeight.w700,
                      fontSize: 24.0)),
              SizedBox(
                height: 8,
              ),
              Center(
                  child: Text(
                    textAlign: TextAlign.center,
                      "We will notify you as soon as you receive a request",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 18.0))),
            ],
          ),
        ));
  }
}
