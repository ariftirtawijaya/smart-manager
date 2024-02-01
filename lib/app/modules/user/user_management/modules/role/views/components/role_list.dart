import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/role_model.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/controllers/role_controller.dart';
import 'package:smart_manager/app/modules/user/user_management/modules/role/views/edit_role.dart';
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
                Get.bottomSheet(Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.0),
                        topRight: Radius.circular(12.0),
                      ),
                      color: Colors.white),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        role.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text("Choose Options",
                          style: Theme.of(context).textTheme.titleSmall!),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomButton(
                                  onPressed: () {
                                    controller
                                        .assignPermission(role.permission);
                                    Get.back();
                                    Get.to(() => const EditRole(),
                                        arguments: role);
                                  },
                                  text: 'Edit')),
                          const SizedBox(
                            width: 16.0,
                          ),
                          Expanded(
                              child: CustomOutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                    controller.deleteRole(context, role.id);
                                  },
                                  text: 'Delete')),
                        ],
                      ),
                    ],
                  ),
                ));
                // Get.to(() => const UsersAdminDetailView(), arguments: role);
              },
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  role.name.capitalize!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                // subtitle: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Text(role.active == false ? 'Not Active' : 'Active'),
                //     Switch(
                //       value: true,
                //       onChanged: (value) {},
                //     )
                //   ],
                // ),
                subtitle:
                    role.description != null ? Text(role.description!) : null,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(role.active == false ? 'Not Active' : 'Active'),
                    Switch(
                      value: role.active,
                      onChanged: (value) {
                        controller.toggleRoleStatus(
                            context, role.active, role.id);
                      },
                    )
                  ],
                ),
                // trailing: Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     CustomIconButton(
                //       icon: FontAwesomeIcons.solidPenToSquare,
                //       color: secondaryColor,
                //       onTap: () {
                //         // controller.clear();
                //         // Get.to(() => const UsersAdminEdit(), arguments: role);
                //       },
                //     ),
                //     const SizedBox(
                //       width: 8.0,
                //     ),
                //     CustomIconButton(
                //       icon: FontAwesomeIcons.trash,
                //       color: secondaryColor,
                //       onTap: () {
                //         // controller.deleteUser(context, role, false);
                //       },
                //     ),
                //   ],
                // ),
              ),
            ),
          ),
        );
      },
    );
  }
}
