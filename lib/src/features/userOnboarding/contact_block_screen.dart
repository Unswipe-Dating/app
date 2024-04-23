import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuple/tuple.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This list stores the selected state of each item (initially all false)
  Map<int, bool> _selectedContact = Map();

  List<Contact> contact = [];
  List<Tuple2<String, String>> stringContacts = [];

  var status = Permission.contacts.status;

  _selectContact() async {
    if (await Permission.contacts.request().isGranted) {
      contact =
      await ContactsService.getContacts(withThumbnails: false);
      for (var element in contact) {
        String s1 = element.displayName??"";
        String s2 = "";
        element.phones?.forEach((element) {s2+= "\n ${element.label} : ${element.value}\n";});
        stringContacts.add(Tuple2(s1, s2));
      }
      _selectedContact = contact.asMap().map((key, value) => MapEntry(key, false));
      setState(() {
      });
    } else {
//todo: when user is never ready to give permission.
    }
  }

  @override
  void initState() {
    _selectContact();
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Block Contacts',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0)),
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.grey[700],),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.add, color: Colors.grey[700],),
                onPressed: () => print('Add button pressed'),
              ),
            ],
          ),
          body: contact.isEmpty ? const Center(child:CircularProgressIndicator()) : Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('You can choose to hide your profile visibility for the people in your contact list.',
                    style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0)),
              ),
              TabBar(
                tabAlignment: TabAlignment.center,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                isScrollable: true,
                padding: EdgeInsets.all(16),
                labelPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(32),
                ),
                tabs: const [
                  Tab(
                    text: "Your Contacts",
                  ),
                  Tab(
                    text: "Blocked Contacts",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ListView.builder(
                      itemCount: stringContacts.length,
                      itemBuilder: (context, index) {
                        return CheckboxListTile(
                          title: RichText(
                            text: TextSpan(
                                text: stringContacts[index].item1,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.0),
                                children: [
                                  TextSpan(
                                      text: stringContacts[index].item2,
                                      style: TextStyle(
                                          color: Colors.grey[800],
                                          fontFamily: 'Lato',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14))
                                ]),
                          ),
                          value: _selectedContact[index],
                          // Set checkbox value from state
                          onChanged: (val) =>
                          setState(() {
                            _selectedContact.update(index, (value) =>  val ?? false);
                          })
                               // Update state on change
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Item ${index + 1}'),
                          selected: true,
                          // Set selected based on state
                          onTap: () => {}, // Handle tap
                        );
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(32),
                child: ElevatedButton(
                  onPressed: () {



                  },
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
        ),
      ),
    );
  }
}
