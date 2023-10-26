import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:smart_manager/app/modules/admin/profile_admin/controllers/profile_admin_controller.dart';
import 'package:smart_manager/app/utils/widgets/reusable_widget.dart';

class AboutAppEdit extends GetView<ProfileAdminController> {
  const AboutAppEdit({super.key});

  @override
  Widget build(BuildContext context) {
    final QuillEditorController controller = QuillEditorController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('About App'),
      ),
      body: Column(
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
            toolBarColor: Colors.cyan.shade50,
            activeIconColor: Colors.green,
            padding: const EdgeInsets.all(8),
            iconSize: 20,
            controller: controller,
          ),
          Expanded(
            child: QuillHtmlEditor(
              text: "<h1>Hello</h1>This is a quill html editor example 😊",
              hintText: 'Hint text goes here',
              controller: controller,
              isEnabled: true,
              minHeight: 300,
              backgroundColor: Colors.white,
              hintTextAlign: TextAlign.start,
              padding: const EdgeInsets.only(left: 10, top: 5),
              hintTextPadding: EdgeInsets.zero,
              onFocusChanged: (hasFocus) => debugPrint('has focus $hasFocus'),
              onTextChanged: (text) => debugPrint('widget text change $text'),
              onEditorCreated: () => debugPrint('Editor has been loaded'),
              onEditingComplete: (s) => debugPrint('Editing completed $s'),
              onEditorResized: (height) => debugPrint('Editor resized $height'),
              onSelectionChanged: (sel) =>
                  debugPrint('${sel.index},${sel.length}'),
              loadingBuilder: (context) {
                return const Center(child: CustomProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
