import 'package:algorithm/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:algorithm/components/custom_card.dart';

class PasswordFormBuilder extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final String? whichPage;

  final bool? enabled;
  final bool obscureText;

  final TextInputType? textInputType;

  final TextEditingController? controller;

  final TextInputAction? textInputAction;

  final FocusNode? focusNode, nextFocusNode;

  final VoidCallback? submitAction;

  final FormFieldValidator<String>? validateFunction;

  final void Function(String)? onSaved, onChange;

  @override
  // ignore: overridden_fields
  final Key? key;
  final IconData? prefix;
  final IconData? suffix;

  const PasswordFormBuilder(
      {this.prefix,
      this.suffix,
      this.initialValue,
      this.enabled,
      this.hintText,
      this.textInputType,
      this.controller,
      this.textInputAction,
      this.nextFocusNode,
      this.focusNode,
      this.submitAction,
      this.obscureText = false,
      this.validateFunction,
      this.onSaved,
      this.onChange,
      required this.whichPage,
      this.key})
      : super(key: key);

  @override
  State<PasswordFormBuilder> createState() => _PasswordFormBuilderState();
}

class _PasswordFormBuilderState extends State<PasswordFormBuilder> {
  String? error;

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        CustomCard(
          borderRadius: BorderRadius.circular(10.0),
          child: Theme(
              data: ThemeData(
                primaryColor: Theme.of(context).colorScheme.secondary,
                colorScheme: ColorScheme.fromSwatch().copyWith(
                    secondary: Theme.of(context).colorScheme.secondary),
              ),
              child: TextFormField(
                  cursorColor: Colors.white,
                  textCapitalization: TextCapitalization.none,
                  initialValue: widget.initialValue,
                  enabled: widget.enabled,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontFamily: GoogleFonts.ubuntu().fontFamily,
                    height: 1.2,
                  ),
                  onChanged: (value) => {
                        error = widget.validateFunction!(value),
                        setState(() {}),
                        widget.onChange!(value)
                      },
                  onFieldSubmitted: (term) {
                    if (widget.nextFocusNode != null) {
                      widget.focusNode!.unfocus();
                      FocusScope.of(context).requestFocus(widget.nextFocusNode);
                    } else {
                      widget.submitAction!();
                    }
                  },
                  obscureText: obscureText,
                  keyboardType: widget.textInputType,
                  validator: widget.validateFunction,
                  onSaved: (val) {
                    error = widget.validateFunction!(val);
                    setState(() {});
                    widget.onSaved!(val!);
                  },
                  textInputAction: widget.textInputAction,
                  focusNode: widget.focusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(widget.prefix,
                        size: 25.0,
                        color: widget.whichPage == 'login'
                            ? Constants.orange
                            : Colors.blue),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() => obscureText = !obscureText);
                      },
                      child: Icon(
                          obscureText
                              ? widget.suffix
                              : Icons.visibility_off_outlined,
                          size: 25.0,
                          color: widget.whichPage == 'login'
                              ? Constants.orange
                              : Colors.blue),
                    ),
                    filled: true,
                    fillColor: Colors.black,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: GoogleFonts.ubuntu().fontFamily,
                      height: 1.2,
                    ),
                    contentPadding: const EdgeInsets.all(15.0),
                    border: border(context),
                    enabledBorder: border(context),
                    focusedBorder: focusBorder(context),
                    errorStyle: const TextStyle(height: 10.0, fontSize: 0.0),
                  ))),
        ),
        Visibility(
            visible: error != null,
            child: Column(
              children: [
                const SizedBox(height: 5.0),
                Text(
                  '$error',
                  style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 15.0,
                  ),
                ),
              ],
            )),
      ]),
    );
  }

  border(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: widget.whichPage == "login" ? Constants.orange : Colors.blue,
        width: .5,
      ),
    );
  }

  focusBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: widget.whichPage == "login" ? Constants.orange : Colors.blue,
        width: 1.0,
      ),
    );
  }
}
