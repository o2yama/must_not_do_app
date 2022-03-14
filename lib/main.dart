import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:no_todo_app/repository/prefs_repository.dart';
import 'package:no_todo_app/view/pages/home/home_page.dart';
import 'package:no_todo_app/view/pages/intro/intro_page1.dart';
import 'package:no_todo_app/view_model/home_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsRepository().getInstance();
  await MobileAds.instance.initialize();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.white,
            backgroundColor: Colors.grey.shade100,
            appBarTheme: AppBarTheme(
              elevation: 2,
              color: Theme.of(context).primaryColor,
              shadowColor: Colors.grey,
            ),
          ),
          home: HomeModel().getLaunchStatus() == 0
              ? const IntroPage1()
              : const HomePage(),
        );
      },
    );
  }
}
