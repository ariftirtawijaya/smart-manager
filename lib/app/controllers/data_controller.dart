import 'package:get/get.dart';
import 'package:smart_manager/app/data/models/user_model.dart';
import 'package:smart_manager/app/data/services/db_service.dart';

class DataController extends GetxController {
  var users = RxList<UserModel>([]);
  RxBool isLoading = false.obs;

  Future<void> getUsers() async {
    isLoading.value = true;
    final querySnapshot = await DBService.getCollections(
        from: 'users', where: 'role', isEqualTo: 'user');
    clear();
    for (var element in querySnapshot.docs) {
      users.add(UserModel.fromSnapshot(element));
    }
    isLoading.value = false;
  }

  void clear() {
    users.clear();
  }
}
