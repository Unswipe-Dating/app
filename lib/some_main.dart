import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ContactSelector(),
      ),
    );
  }
}

class ContactSelector extends StatefulWidget {
  const ContactSelector({super.key});

  @override
  _ContactSelectorState createState() => _ContactSelectorState();
}

class _ContactSelectorState extends State<ContactSelector> {
  var status = Permission.contacts.status;

  List<Contact> _selectedContact = [];
  late bool _isTrue;

  @override
  void initState() {
    _readJson();
    super.initState();

  }

  _selectContact() async {
    if (await Permission.contacts.request().isGranted) {
      List<Contact> contact =
      await ContactsService.getContacts(withThumbnails: false);
      setState(() {
        _selectedContact = contact ;
      });
    //  _saveContactToFile(_selectedContact);
    } else {
      _promptMessage();
    }
  }

  _saveContactToFile(Contact contact) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/selected_contact.txt');
    if (!(await file.exists())) {
      file.create();
    }
    file.writeAsString(jsonEncode(contact.toMap()));
  }

  _readJson() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/true.json');
    if (!(await file.exists())) {
      file.createSync();
      file.writeAsStringSync('{"isTrue":true}');
    }
    final content = jsonDecode(await file.readAsString());
    setState(() {
      _isTrue = content['isTrue'];
    });
  }

  _promptMessage() {
    if (_isTrue) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Select a message'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  InkWell(
                      child: const Text('How are you?'),
                      onTap: () {
                        _sendMessage('How are you?');
                        Navigator.of(context).pop();
                      }),
                  InkWell(
                      child: const Text('Did you have your lunch ?'),
                      onTap: () {
                        _sendMessage('Did you have your lunch ?');
                        Navigator.of(context).pop();
                      }),
                  InkWell(
                      child: const Text("What's for dinner?"),
                      onTap: () {
                        _sendMessage("What's for dinner?");
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  _sendMessage(String message) async {
   // String phoneNumber = _selectedContact[0].phones.toString();
    Uri uri = Uri(
      scheme: 'sms',
      path: "phoneNumber",
      query: encodeQueryParameters(<String, String>{
        'body': 'Welcome to pAM',
      }),
    );

    if (await canLaunchUrl(uri)) {
      await canLaunchUrl(uri);
    } else {
      throw 'Could not send SMS';
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
                _selectContact();
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