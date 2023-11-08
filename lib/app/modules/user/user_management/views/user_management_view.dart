import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:smart_manager/app/utils/widgets/custom_user_page.dart';

import '../controllers/user_management_controller.dart';

class UserManagementView extends GetView<UserManagementController> {
  const UserManagementView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomUserPage(
      title: 'User Management',
      body: const Center(
        child: Text('User Management Will Be Here'),
      ),
    );
  }
}
// class UserManagementView extends GetView<UserManagementController> {
//   const UserManagementView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomUserPage(
//       title: 'Tambah produk',
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextFormField(
//               onChanged: (value) => controller.name.value = value,
//               decoration: const InputDecoration(labelText: 'Nama Produk'),
//             ),
//             TextFormField(
//               onChanged: (value) => controller.category.value = value,
//               decoration: const InputDecoration(labelText: 'Kategori'),
//             ),
//             TextFormField(
//               onChanged: (value) => controller.description.value = value,
//               decoration: const InputDecoration(labelText: 'Deskripsi'),
//             ),
//             TextFormField(
//               onChanged: (value) => controller.image.value = value,
//               decoration: const InputDecoration(labelText: 'URL Gambar Produk'),
//             ),
//             TextFormField(
//               onChanged: (value) => controller.stock.value = int.parse(value),
//               decoration: const InputDecoration(labelText: 'Stok'),
//             ),
//             TextFormField(
//               onChanged: (value) => controller.qty.value = int.parse(value),
//               decoration: const InputDecoration(labelText: 'Qty'),
//             ),
//             TextFormField(
//               onChanged: (value) => controller.sku.value = value,
//               decoration: const InputDecoration(labelText: 'SKU'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Get.bottomSheet(
//                   AddVariantForm(),
//                   isDismissible: false,
//                 );
//               },
//               child: const Text('Tambah Varian'),
//             ),
//             Obx(() => Column(
//                   children: controller.variants.map((variant) {
//                     return Column(
//                       children: [
//                         Text('Kategori Varian: ${variant.option}'),
//                         Text('Opsi Varian: ${variant.options.join(", ")}'),
//                         Text(
//                             'Harga: ${variant.prices.map((price) => price.price.toString()).join(", ")}'),
//                         Text(
//                             'Stok: ${variant.prices.map((price) => price.stock.toString()).join(", ")}'),
//                         Text(
//                             'SKU: ${variant.prices.map((price) => price.sku).join(", ")}'),
//                       ],
//                     );
//                   }).toList(),
//                 )),
//             ElevatedButton(
//               onPressed: () async {
//                 // await controller.saveProductToFirestore();
//                 for (var element in controller.variants) {
//                   print("Option : ${element.option}");
//                   for (var element2 in element.options) {
//                     print("Options : $element2");
//                   }
//                   for (var element3 in element.prices) {
//                     print("Prices Option: ${element3.option}");
//                     print("Prices: ${element3.price}");
//                     print("Prices SKU: ${element3.sku}");
//                     print("Prices Stock: ${element3.stock}");
//                   }
//                 }
//               },
//               child: const Text('Simpan Produk ke Firestore'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AddVariantForm extends StatelessWidget {
//   final TextEditingController optionController = TextEditingController();
//   final TextEditingController optionsController = TextEditingController();
//   final TextEditingController priceController = TextEditingController();
//   final TextEditingController stockController = TextEditingController();
//   final TextEditingController skuController = TextEditingController();
//   final UserManagementController controller = Get.find();

//   AddVariantForm({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           TextFormField(
//             controller: optionController,
//             decoration: const InputDecoration(labelText: 'Kategori Varian'),
//           ),
//           TextFormField(
//             controller: optionsController,
//             decoration: const InputDecoration(
//                 labelText: 'Opsi Varian (pisahkan dengan koma)'),
//           ),
//           TextFormField(
//             controller: priceController,
//             decoration: const InputDecoration(
//                 labelText: 'Harga (pisahkan dengan koma)'),
//           ),
//           TextFormField(
//             controller: stockController,
//             decoration:
//                 const InputDecoration(labelText: 'Stok (pisahkan dengan koma)'),
//           ),
//           TextFormField(
//             controller: skuController,
//             decoration:
//                 const InputDecoration(labelText: 'SKU (pisahkan dengan koma)'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final option = optionController.text;
//               final options = optionsController.text
//                   .split(',')
//                   .map((option) => option.trim())
//                   .toList();
//               final prices = priceController.text
//                   .split(',')
//                   .map((price) => int.parse(price.trim()))
//                   .toList();
//               final stocks = stockController.text
//                   .split(',')
//                   .map((stock) => int.parse(stock.trim()))
//                   .toList();
//               final skus = skuController.text
//                   .split(',')
//                   .map((sku) => sku.trim())
//                   .toList();

//               final productVariant = NewVariant(
//                 option: option,
//                 options: options,
//                 prices: [],
//               );

//               for (int i = 0; i < options.length; i++) {
//                 final optionMap = <String, String>{};

//                 for (final option in option.split(',')) {
//                   final parts = option.split(':');
//                   if (parts.length == 2) {
//                     optionMap[parts[0].trim()] = parts[1].trim();
//                   }
//                 }

//                 final productPrice = ProductPrice(
//                   option: optionMap,
//                   price: prices[i],
//                   stock: stocks[i],
//                   sku: skus[i],
//                 );

//                 productVariant.prices.add(productPrice);
//               }

//               controller.addVariant(productVariant);
//               Get.back();
//             },
//             child: const Text('Simpan Varian'),
//           ),
//         ],
//       ),
//     );
//   }
// }
