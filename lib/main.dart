import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unswipe/src/features/login/presentation/pages/Login.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unswipe/src/core/router/app_router.dart';
import 'package:unswipe/src/core/styles/app_theme.dart';
import 'package:unswipe/src/core/translations/l10n.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unswipe/src/core/helper/helper.dart';
import 'package:unswipe/src/core/utils/injections.dart';
import 'package:unswipe/src/shared/data/data_sources/app_shared_prefs.dart';
import 'package:unswipe/src/shared/utils/language_enum.dart';

import 'data/auth_repository.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inject all dependencies
  await initInjections();

  CustomNavigationHelper.instance;

  runApp(DevicePreview(
    builder: (context) {
      return const App();
    },
    enabled: false,
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();

  static void setLocale(BuildContext context, LanguageEnum newLocale) {
    _AppState state = context.findAncestorStateOfType()!;
    state.setState(() {
      state.locale = Locale(newLocale.name);
    });
    sl<AppSharedPrefs>().setLang(newLocale);
  }
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Locale locale = const Locale("en");
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
  GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (mounted) {
      LanguageEnum newLocale = Helper.getLang();
      setState(() {
        locale = Locale(newLocale.local);
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppNotifier(),
      child: Consumer<AppNotifier>(
        builder: (context, value, child) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                title: 'Ny Times Articles App',
                routerConfig: CustomNavigationHelper.router,
                scaffoldMessengerKey: snackBarKey,
                theme: Helper.isDarkTheme() ? darkAppTheme : appTheme,
                debugShowCheckedModeBanner: false,
                locale: locale,
                builder: DevicePreview.appBuilder,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale("ar"),
                  Locale("en"),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// App notifier for Lang, Theme, ...
class AppNotifier extends ChangeNotifier {
  late bool darkTheme;

  AppNotifier() {
    _initialise();
  }

  Future _initialise() async {
    darkTheme = Helper.isDarkTheme();

    notifyListeners();
  }

  void updateThemeTitle(bool newDarkTheme) {
    darkTheme = newDarkTheme;
    if (Helper.isDarkTheme()) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
    notifyListeners();
  }
}
