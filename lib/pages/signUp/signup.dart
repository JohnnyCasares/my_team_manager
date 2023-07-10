import 'package:flutter/material.dart';
import 'package:my_team_manager/pages/signUp/picture.dart';
import 'package:my_team_manager/pages/signUp/player_data.dart';
import 'package:my_team_manager/pages/signUp/user_data.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final List<Widget> pages = const [UserData(), PlayerData(), Picture()];
  final PageController pageController = PageController();
  int pageIndex = 0;
  Duration transitionTime = const Duration(milliseconds: 700);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Create account')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: pages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: pageIndex >= 1
                        ? () {
                            setState(() {
                              pageIndex--;
                            });

                            pageController.previousPage(duration: transitionTime, curve: Curves.fastOutSlowIn);
                          }
                        : null,
                    child: Text('Previous')),
                SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        ++pageIndex;
                      });
                      print(pageIndex);
                      pageController.nextPage(duration: transitionTime, curve: Curves.fastOutSlowIn);
                    },
                    child: Text('Next')),

              ],

            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
