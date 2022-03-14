import 'package:flutter/material.dart';
import 'package:no_todo_app/view/pages/intro/intro_page3.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const IntroPage3(),
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
              'この原因はもしかしたら\n「やらなきゃいけないこと」を\n作り過ぎているからかも、、',
              style: Theme.of(context).textTheme.headline5!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
