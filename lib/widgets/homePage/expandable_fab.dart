import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../default_text.dart';
import '../utils.dart';

class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    Key? key,
    required this.icons,
    required this.texts,
    required this.onTaps,
    required this.callback,
  }) : super(key: key);
  final List<String> icons;
  final Function callback;
  final List<String> texts;
  final List<Function()> onTaps;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab> {
  bool _isOpen = false;

  void _toggle() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 56,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ...List.generate(
            widget.icons.length,
            (index) => AnimatedPositioned(
              bottom: _isOpen ? (index + 1) * 60 : 0,
              duration: const Duration(milliseconds: 250),
              child: _buildSelection(index),
            ),
          ),
          _tapToClose(),
        ],
      ),
    );
  }

  Row _buildSelection(int index) {
    return Row(
      children: [
        AnimatedOpacity(
            opacity: _isOpen ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: DefaultText(
              widget.texts[index],
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            )),
        GestureDetector(
          onTap: () => tapInvoke(index), //widget.callback(),
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            width: 55,
            height: 55,
            child: SvgPicture.asset(widget.icons[index]),
          ),
        ),
      ],
    );
  }

  void tapInvoke(int index) {
    widget.onTaps[index]();
    setState(() {
      _isOpen = false;
    });
  }

  Widget _tapToClose() {
    return GestureDetector(
      onTap: () => _toggle(),
      child: Container(
        width: 55,
        height: 55,
        child: SvgPicture.asset(
          _isOpen ? "assets/images/fab_open.svg" : "assets/images/fab.svg"
        ),
      ),
    );
  }
}
