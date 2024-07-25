import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../login/presentation/pages/Login.dart';
import '../../domain/repository/user_settings_repository.dart';

class LanguageListScreen extends StatefulWidget {
  final SettingProfileParams params;

  const LanguageListScreen({
    super.key,
    required this.params
  });

  @override
  State<LanguageListScreen> createState() => _LanguageListScreenState();
}

class _LanguageListScreenState extends State<LanguageListScreen> {
  final List<String> _allLanguages = [
    "Arabic",
    "Bengali",
    "English",
    "French",
    "German",
    "Hindi",
    "Indonesian",
    "Italian",
    "Japanese",
    "Korean",
     "Chinese",
    "Portuguese",
    "Russian",
    "Spanish",
    "Telugu",
    "Turkish",
    "Urdu",
    "Vietnamese",
  ];
  List<String> _filteredLanguages = [];
  Map<String, bool> _selectedLanguages = HashMap();

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredLanguages = _allLanguages;
    _selectedLanguages =
        _filteredLanguages.asMap().map((key, value) => MapEntry(_filteredLanguages[key], false));
    if(widget.params.profileParams?.languages?.isNotEmpty == true) {
      for(var item in widget.params.profileParams!.languages!) {
        _selectedLanguages.update(item, (value)=>true);
      }
    }


  }

  void _filterLanguages(String query) {
    setState(() {
      _filteredLanguages = _allLanguages.where((language) =>
          language.toLowerCase().contains(query.toLowerCase())).toList();

    });
  }

  @override
  Widget build(BuildContext mContext) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 4.0,
        title: const Text(
          "Language",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Playfair',
              fontWeight: FontWeight.w600,
              fontSize: 24.0),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: Colors.black, width: 3),
                color: Colors.grey[200],
              ),
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterLanguages,
                style: const TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
                decoration: const InputDecoration(
                    hintText: 'Search for a language',
                    hintStyle: TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    border: InputBorder.none),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredLanguages.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    title: Text(
                      _filteredLanguages[index],
                      style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0),

                    ),
                    value: _selectedLanguages[_filteredLanguages[index]] ?? false,
                    // Set checkbox value from state
                    onChanged: (val) => setState(() {
                      _selectedLanguages.update(_filteredLanguages[index],
                              (value) => val ?? false);
                    })
                  // Update state on change
                );
              },
            ),

          ),

          Padding(
            padding: const EdgeInsets.all(0),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CustomButton(
                onPressed: () {
                  Navigator.pop(mContext, getSelectedList(_selectedLanguages.entries));
                },
                text: 'Next',
                isEnabled: true,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<String> getSelectedList(Iterable<MapEntry<String, bool>> keys) {
    List<String> items = [];
    for(var key in keys) {
      if(key.value) {
        items.add(key.key);
      }
    }
    return items;
  }
}
