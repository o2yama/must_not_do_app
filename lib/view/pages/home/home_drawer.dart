import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:no_todo_app/utils/screen_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).backgroundColor,
              height: 100,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(primary: Colors.grey),
                child: Row(
                  children: const [
                    Icon(
                      CupertinoIcons.back,
                      color: Colors.black54,
                    ),
                    Text(
                      '戻る',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1),
            ListTile(
              leading: Icon(
                CupertinoIcons.mail,
                color: Colors.black54,
                size: ScreenData.isMobile ? 24.sp : 12.sp,
              ),
              title: Text(
                'お問い合せ',
                style: TextStyle(fontSize: 16.sp, color: Colors.black54),
              ),
              onTap: () => launch(
                  'https://docs.google.com/forms/d/1RPR4qbK-0vTRfs3p8m4thhLy0Xel5mw8vm1e6VuVa5g/edit'),
            ),
            const Divider(thickness: 1),
            ListTile(
              leading: Icon(
                CupertinoIcons.info,
                color: Colors.black54,
                size: ScreenData.isMobile ? 24.sp : 12.sp,
              ),
              title: Text(
                'プライバシーポリシー',
                style: TextStyle(fontSize: 16.sp, color: Colors.black54),
              ),
              onTap: () => launch('https://o2yama.github.io/privacy_policy/'),
            ),
          ],
        ),
      ),
    );
  }
}
