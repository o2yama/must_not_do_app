import 'package:flutter/material.dart';
import 'package:no_todo_app/view/pages/home/home_page.dart';
import 'package:no_todo_app/view/pages/intro/intro_page2.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushAndRemoveUntil(context, HomePage.route(), (_) => false);
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Text(
              'Don\'tで「しないこと」を決めて\n本当にやりたいことに\n時間と情熱を注ぎましょう!',
              style: Theme.of(context).textTheme.headline5!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
