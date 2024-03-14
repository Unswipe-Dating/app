import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unswipe/Login.dart';
import 'package:unswipe/router/my_app_router_delegate_03.dart';
import 'package:unswipe/src/core/helper/helper.dart';
import 'package:unswipe/src/core/preference.dart';
import 'package:unswipe/src/core/utils/injections.dart';
import 'package:unswipe/src/shared/data/data_sources/app_shared_prefs.dart';
import 'package:unswipe/src/shared/domain/entities/language_enum.dart';
import 'package:unswipe/viewmodels/auth_view_model.dart';
import 'package:unswipe/widgets/homePage/dart_swiper.dart';

import 'data/auth_repository.dart';

void main() {
  runApp(App());
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

final navigatorKey = GlobalKey<NavigatorState>();


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

class _AppState extends State<App> {
  Locale locale = const Locale("en");
  late MyAppRouterDelegate delegate;
  late AuthRepository authRepository;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepository(Preference());
    delegate = MyAppRouterDelegate(authRepository);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthViewModel>(
          create: (_) => AuthViewModel(authRepository),
        )
      ],
      child: MaterialApp(
          home: Router(
            routerDelegate: delegate,
            backButtonDispatcher: RootBackButtonDispatcher(),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Unswipe",
                style: TextStyle(
                  fontFamily: 'Playfair',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              Icon(Icons.notifications),
            ],
          ),
        ),
      ),
      body: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: const Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 20.0,),
                    SwipeInterface(),
                  ],
                ),
              ),
            ),
          ),
          title: "UnSwipe",
          theme: ThemeData(
            primaryColor: const Color(0xFF3E69FE), // Set the primary color
            appBarTheme: const AppBarTheme(
              color: Color(0xFF3E69FE), // Set the appbar background colo
            ),
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_search, color: Colors.grey,),
          activeIcon: Icon(Icons.person_search, color: Colors.black,),
          label: '',

        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite, color: Colors.grey,),
          activeIcon: Icon(Icons.favorite, color: Colors.black,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public, color: Colors.grey,),
          activeIcon: Icon(Icons.public, color: Colors.black,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.grey,),
          activeIcon: Icon(Icons.person, color: Colors.black,),
          label: '',
        ),
      ],
    ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
