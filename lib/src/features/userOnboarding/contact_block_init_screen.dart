import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert';


class BlockContactInitPage extends StatefulWidget {
  const BlockContactInitPage({super.key});

  @override
  _BlockContactInitPageState createState() => _BlockContactInitPageState();
}

class _BlockContactInitPageState extends State<BlockContactInitPage> {
  var status = Permission.contacts.status;

  _selectContact() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> contact =
      await ContactsService.getContacts(withThumbnails: false);
      setState(() {
      });
    } else {
//todo: when user is never ready to give permission.
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/permission_bg.png',
            ),
            fit: BoxFit.fill,
          )),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              // Center content
              children: [
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                  child:
                  SvgPicture.asset('assets/images/permission_icon.svg'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Avoiding certain people?',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Playfair',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0),
                  ),
                ),
                const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  child: Text(
                    'You get to decide who amongst your contacts can discover your profile.',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(32),
            child: ElevatedButton(
              onPressed: () {
                _selectContact;
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  // Set button background color
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        2.0), // Rounded corners
                  ),
                  minimumSize: const Size.fromHeight(
                      48) // Set button text color
              ),
              child: const Text(
                'Import Contacts',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0),
              ),
            ),
          )

        ],
      ),
    );
  }
}