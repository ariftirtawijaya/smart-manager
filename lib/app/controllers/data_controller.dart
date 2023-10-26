import 'package:get/get.dart';
import 'package:smart_manager/app/constant/app_constant.dart';
import 'package:smart_manager/app/data/models/store_model.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';

class DataController extends GetxController {
  var users = RxList<UserModel>([]);
  Rx<StoreModel> store = StoreModel().obs;

  RxBool isLoading = false.obs;

  Future<void> getUsers() async {
    isLoading.value = true;
    final querySnapshot = await DBService.getCollections(
        from: usersRef, where: 'role', isEqualTo: 'user');
    clear();
    for (var element in querySnapshot.docs) {
      users.add(UserModel.fromSnapshot(element));
    }
    users.sort(
      (a, b) => a.name!.compareTo(b.name!),
    );
    isLoading.value = false;
  }

  Future<void> getStore(String uid) async {
    await DBService.getCollections(
            from: storesRef, where: 'userId', isEqualTo: uid)
        .then((result) {
      if (result.docs.isNotEmpty) {
        store.value = StoreModel.fromSnapshot(result.docs.first);
      }
    });
  }

  void clear() {
    users.clear();
  }
}
