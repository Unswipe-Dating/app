import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';

class ChatRequestListPage extends StatelessWidget {
  const ChatRequestListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        // Changed Row to Column
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
                    Expanded(child: StackAndText(headerText: "Hyper Exclusive requests", text: "12 requests",),),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("View all requests",
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w300,
                              fontSize: 18.0)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          padding: EdgeInsets.all(16),
                          minimumSize: Size(double.infinity, 50)),
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
                    Expanded(child: StackAndText(headerText: "Exclusive requests", text: "12 requests",),),
                    ElevatedButton(
                      onPressed: () {
                        CustomNavigationHelper.router.push(
                          CustomNavigationHelper.chatRequestPath,
                        );
                      },
                      child: Text("View all requests",
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w300,
                              fontSize: 18.0)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          padding: EdgeInsets.all(16),
                          minimumSize: Size(double.infinity, 50)),
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


class StackAndText extends StatelessWidget {
  final String text; // Text to be displayed
  final double spacing;
  final String headerText;// Spacing between Stack and Text

  const StackAndText({
    Key? key,
    required this.text,
    required this.headerText,
    this.spacing = 10.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(headerText,
            style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Playfair',
                fontWeight: FontWeight.w600,
                fontSize: 24.0)),
        SizedBox(height: 16,),
        AvatarStack(),
        SizedBox(height: 8),
        Text(text),
      ],
    );
  }
}

class AvatarStack extends StatefulWidget {
  const AvatarStack({Key? key}) : super(key: key);

  @override
  State<AvatarStack> createState() => _AvatarStackState();
}

class _AvatarStackState extends State<AvatarStack> {
  // list containing URL links of images
  // that will directly access from internet
  List RandomImages = [
    'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg',
    'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80',
    'https://i0.wp.com/post.medicalnewstoday.com/wp-content/uploads/sites/3/2020/03/GettyImages-1092658864_hero-1024x575.jpg?w=1155&h=1528'
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < RandomImages.length; i++)
                  Align(
                    widthFactor: 0.5,
                    // parent circle avatar.
                    // We defined this for better UI
                      child: CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(RandomImages[i]),
                      ),
                    ),
              ],
            ));
  }
}
