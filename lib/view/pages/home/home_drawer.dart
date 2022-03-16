import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/utils/screen_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenData.isMobile
          ? ScreenData.width(context) * 0.8
          : ScreenData.width(context) * 0.6,
      color: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              Container(
                color: Theme.of(context).backgroundColor,
                height: ScreenData.isMobile ? 100.sp : 50.sp,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(primary: Colors.grey),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.back,
                        color: Colors.black54,
                        size: ScreenData.isMobile ? 20.sp : 15.sp,
                      ),
                      Text(
                        '戻る',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: ScreenData.isMobile ? 14.sp : 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 1),
              ListTile(
                contentPadding: EdgeInsets.all(8.r),
                leading: Icon(
                  CupertinoIcons.mail,
                  color: Colors.black54,
                  size: ScreenData.isMobile ? 24.sp : 12.sp,
                ),
                title: Text(
                  'お問い合せ',
                  style: TextStyle(
                    fontSize: ScreenData.isMobile ? 16.sp : 12.sp,
                    color: Colors.black54,
                  ),
                ),
                onTap: () => launch(
                    'https://docs.google.com/forms/d/1RPR4qbK-0vTRfs3p8m4thhLy0Xel5mw8vm1e6VuVa5g/edit'),
              ),
              const Divider(thickness: 1),
              ListTile(
                contentPadding: EdgeInsets.all(8.r),
                leading: Icon(
                  CupertinoIcons.info,
                  color: Colors.black54,
                  size: ScreenData.isMobile ? 24.sp : 12.sp,
                ),
                title: Text(
                  'プライバシーポリシー',
                  style: TextStyle(
                    fontSize: ScreenData.isMobile ? 16.sp : 12.sp,
                    color: Colors.black54,
                  ),
                ),
                onTap: () => launch('https://o2yama.github.io/privacy_policy/'),
              ),
              const Divider(thickness: 1),
            ],
          ),
        ),
      ),
    );
  }
}
