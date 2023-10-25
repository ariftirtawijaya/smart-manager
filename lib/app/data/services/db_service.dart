import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class DBService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference usersCollections =
      FirebaseFirestore.instance.collection('users');
  static final box = GetStorage();
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static saveToLocal({required String key, required dynamic value}) {
    return box.write(key, value);
  }

  static getLocalData({required String key}) {
    return box.read(key);
  }

  static removeLocalData({required String key}) {
    return box.remove(key);
  }

  static Future<UserCredential> login(
      {required String email, required String password}) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> insert({
    required String into,
    required String name,
    required Map<String, dynamic> data,
  }) {
    return FirebaseFirestore.instance.collection(into).doc(name).set(data);
  }

  static Future<void> delete({
    required String from,
    required String name,
  }) {
    return FirebaseFirestore.instance.collection(from).doc(name).delete();
  }

  static Future<void> update({
    required String from,
    required String name,
    required Map<String, dynamic> data,
  }) {
    return FirebaseFirestore.instance.collection(from).doc(name).update(data);
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getCollections({
    String? where,
    required String from,
    String? isEqualTo,
    String? isNotEqualTo,
    String? isLessThan,
    String? isLessThanOrEqualTo,
    String? isGreaterThan,
    String? isGreaterThanOrEqualTo,
    String? arrayContains,
    Iterable<Object?>? arrayContainsAny,
    Iterable<Object?>? whereIn,
    Iterable<Object?>? whereNotIn,
    bool? isNull,
  }) async {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection(from);

    if (where != null) {
      if (isEqualTo != null) {
        query = query.where(where, isEqualTo: isEqualTo);
      } else if (isNotEqualTo != null) {
        query = query.where(where, isNotEqualTo: isNotEqualTo);
      } else if (isLessThan != null) {
        query = query.where(where, isLessThan: isLessThan);
      } else if (isLessThanOrEqualTo != null) {
        query = query.where(where, isLessThanOrEqualTo: isLessThanOrEqualTo);
      } else if (isGreaterThan != null) {
        query = query.where(where, isGreaterThan: isGreaterThan);
      } else if (isGreaterThanOrEqualTo != null) {
        query =
            query.where(where, isGreaterThanOrEqualTo: isGreaterThanOrEqualTo);
      } else if (arrayContains != null) {
        query = query.where(where, arrayContains: arrayContains);
      } else if (arrayContainsAny != null) {
        query = query.where(where, arrayContainsAny: arrayContainsAny);
      } else if (whereIn != null) {
        query = query.where(where, whereIn: whereIn);
      } else if (whereNotIn != null) {
        query = query.where(where, whereNotIn: whereNotIn);
      } else if (isNull == true) {
        query = query.where(where, isNull: true);
      }
    }

    return query.get();
  }

  // static Future<QuerySnapshot<Map<String, dynamic>>> getCollections(
  //     {Object? where,
  //     Object? isEqualTo,
  //     Object? isNotEqualTo,
  //     Object? isLessThan,
  //     Object? isLessThanOrEqualTo,
  //     Object? isGreaterThan,
  //     Object? isGreaterThanOrEqualTo,
  //     Object? arrayContains,
  //     Iterable<Object?>? arrayContainsAny,
  //     Iterable<Object?>? whereIn,
  //     Iterable<Object?>? whereNotIn,
  //     bool? isNull,
  //     required String from}) async {
  //   if (where != null) {
  //     return FirebaseFirestore.instance.collection(from).where(where).get();
  //   } else {
  //     return FirebaseFirestore.instance.collection(from).get();
  //   }
  // }

  static Future<DocumentSnapshot<Map<String, dynamic>>> getDocument(
      {required String from, required String doc}) async {
    return FirebaseFirestore.instance.collection(from).doc(doc).get();
  }
}
