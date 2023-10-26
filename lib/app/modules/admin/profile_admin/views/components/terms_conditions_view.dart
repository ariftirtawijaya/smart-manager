import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/modules/admin/profile_admin/controllers/profile_admin_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class TermsConditionsView extends GetView<ProfileAdminController> {
  const TermsConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final QuillEditorController controller = QuillEditorController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        actions: [
          CustomIconButton(
            icon: edit,
            onTap: () {},
            color: Colors.white,
          ),
          const SizedBox(
            width: 8.0,
          ),
        ],
      ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: DBService.getCollections(from: settingsRef),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.data!.docs
              .where((element) => element.id == 'terms-conditions')
              .isNotEmpty) {
            final data = snapshot.data!.docs
                .where((element) => element.id == 'terms-conditions')
                .first
                .data();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: QuillHtmlEditor(
                      textStyle: TextStyle(
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      text: data['content'],
                      controller: controller,
                      isEnabled: false,
                      minHeight: 300,
                      backgroundColor: Colors.white,
                      hintTextAlign: TextAlign.start,
                      loadingBuilder: (context) {
                        return const Center(child: CustomProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: Lottie.asset(empty)),
            );
          }
        },
      ),
    );
  }
}
