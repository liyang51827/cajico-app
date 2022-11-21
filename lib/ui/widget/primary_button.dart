import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/app_size.dart';
import '../common/app_color.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.width = double.infinity,
    this.height = buttonHeight,
    this.isValid = true,
    this.onPressed,
  });

  final String label;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: primaryColor,
          disabledBackgroundColor: primaryColor,
          disabledForegroundColor: Colors.white,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        onPressed: isValid ? onPressed : null,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class DarkGrayButton extends StatelessWidget {
  const DarkGrayButton({
    super.key,
    required this.label,
    this.width = double.infinity,
    this.height = buttonHeight,
    this.isValid = true,
    this.onPressed,
  });

  final String label;

  final double width;
  final double height;

  final VoidCallback? onPressed;

  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: gray3,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        onPressed: isValid ? onPressed : null,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class SubButton extends StatelessWidget {
  const SubButton({
    super.key,
    required this.label,
    this.isValid = true,
    this.onPressed,
    this.icon,
  });

  final String label;

  final VoidCallback? onPressed;

  final bool isValid;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Get.theme.primaryColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(74)),
            side: BorderSide(
              width: 1,
              color: outlineColor,
            ),
          ),
        ),
        onPressed: isValid ? onPressed : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: icon,
                  )
                : Container(),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSubButton extends StatelessWidget {
  const CustomSubButton({
    super.key,
    required this.textWidget,
    this.isValid = true,
    this.onPressed,
    this.icon,
  });

  final Widget textWidget;

  final VoidCallback? onPressed;

  final bool isValid;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Get.theme.primaryColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(74)),
            side: BorderSide(
              width: 1,
              color: outlineColor,
            ),
          ),
        ),
        onPressed: isValid ? onPressed : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: icon,
                  )
                : Container(),
            textWidget,
          ],
        ),
      ),
    );
  }
}

class SmallPrimaryButton extends StatelessWidget {
  const SmallPrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isValid = true,
  });

  final String label;

  final VoidCallback? onPressed;

  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.primaryColor,
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        onPressed: isValid ? onPressed : null,
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class CustomPrimaryButton extends StatelessWidget {
  const CustomPrimaryButton({
    super.key,
    required this.textWidget,
    this.isValid = true,
    this.onPressed,
    this.icon,
  });

  final Widget textWidget;

  final VoidCallback? onPressed;

  final bool isValid;

  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(74)),
            side: BorderSide(
              width: 1,
              color: outlineColor,
            ),
          ),
        ),
        onPressed: isValid ? onPressed : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: icon,
                  )
                : Container(),
            textWidget,
          ],
        ),
      ),
    );
  }
}

class AlwaysTappableButton extends StatelessWidget {
  const AlwaysTappableButton({
    super.key,
    required this.label,
    this.width = double.infinity,
    this.height = buttonHeight,
    this.isValid = true,
    this.onPressed,
    this.onPressDisabled,
  });

  final String label;

  final double width;
  final double height;

  final VoidCallback? onPressed;
  final VoidCallback? onPressDisabled;

  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: switchStyle(context),
        onPressed: isValid ? onPressed : onPressDisabled,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  ButtonStyle switchStyle(BuildContext context) {
    if (isValid) {
      return ElevatedButton.styleFrom(
        backgroundColor: Get.theme.primaryColor,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        elevation: 0,
      );
    }
    return ElevatedButton.styleFrom(
      backgroundColor: gray4.withOpacity(0.38),
      foregroundColor: gray2.withOpacity(0.6),
      shape: const StadiumBorder(),
      elevation: 0,
    );
  }
}
