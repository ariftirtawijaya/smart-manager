import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quickalert/quickalert.dart';
import 'package:smart_manager/app/constant/app_colors.dart';

Future<void> showLoading({String? status}) {
  if (status != null) {
    return EasyLoading.show(
      status: status,
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
  } else {
    return EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
    );
  }
}

Future<void> endLoading() {
  return EasyLoading.dismiss();
}

void showAlert(
    {required BuildContext context,
    required QuickAlertType type,
    required String text,
    String? confirmText,
    void Function()? onConfirmBtnTap}) {
  QuickAlert.show(
    onConfirmBtnTap: onConfirmBtnTap,
    barrierDismissible: false,
    showCancelBtn: type != QuickAlertType.confirm ? false : true,
    cancelBtnText: 'No',
    confirmBtnText: type != QuickAlertType.confirm ? 'Ok' : 'Yes',
    context: context,
    type: type,
    title: type == QuickAlertType.success
        ? 'Success'
        : type == QuickAlertType.error
            ? 'Oops!'
            : type == QuickAlertType.info
                ? 'Info'
                : type == QuickAlertType.warning
                    ? 'Warning!'
                    : confirmText,
    text: text,
    confirmBtnColor: secondaryColor,
    cancelBtnTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: secondaryColor,
          fontWeight: FontWeight.bold,
        ),
    confirmBtnTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
  );
}
