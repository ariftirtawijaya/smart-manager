import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/modules/admin/users_admin/controllers/users_admin_controller.dart';
import 'package:smart_manager/app/modules/admin/users_admin/views/users_admin_detail.dart';
import 'package:smart_manager/app/modules/admin/users_admin/views/users_admin_edit.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class UsersList extends GetView<UsersAdminController> {
  const UsersList({
    super.key,
    required this.itemCount,
    required this.userData,
  });
  final int itemCount;
  final RxList<UserModel> userData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final UserModel user = userData[index];
        return Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Card(
            elevation: 5,
            shadowColor: grey3,
            borderOnForeground: true,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: grey3,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              overlayColor: const MaterialStatePropertyAll(primaryColor),
              onTap: () {
                Get.to(() => const UsersAdminDetailView(), arguments: user);
              },
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  user.name!.capitalize!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: user.profilePic == null
                    ? Image.asset(
                        imagePlaceholder,
                        height: 52,
                      )
                    : CustomImageView(
                        imageUrl: user.profilePic!,
                        size: 52,
                      ),
                // subtitle: const Text('(Disabled)'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconButton(
                      icon: FontAwesomeIcons.solidPenToSquare,
                      color: secondaryColor,
                      onTap: () {
                        controller.clear();
                        Get.to(() => const UsersAdminEdit(), arguments: user);
                      },
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    CustomIconButton(
                      icon: FontAwesomeIcons.trash,
                      color: secondaryColor,
                      onTap: () {
                        controller.deleteUser(context, user, false);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
