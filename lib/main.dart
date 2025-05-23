import 'package:country_code_picker/country_code_picker.dart';
import 'package:eshopmultivendor/Helper/PushNotificationService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Helper/Color.dart';
import 'Helper/notification_service.dart';
import 'Localization/Demo_Localization.dart';
import 'Localization/Language_Constant.dart';
import 'Screen/Splash_/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestLocationPermission();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    systemNavigationBarColor: Colors.transparent,
  ));
  /*final pushNotificationService = PushNotificationService();
  pushNotificationService.initialise();*/
  LocalNotificationService.initialize();

  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
  FirebaseMessaging.instance.getToken().then((value) {
    String fcmToken = value!;

    print("fcm is ${fcmToken}");
  });
  runApp(MyApp());
}

Future<void> _requestLocationPermission() async {
  // Check if the permission is already granted
  if (await Permission.location.isGranted) {
    return;
  }

  // Request permission
  var status = await Permission.location.request();

  // Check the status and handle accordingly
  if (status.isGranted) {
    print("Location permission granted");
  } else {
    print("Location permission denied");
    // Handle the denial, for example, show a message or disable location-based features
  }
}

//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   FirebaseMessaging.instance.getToken().then((value) {
//     String fcmToken = value!;
//
//     print("fcm is ${fcmToken}");
//   });
//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  late SharedPreferences sharedPreferences;
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  setLocale(Locale locale) {
    if (mounted)
      setState(
        () {
          _locale = locale;
        },
      );
  }

  @override
  void didChangeDependencies() {
    getLocale().then(
      (locale) {
        if (mounted)
          setState(
            () {
              this._locale = locale;
            },
          );
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'homeneeds Seller',
      theme: ThemeData(
        primarySwatch: primary_app,
        fontFamily: 'opensans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      locale: _locale,
      localizationsDelegates: [
        CountryLocalizations.delegate,
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", "US"),
        Locale("zh", "CN"),
        Locale("es", "ES"),
        Locale("hi", "IN"),
        Locale("ar", "DZ"),
        Locale("ru", "RU"),
        Locale("ja", "JP"),
        Locale("de", "DE"),
        Locale("te", "IN")
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale!.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
