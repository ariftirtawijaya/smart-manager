import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/modules/admin/users_admin/views/users_admin_detail.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class UsersList extends StatelessWidget {
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      edit,
                      colorFilter: const ColorFilter.mode(
                          secondaryColor, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    SvgPicture.asset(
                      delete,
                      colorFilter: const ColorFilter.mode(
                          secondaryColor, BlendMode.srcIn),
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
