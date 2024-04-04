import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoRequestIndividualScreen extends StatelessWidget {
  const NoRequestIndividualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/fingers_crossed.svg"),
            SizedBox(height: 20,),
            Text("Fingers Crossed",
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w700,
                    fontSize: 24.0)),
            SizedBox(height: 8,),
            Center(child:Text("You will be able to chat with A once they accept your request.",
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'lato',
                    fontWeight: FontWeight.w700,
                    fontSize: 18.0))
            ),
          ],
        ),
      );
  }
}