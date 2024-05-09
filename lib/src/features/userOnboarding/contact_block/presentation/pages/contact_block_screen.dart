import 'dart:collection';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuple/tuple.dart';
import 'package:unswipe/src/features/onBoarding/domain/usecases/update_onboarding_state_stream_usecase.dart';
import 'package:unswipe/src/features/onBoarding/presentation/bloc/onboarding_bloc.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/repository/contact_block_repository.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/domain/usecase/contact_bloc_usecase.dart';
import 'package:unswipe/src/features/userOnboarding/contact_block/presentation/bloc/contact_block_state.dart';
import 'package:unswipe/src/shared/domain/usecases/get_auth_state_stream_use_case.dart';

import '../../../../../core/router/app_router.dart';
import '../bloc/contact_bloc.dart';

class BlockContactScreen extends StatefulWidget {
  @override
  _BlockContactState createState() => _BlockContactState();
}

class _BlockContactState extends State<BlockContactScreen> {
  // This list stores the selected state of each item (initially all false)
  Map<int, bool> _selectedContact = HashMap();

  List<Contact> contact = [];
  List<Tuple2<String, String>> stringContacts = [];

  var status = Permission.contacts.status;

  _selectContact() async {
    if (await Permission.contacts.request().isGranted) {
      contact = await ContactsService.getContacts(withThumbnails: false);
      for (var element in contact) {
        String s1 = element.displayName ?? "";
        String s2 = "";
        element.phones?.forEach((element) {
          s2 += "\n ${element.label} : ${element.value}\n";
        });
        stringContacts.add(Tuple2(s1, s2));
      }
      _selectedContact =
          contact.asMap().map((key, value) => MapEntry(key, false));
      setState(() {});
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
            title: const Text('Block Contacts',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Playfair',
                    fontWeight: FontWeight.w700,
                    fontSize: 22.0)),
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.grey[700],
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.grey[700],
                ),
                onPressed: () => print('Add button pressed'),
              ),
            ],
          ),
          body: BlocProvider(
            create: (BuildContext context) => ContactBloc(
                updateOnboardingStateStreamUseCase:
                    GetIt.I.get<UpdateOnboardingStateStreamUseCase>(),
                updateBlockedContactsUseCase: GetIt.I.get<ContactBlockUseCase>(),
              getAuthStateStreamUseCase: GetIt.I.get<GetAuthStateStreamUseCase>()
            ),
            child: BlocConsumer<ContactBloc, ContactBlockState>(
              listener: (context, state) {
                if (state.status == ContactBlockStatus.loaded) {
                  CustomNavigationHelper.router.push(
                    CustomNavigationHelper.uploadImagePath,
                  );
                }
              },
              builder: (context, state) {
                return contact.isEmpty || state.status == OnBoardStatus.loading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                                'You can choose to hide your profile visibility for the people in your contact list.',
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
                            padding: const EdgeInsets.all(16),
                            labelPadding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 4),
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
                                                    text: stringContacts[index]
                                                        .item2,
                                                    style: TextStyle(
                                                        color: Colors.grey[800],
                                                        fontFamily: 'Lato',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14))
                                              ]),
                                        ),
                                        value: _selectedContact[index],
                                        // Set checkbox value from state
                                        onChanged: (val) => setState(() {
                                              _selectedContact.update(index,
                                                  (value) => val ?? false);
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
                                      onTap: () => {

                                      }, // Handle tap
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(32),
                            child: ElevatedButton(
                              onPressed: () {
                                context.read<ContactBloc>()
                                    .add(OnContactBlockRequested(
                                    BlockContactDataParams(phones: getContactList())
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  disabledBackgroundColor:
                                      Colors.black.withOpacity(0.6),
                                  disabledForegroundColor:
                                      Colors.white.withOpacity(0.6),
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
                      );
              },
            ),
          ),
        ),
      ),
    );
  }

 List<String> getContactList() {

    List<String> newList = [];
    _selectedContact.forEach((key, value) {
      if(value) {
        contact[key].phones?.forEach((element) {
          if( element.value != null) newList.add(element.value!); });
      }
    });
    return newList;

 }
}
