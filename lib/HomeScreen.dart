import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpoddemo/GetXScreen.dart';
import 'package:riverpoddemo/LoginScreen.dart';
import 'package:riverpoddemo/ToDoListScreen.dart';
import 'package:riverpoddemo/UserProvider.dart';
import 'package:riverpoddemo/l10n/AppLocalizations.dart';

class HomeScreen extends ConsumerStatefulWidget {
  Function(Locale) onChangeLanguage;

  HomeScreen({required this.onChangeLanguage, super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with WidgetsBindingObserver {
  Locale locale=Locale('en');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    debugPrint("HomeScreen initState()");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    debugPrint("HomeScreen Lifecycle: $state");
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    debugPrint("HomeScreen dispose()");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("User Details with Screen Util"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              ref.read(userProvider.notifier).state = AsyncValue.data(null);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen(onChangeLanguage: widget.onChangeLanguage,)),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Center(
          child: user.when(
            data: (user) {
              if (user == null) {
                return Center(
                  child: Text("No user logged in"),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.translateWithArgs('greetingUser', {'name': '${user.name}'}),
                    style: TextStyle(fontSize: 22.sp,)
                  ),
                  Text("Email: ${user.email}", style: TextStyle(fontSize: 18.sp)),
                  Container(
                    width: 300.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Center(
                      child: Text(
                        "Responsive Container",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 12.h,
                      ),
                      backgroundColor: Colors.green.shade50,
                      foregroundColor: Colors.green,
                      elevation: 5
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ToDoListScreen(),));
                    },
                    child: Text(
                      AppLocalizations.of(context)!.translate('btnMsg'),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 12.h,
                        ),
                        backgroundColor: Colors.deepPurple.shade50,
                        foregroundColor: Colors.deepPurple,
                        elevation: 5
                    ),
                    onPressed: () {
                      locale = locale.languageCode == 'en'
                          ? const Locale('hi')
                          : const Locale('en');

                      widget.onChangeLanguage(locale);
                    },
                    child: Text('Change Language',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30.w,
                          vertical: 12.h,
                        ),
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.blue,
                        elevation: 5
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GetXScreen(),));
                    },
                    child: Text(
                      "GetX Screen",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                ],
              );
            },

            error: (err, stack) =>
                Center(child: Text("Error: ${err.toString()}")),

            loading: () => Center(child: CircularProgressIndicator())
          )
        ),
      ),
    );
  }
}
