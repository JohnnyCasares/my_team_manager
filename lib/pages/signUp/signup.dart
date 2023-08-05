import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:my_team_manager/custom%20widgets/models/users/user.dart';
import 'package:my_team_manager/pages/signUp/picture.dart';
import 'package:my_team_manager/pages/signUp/player_info.dart';
import 'package:my_team_manager/pages/signUp/account_info.dart';
import 'package:my_team_manager/services/firebase_services.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Create a storage reference from our app
  final Reference storageRef = FirebaseStorage.instance.ref();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  File? image;
  Map<String, String> positions = {};

  final PageController pageController = PageController();
  int pageIndex = 0;
  Duration transitionTime = const Duration(milliseconds: 700);
  String nextButton = 'Next';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    positionController.dispose();
    pageController.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      UserData(
        emailController: emailController,
        passwordController: passwordController,
      ),
      PlayerData(
        nameController: nameController,
        positionController: positionController,
        positions: (Map<String, String> positions) {
          this.positions = positions;
        },
      ),
      Picture(
        onImageChange: (File? image) {
          setState(() {
            this.image = image;
          });
        },
      )
    ];

    // Function to navigate to the previous page
    void goToPreviousPage() {
      setState(() {
        pageIndex--;
        if (pageIndex != pages.length - 1) {
          nextButton = 'Next';
        }
      });
      pageController.previousPage(
        duration: transitionTime,
        curve: Curves.fastOutSlowIn,
      );
    }

    void goToNextPage() {
      bool formState = _formKey.currentState?.validate() ?? false;
      if (formState) {
        setState(() {
          pageIndex++;
          if (pageIndex == pages.length - 1) {
            nextButton = 'Finish';
          }
        });

        pageController.nextPage(
            duration: transitionTime, curve: Curves.fastOutSlowIn);
      }
    }

    void validateForm() async {
      bool formState = _formKey.currentState?.validate() ?? false;

      print(
          "SignUp.dart: ${image?.path ?? 'Nada aun'}"); //test if image is received
      if (formState) {
        print("All fields are filled");
        // then get url and add it to player
        AppUser player =
            AppUser(name: nameController.text, position: positions);
        await Authentication.createUserEmailAndPassword(
            emailController.text, passwordController.text, player);
      }

      //TODO: SHOW LOADING WIDGET???
      if (_auth.currentUser != null) {
        //Upload image once user is authenticated
        if (image != null) {
          Storage.uploadImage(image!);
        }
        //
        Navigator.of(context).pop();
      }
    }

    ///////////////////////////////////////////////////////
    // Interface
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Create account')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Expanded(
              child: Form(
                key: _formKey,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: pages,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: pageIndex >= 1 ? goToPreviousPage : null,
                    child: const Text('Previous')),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: pageIndex != (pages.length - 1)
                        ? goToNextPage
                        : validateForm,
                    child: Text(nextButton)),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
