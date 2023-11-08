import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserManagementController extends GetxController {}
// class UserManagementController extends GetxController {
//   var name = ''.obs;
//   var category = ''.obs;
//   var description = ''.obs;
//   var image = ''.obs;
//   var stock = 0.obs;
//   var qty = 0.obs;
//   var sku = ''.obs;
//   var variants = <NewVariant>[].obs;

//   void addVariant(NewVariant variant) {
//     variants.add(variant);
//   }

//   Future<void> saveProductToFirestore() async {
//     try {
//       final productData = {
//         'name': name.value,
//         'category': category.value,
//         'description': description.value,
//         'image': image.value,
//         'stock': stock.value,
//         'qty': qty.value,
//         'sku': sku.value,
//       };

//       final productRef = await FirebaseFirestore.instance
//           .collection('products')
//           .add(productData);

//       for (final variant in variants) {
//         for (final price in variant.prices) {
//           final variantData = {
//             'option': variant.option,
//             'price': price.price,
//             'stock': price.stock,
//             'sku': price.sku,
//           };

//           for (final option in price.option.entries) {
//             variantData[option.key] = option.value;
//           }

//           await productRef.collection('variant_prices').add(variantData);
//         }
//       }

//       Get.snackbar('Sukses', 'Produk berhasil disimpan ke Firestore');
//     } catch (error) {
//       Get.snackbar('Error', 'Terjadi kesalahan: $error');
//     }
//   }
// }
