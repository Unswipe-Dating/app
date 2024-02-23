import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SwipeCard extends StatelessWidget {
  final String id;
  final String userName;
  final int userAge;
  final String userDescription;
  final String profileImageSrc;
  final bool isVerified;
  final String pronouns;

  const SwipeCard({
    Key? key,
    required this.id,
    required this.userName,
    required this.userAge,
    required this.userDescription,
    required this.profileImageSrc,
    required this.isVerified,
    required this.pronouns,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              height: MediaQuery.of(context).size.height * 0.6,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                      text: "${userName.characters.first} , ",
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Playfair',
                          fontWeight: FontWeight.w500,
                          fontSize: 24.0),
                      children: [
                        TextSpan(
                            text: userAge.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w500,
                                fontSize: 18))
                      ]),
                ),
                const SizedBox(
                  width: 16,
                ),
                Icon(
                  Icons.verified,
                  color: isVerified ? Colors.green : Colors.grey,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    pronouns,
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                SvgPicture.asset("assets/images/fab.svg"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
