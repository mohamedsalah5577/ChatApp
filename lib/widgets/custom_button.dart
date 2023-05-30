import 'package:flutter/cupertino.dart';

import 'constants.dart';

class CustomButton extends StatelessWidget {
  VoidCallback? onTap;
  String? text;

  CustomButton({super.key, this.onTap, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Container(
          alignment: AlignmentDirectional.center,
          height: 55,
          decoration: BoxDecoration(
            color: CupertinoColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text!,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
