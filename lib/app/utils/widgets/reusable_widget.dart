import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smart_manager/app/constant/app_constant.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: secondaryColor,
      strokeWidth: 2,
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.validator,
    this.maxLines,
    this.keyboardType,
  });

  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final int? maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(color: grey2, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                const SizedBox(
                  width: 16.0,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: darkBlue,
                      ),
                ),
              ],
            ),
          ),
          TextFormField(
            maxLines: maxLines,
            controller: controller,
            keyboardType: keyboardType,
            validator: validator,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey2,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPasswordField extends StatelessWidget {
  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.hiddenController,
    this.validator,
  });

  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final RxBool hiddenController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(color: grey2, width: 2)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: darkBlue,
                            ),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return TextFormField(
                    controller: controller,
                    obscureText: hiddenController.value,
                    validator: validator,
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: grey2,
                              ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Obx(() {
            return IconButton(
              constraints: const BoxConstraints(),
              splashRadius: 1,
              onPressed: () {
                hiddenController.toggle();
              },
              icon: Icon(hiddenController.isTrue
                  ? Icons.remove_red_eye
                  : Icons.visibility_off_rounded),
            );
          }),
          const SizedBox(
            width: 6.0,
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(400, 48),
        textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class CustomButtonSmall extends StatelessWidget {
  const CustomButtonSmall({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 36,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: secondaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size(400, 48),
          textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondaryColor,
        minimumSize: const Size(400, 48),
        textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: secondaryColor,
              fontWeight: FontWeight.bold,
            ),
        shape: const RoundedRectangleBorder(
          side: BorderSide(
            color: secondaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.title,
    required this.value,
    required this.onTap,
    required this.icon,
  });

  final String title;
  final int value;
  final void Function()? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: primaryColor.withOpacity(0.8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
              AutoSizeText(
                value.toString(),
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              AutoSizeText(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
