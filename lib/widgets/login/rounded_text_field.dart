import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import 'icon_text.dart';

class RoundedTextInput extends StatefulWidget {
  final String titleText;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool isEnabled;
  final String errorString;
  final bool isCountryCode;

  const RoundedTextInput(
      {super.key,
      this.isCountryCode = false,
      required this.titleText,
      required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      this.isEnabled = true,
      this.errorString = ""});

  @override
  State<RoundedTextInput> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextInput> {
  final ValueNotifier<bool> _textFiledIsFocused = ValueNotifier(false);
  late final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      _textFiledIsFocused.value = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    _textFiledIsFocused.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.isCountryCode ? (){
          showCountryPicker(
            context: context,
            showPhoneCode: true, // optional. Shows phone code before the country name.
            onSelect: (Country country) {
              widget.controller.text = "+${country.phoneCode}";
            },
          );

        }: null,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: widget.titleText,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0),
              children: [
                TextSpan(
                    text: widget.isCountryCode ? '' : ' *',
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 18))
              ]),
        ),
        const SizedBox(height: 8.0),
        ValueListenableBuilder(
            valueListenable: _textFiledIsFocused,
            builder: (context, value, child) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: value
                        ? Border.all(color: Colors.black)
                        : Border.all(color: Colors.transparent),
                    color: Colors.grey[200],
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    enabled: widget.isEnabled && !widget.isCountryCode,
                    focusNode: focusNode,
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: const TextStyle(
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                        border: InputBorder.none),
                  ),
                )),
        if (widget.errorString != "")
          IconTextWidget(
            iconData: Icons.error,
            text: widget.errorString,
            color: Colors.red,
          )

      ],
    ),
    );
  }
}
