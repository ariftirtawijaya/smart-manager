import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/services/db_service.dart';
import 'package:smart_manager/app/modules/admin/profile_admin/controllers/profile_admin_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class TermsConditionsEdit extends GetView<ProfileAdminController> {
  const TermsConditionsEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final QuillEditorController htmlController = QuillEditorController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Edit Terms & Conditions'),
        actions: [
          IconButton(
            onPressed: () async {
              await htmlController.getText().then(
                    (content) => controller.changeContent(
                        context: context,
                        content: content,
                        section: 'terms-conditions'),
                  );
            },
            icon: const Icon(
              FontAwesomeIcons.solidFloppyDisk,
              size: 24.0,
            ),
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
            return Column(
              children: [
                ToolBar(
                  toolBarConfig: const [
                    ToolBarStyle.bold,
                    ToolBarStyle.italic,
                    ToolBarStyle.underline,
                    ToolBarStyle.strike,
                    ToolBarStyle.blockQuote,
                    ToolBarStyle.indentMinus,
                    ToolBarStyle.indentAdd,
                    ToolBarStyle.size,
                    ToolBarStyle.headerOne,
                    ToolBarStyle.headerTwo,
                    ToolBarStyle.color,
                    ToolBarStyle.align,
                    ToolBarStyle.listOrdered,
                    ToolBarStyle.listBullet,
                    ToolBarStyle.undo,
                    ToolBarStyle.redo,
                    ToolBarStyle.editTable,
                    ToolBarStyle.addTable,
                  ],
                  toolBarColor: primaryColor,
                  activeIconColor: Colors.white,
                  padding: const EdgeInsets.all(8),
                  iconSize: 20,
                  controller: htmlController,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QuillHtmlEditor(
                      textStyle: TextStyle(
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      text: data['content'],
                      controller: htmlController,
                      isEnabled: true,
                      minHeight: 300,
                      backgroundColor: Colors.white,
                      hintTextAlign: TextAlign.start,
                      loadingBuilder: (context) {
                        return const Center(child: CustomProgressIndicator());
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SizedBox(
                  width: Get.width * 0.5,
                  child: Image.asset(emptyImage),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
