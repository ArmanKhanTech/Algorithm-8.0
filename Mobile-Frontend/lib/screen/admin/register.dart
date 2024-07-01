import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import 'package:algorithm/component/text_form_builder.dart';
import 'package:algorithm/utility/regex.dart';
import 'package:algorithm/viewmodel/admin/register_view_model.dart';
import 'package:algorithm/widget/circular_progress.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    RegisterViewModel viewModel = Provider.of<RegisterViewModel>(context);

    Widget buildForm(RegisterViewModel viewModel, BuildContext context) {
      return Form(
        key: viewModel.registerFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormBuilder(
              capitalization: true,
              enabled: !viewModel.loading,
              prefix: Icons.person,
              hintText: "Name",
              textInputAction: TextInputAction.next,
              validateFunction: Regex.validateName,
              onSaved: (String val) {
                viewModel.setName(val);
              },
              focusNode: viewModel.nameFocusNode,
              nextFocusNode: viewModel.emailFocusNode,
              whichPage: "signup",
            ),
            const SizedBox(height: 10.0),
            TextFormBuilder(
              capitalization: false,
              enabled: !viewModel.loading,
              prefix: Icons.email,
              hintText: "Email",
              textInputAction: TextInputAction.next,
              validateFunction: Regex.validateEmail,
              onSaved: (String val) {
                viewModel.setEmail(val);
              },
              focusNode: viewModel.emailFocusNode,
              nextFocusNode: viewModel.typeFocusNode,
              whichPage: "signup",
            ),
            const SizedBox(height: 10.0),
            TextFormBuilder(
              capitalization: true,
              enabled: !viewModel.loading,
              prefix: Icons.work,
              hintText: "Type",
              textInputAction: TextInputAction.next,
              validateFunction: Regex.validateType,
              onSaved: (String val) {
                viewModel.setType(val);
              },
              focusNode: viewModel.typeFocusNode,
              nextFocusNode: viewModel.passFocusNode,
              whichPage: "signup",
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 45.0,
                width: MediaQuery.of(context).size.width,
                child: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Text(
                    'Create',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () => viewModel.register(context),
                ),
              ),
            )
          ],
        ),
      );
    }

    return LoadingOverlay(
        isLoading: viewModel.loading,
        progressIndicator: CircularProgress(context, const Color(0XFF03A9F4)),
        opacity: 0.5,
        color: Theme.of(context).colorScheme.surface,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 30,
              ),
            ),
            extendBodyBehindAppBar: true,
            backgroundColor: Theme.of(context).colorScheme.surface,
            key: viewModel.registerScaffoldKey,
            body: ListView(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 10),
                const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Create a new account',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                buildForm(viewModel, context),
              ],
            )));
  }
}
