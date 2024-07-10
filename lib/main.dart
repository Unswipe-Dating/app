import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:unswipe/src/core/utils/bootstrap.dart';
import 'package:unswipe/src/core/router/app_router.dart';
import 'package:unswipe/src/core/styles/app_theme.dart';


import 'package:unswipe/src/core/helper/helper.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await bootstrap(() =>  const App(), Environment.dev);

}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  Locale locale = const Locale("en");
  final GlobalKey<ScaffoldMessengerState> snackBarKey =
  GlobalKey<ScaffoldMessengerState>();

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      // Navigator.pushNamed(context, '/chat',
      //   arguments: ChatArguments(message),
      // );
    }
  }


  @override
  void initState() {
    super.initState();
    setupInteractedMessage();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /** Change Notifier helps with chaging everything on language change*/

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppNotifier(),
      child: Consumer<AppNotifier>(
        builder: (context, value, child) {
              return MaterialApp.router(
                routerConfig: CustomNavigationHelper.router,
                scaffoldMessengerKey: snackBarKey,
                theme: appTheme,
                debugShowCheckedModeBanner: false,
                locale: locale,
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
    darkTheme = await Helper.isDarkTheme();

    notifyListeners();
  }

}
