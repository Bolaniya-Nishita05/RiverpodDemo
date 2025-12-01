import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpoddemo/ToDoListScreen.dart';
import 'package:riverpoddemo/l10n/AppLocalizations.dart';
import 'LoginScreen.dart';
import 'package:get/get.dart';

void main() {
  runApp(
      const ProviderScope(
          child: MyApp()
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  Locale _locale = const Locale('en');

  void changeLocale(Locale locale) {
    setState(() => _locale = locale);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint("App Started: initState()");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("App Lifecycle changed: $state");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint("App Disposed: dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // base size used in design (width, height)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              color: Colors.green.shade900,               // Background color
              elevation: 4,                     // Shadow
              titleTextStyle: TextStyle(        // Title style
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(         // Icon color
                color: Colors.white,
              ),
            )
          ),
          debugShowCheckedModeBanner: false,
          locale: _locale,
          supportedLocales: const [Locale('en'), Locale('hi')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: LoginScreen(onChangeLanguage: changeLocale),
        );
      },
    );
  }
}
