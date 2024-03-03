import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import 'package:algorithm/components/pass_form_builder.dart';
import 'package:algorithm/components/text_form_builder.dart';
import 'package:algorithm/utilities/regex.dart';
import 'package:algorithm/utilities/constants.dart';
import 'package:algorithm/viewmodels/auth/login_view_model.dart';
import 'package:algorithm/widgets/circular_progress.dart';
import 'package:algorithm/screens/web.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = Provider.of<LoginViewModel>(context);

    buildForm(BuildContext context, LoginViewModel viewModel) {
      return Form(
        key: viewModel.loginFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(children: [
          TextFormBuilder(
            capitalization: false,
            enabled: !viewModel.loading,
            prefix: Icons.email,
            hintText: 'Email',
            textInputAction: TextInputAction.next,
            validateFunction: Regex.validateEmail,
            onSaved: (String value) {
              viewModel.setEmail(value);
            },
            focusNode: viewModel.emailFocusNode,
            nextFocusNode: viewModel.passwordFocusNode,
            whichPage: "login",
          ),
          const SizedBox(height: 10.0),
          PasswordFormBuilder(
            enabled: !viewModel.loading,
            prefix: Icons.lock,
            suffix: Icons.visibility,
            hintText: "Password",
            textInputAction: TextInputAction.done,
            validateFunction: Regex.validatePassword,
            submitAction: () => viewModel.loginUser(context),
            obscureText: true,
            onSaved: (String val) {
              viewModel.setPassword(val);
            },
            focusNode: viewModel.passwordFocusNode,
            whichPage: "login",
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: InkWell(
                onTap: () => viewModel.forgotPassword(context),
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Constants.orange),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 45.0,
              width: MediaQuery.of(context).size.width,
              child: FloatingActionButton(
                backgroundColor: Constants.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => viewModel.loginUser(context),
              ),
            ),
          )
        ]),
      );
    }

    return LoadingOverlay(
      progressIndicator: CircularProgress(context, const Color(0xFFEA580C)),
      opacity: 0.5,
      color: Theme.of(context).colorScheme.background,
      isLoading: viewModel.loading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              child: const Row(
                children: [
                  Text('Sign Up',
                      style:
                          TextStyle(fontSize: 25.0, color: Constants.orange)),
                  SizedBox(width: 10.0),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 25.0,
                    color: Constants.orange,
                  ),
                  SizedBox(width: 20.0),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => WebScreen(
                      url: 'https://algorithm8.aiktc.ac.in/signin',
                    ),
                  ),
                );
              },
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        key: viewModel.loginScaffoldKey,
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          children: [
            const SizedBox(height: 40),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:
                    Lottie.asset('assets/lottie/login.json', fit: BoxFit.fill),
              ),
            ),
            const SizedBox(height: 20),
            const Row(children: [
              SizedBox(width: 20.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
            buildForm(context, viewModel),
            const SizedBox(height: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account yet?',
                    style: TextStyle(fontSize: 18.0, color: Colors.white)),
                const SizedBox(width: 5.0),
                GestureDetector(
                  onTap: () {
                    viewModel.showSnackBar(
                        'Contact the Technical Team Lead - Arman Khan',
                        context);
                  },
                  child: const Text(
                    'What to do?',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Constants.orange,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
