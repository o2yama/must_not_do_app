import 'package:flutter/material.dart';
import 'package:no_todo_app/view/pages/intro/intro_page2.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const IntroPage2(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(child: child, opacity: animation),
          ),
        );
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: Text(
              '「時間がない」\n「超忙しい」\n「TODOに追われる日々」',
              style: Theme.of(context).textTheme.headline5!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
