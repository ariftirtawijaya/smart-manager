import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/role_model.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/controllers/role_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class RoleList extends GetView<RoleController> {
  const RoleList({
    super.key,
    required this.itemCount,
    required this.roleData,
  });
  final int itemCount;
  final RxList<RoleModel> roleData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final RoleModel role = roleData[index];
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
                // Get.to(() => const UsersAdminDetailView(), arguments: role);
              },
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  role.name.capitalize!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // leading: role.profilePic == null
                //     ? Image.asset(
                //         imagePlaceholder,
                //         height: 52,
                //       )
                //     : CustomImageView(
                //         imageUrl: role.profilePic!,
                //         size: 52,
                //       ),
                subtitle:
                    role.active == false ? const Text('(Inactive)') : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconButton(
                      icon: FontAwesomeIcons.solidPenToSquare,
                      color: secondaryColor,
                      onTap: () {
                        // controller.clear();
                        // Get.to(() => const UsersAdminEdit(), arguments: role);
                      },
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    CustomIconButton(
                      icon: FontAwesomeIcons.trash,
                      color: secondaryColor,
                      onTap: () {
                        // controller.deleteUser(context, role, false);
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
