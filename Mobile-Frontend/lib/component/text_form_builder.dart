import 'package:algorithm/utility/common.dart';
import 'package:algorithm/utility/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_card.dart';

class TextFormBuilder extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final String? whichPage;

  final TextInputType? textInputType;

  final TextEditingController? controller;

  final TextInputAction? textInputAction;

  final bool capitalization;
  final bool obscureText;
  final bool? enabled;

  final FocusNode? focusNode, nextFocusNode;

  final VoidCallback? submitAction;

  final double? iconSize;

  final FormFieldValidator<String>? validateFunction;

  final void Function(String)? onSaved, onChange;

  @override
  // ignore: overridden_fields
  final Key? key;

  final IconData? prefix;
  final IconData? suffix;

  const TextFormBuilder(
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
      required this.capitalization,
      this.key,
      this.iconSize})
      : super(key: key);

  @override
  State<TextFormBuilder> createState() => _TextFormBuilderState();
}

class _TextFormBuilderState extends State<TextFormBuilder> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                textCapitalization: widget.capitalization == false
                    ? TextCapitalization.none
                    : TextCapitalization.sentences,
                initialValue: widget.initialValue,
                enabled: widget.enabled,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  height: 1.2,
                ),
                onChanged: (value) => {
                  error = widget.validateFunction!(value),
                  setState(() {}),
                  widget.onChange!(value)
                },
                key: widget.key,
                obscureText: widget.obscureText,
                validator: widget.validateFunction,
                controller: widget.controller,
                onSaved: (value) {
                  error = widget.validateFunction!(value!);
                  setState(() {});
                  widget.onSaved!(value);
                },
                textInputAction: widget.textInputAction,
                focusNode: widget.focusNode,
                onFieldSubmitted: (term) {
                  if (widget.nextFocusNode != null) {
                    widget.focusNode!.unfocus();
                    FocusScope.of(context).requestFocus(widget.nextFocusNode);
                  } else {
                    widget.submitAction!();
                  }
                },
                keyboardType: widget.textInputType,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    widget.prefix,
                    size: widget.iconSize ?? 25.0,
                    color: widget.whichPage == "login"
                        ? Constants.orange
                        : Colors.blue,
                  ),
                  suffixIcon: Icon(
                    widget.suffix,
                    size: 25.0,
                    color: widget.whichPage == "login"
                        ? Constants.orange
                        : Colors.blue,
                  ),
                  fillColor: Colors.black,
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.ubuntu().fontFamily,
                    height: 1.2,
                  ),
                  contentPadding: const EdgeInsets.all(15.0),
                  border: border(context, widget.whichPage!),
                  enabledBorder: border(context, widget.whichPage!),
                  focusedBorder: focusBorder(context, widget.whichPage!),
                  errorStyle: const TextStyle(height: 10.0, fontSize: 0.0),
                ),
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
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
        ],
      ),
    );
  }
}
