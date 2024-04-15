import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../../../main.dart';
import '../../../core/helper/helper.dart';
import '../../../core/translations/l10n.dart';
import '../../../core/utils/injections.dart';
import '../../data/data_sources/app_shared_prefs.dart';
import '../../utils/language_enum.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  LanguageEnum selectedLanguage = Helper.getLang();

  @override
  void initState() {
    selectedLanguage = Helper.getLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: kToolbarHeight,
          ),

          // Language
          Text(
            S.of(context).language,
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          // Arabic language
          Theme(
            data: ThemeData(
                unselectedWidgetColor: Theme.of(context).iconTheme.color),
            child: RadioListTile(
              activeColor: selectedLanguage != LanguageEnum.ar
                  ? Theme.of(context).iconTheme.color
                  : Theme.of(context).cardColor,
              contentPadding: EdgeInsets.zero,
              title: Text(
                S.of(context).arabic,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              value: LanguageEnum.values[0],
              groupValue: selectedLanguage,
              onChanged: (value) {
                selectedLanguage = value!;
                setState(() {
                  App.setLocale(context, selectedLanguage);
                });
              },
            ),
          ),

          // English language
          Theme(
            data: ThemeData(
                unselectedWidgetColor: Theme.of(context).iconTheme.color),
            child: RadioListTile(
              activeColor: selectedLanguage != LanguageEnum.en
                  ? Theme.of(context).iconTheme.color
                  : Theme.of(context).cardColor,
              contentPadding: EdgeInsets.zero,
              title: Text(
                S.of(context).english,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              value: LanguageEnum.values[1],
              groupValue: selectedLanguage,
              onChanged: (value) {
                selectedLanguage = value!;
                setState(() {
                  App.setLocale(context, selectedLanguage);
                });
              },
            ),
          ),

          // Theme
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Helper.isDarkTheme()
                    ? S.of(context).dark_skin
                    : S.of(context).light_skin,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Switch(
                activeColor: Theme.of(context).cardColor,
                value: Helper.isDarkTheme(),
                onChanged: (value) {
                  if (value) {
                    // Dark
                   // GetIt.I.get<AppSharedPrefs>().setDarkTheme(true);
                  } else {
                    // Light
                  //  GetIt.I.get<AppSharedPrefs>().setDarkTheme(false);
                  }
                  // Provider.of<AppNotifier>(context, listen: false)
                  //     .updateThemeTitle(GetIt.I.get<AppSharedPrefs>().getIsDarkTheme());
                  // setState(() {});
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
