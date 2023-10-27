import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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
    this.onChanged,
    this.onComplete,
  });

  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onComplete;

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
            onEditingComplete: onComplete,
            onChanged: onChanged,
            maxLines: maxLines ?? 1,
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

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.items,
    this.validator,
    this.maxLines,
    this.keyboardType,
    this.value,
    required this.onChanged,
  });

  final String title;
  final TextEditingController controller;
  final String? Function(dynamic)? validator;
  final String hintText;
  final int? maxLines;
  final TextInputType? keyboardType;

  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic)? onChanged;
  final dynamic value;

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
          DropdownButtonFormField(
            items: items,
            onChanged: onChanged,
            validator: validator,
            value: value,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grey2,
                  ),
              // contentPadding: EdgeInsets.z
            ),
          )
          // TextFormField(
          //   onChanged: onChanged,
          //   maxLines: maxLines,
          //   controller: controller,
          //   keyboardType: keyboardType,
          //   validator: validator,
          //   decoration: InputDecoration(
          //     hintText: hintText,
          //     hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          //           color: grey2,
          //         ),
          //   ),
          // ),
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
    this.onChanged,
    this.onComplete,
  });

  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final RxBool hiddenController;
  final void Function(String)? onChanged;
  final void Function()? onComplete;

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
                    onEditingComplete: onComplete,
                    onChanged: onChanged,
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
            return CustomIconButton(
                icon: hiddenController.isTrue
                    ? FontAwesomeIcons.solidEye
                    : FontAwesomeIcons.solidEyeSlash,
                onTap: () {
                  hiddenController.toggle();
                },
                color: darkBlue);
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
    this.color,
  });
  final void Function()? onPressed;
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? secondaryColor,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                // color: Colors.red,
                width: 64,
                child: Icon(
                  icon,
                  size: 48,
                  color: Colors.white,
                ),
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

class CustomImageView extends StatelessWidget {
  const CustomImageView({
    super.key,
    required this.imageUrl,
    required this.size,
    this.radius,
  });
  final String imageUrl;
  final double size;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(radius ?? 8.0),
          ),
        ),
      ),
      placeholder: (context, url) {
        return Shimmer.fromColors(
          baseColor: grey3,
          highlightColor: grey4,
          child: Image.asset(
            imagePlaceholder,
            height: size,
            width: size,
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Image.asset(
          imagePlaceholder,
          height: size,
          width: size,
        );
      },
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.color,
    this.size,
  });
  final IconData icon;
  final void Function() onTap;
  final Color color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: color,
        ),
      ),
    );
  }
}

class CustomListMenu extends StatelessWidget {
  const CustomListMenu({
    super.key,
    required this.title,
    required this.ontap,
  });

  final String title;
  final void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: primaryColor,
            width: 0.5,
          ),
        ),
      ),
      child: ListTile(
        onTap: ontap,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(color: darkBlue),
        ),
        trailing: const Icon(
          FontAwesomeIcons.chevronRight,
          color: darkBlue,
        ),
      ),
    );
  }
}

class CustomSearch extends StatelessWidget {
  const CustomSearch({
    super.key,
    required this.text,
    this.hasPrefixIcon = false,
    this.onPrefixPressed,
    this.prefixIcon,
    this.controller,
    this.onChanged,
  });
  final String text;
  final bool hasPrefixIcon;
  final void Function()? onPrefixPressed;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            color: black.withOpacity(0.3),
            blurRadius: 10,
          ),
        ],
      ),
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                    isDense: false,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: text,
                    prefixIcon: const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              hasPrefixIcon
                  ? Row(
                      children: [
                        const SizedBox(
                          width: 8.0,
                        ),
                        IconButton(
                          onPressed: onPrefixPressed,
                          icon: Icon(
                            prefixIcon,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
