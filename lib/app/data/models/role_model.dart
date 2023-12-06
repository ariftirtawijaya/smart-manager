import 'package:cloud_firestore/cloud_firestore.dart';

enum PermissionType {
  product,
  category,
  employee,
  paymentMethod,
  customer,
  order,
  preOrder,
  historyTransaction,
  report,
  roles,
  inventory,
  returnPermission,
  storeSettings,
}

Permission checkPermission(RoleModel role, PermissionType permissionType) {
  late Permission specificPermission;
  for (var permission in role.permission) {
    if (permission.containsKey(permissionType)) {
      specificPermission = permission[permissionType]!;
    }
  }

  return specificPermission;
}

class RoleModel {
  String id;
  String name;
  String? description;
  bool active;
  List<Map<PermissionType, Permission>> permission;

  RoleModel({
    required this.id,
    required this.name,
    this.description,
    required this.active,
    required this.permission,
  });

  @override
  String toString() {
    return 'RoleModel{name: $name, description: $description, isActive: $active, permission: $permission}';
  }

  factory RoleModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return RoleModel(
      id: snapshot.id,
      name: data["name"],
      active: data["active"],
      description: data["description"],
      permission:
      List<Map<PermissionType, Permission>>.from(data["permission"].map(
            (x) => Map.from(x).map(
              (k, v) {
            final permissionType = _getPermissionTypeFromString(k);
            return MapEntry<PermissionType, Permission>(
                permissionType, Permission.fromJson(v));
          },
        ),
      )),
    );
  }

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json["id"],
        name: json["name"],
        active: json["active"],
        description: json["description"],
        permission:
            List<Map<PermissionType, Permission>>.from(json["permission"].map(
          (x) => Map.from(x).map(
            (k, v) {
              final permissionType = _getPermissionTypeFromString(k);
              return MapEntry<PermissionType, Permission>(
                  permissionType, Permission.fromJson(v));
            },
          ),
        )),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "permission": List<dynamic>.from(permission.map(
          (x) => Map.from(x).map(
            (k, v) => MapEntry<String, dynamic>(
                k.toString().split('.').last, v.toJson()),
          ),
        )),
      };

  static PermissionType _getPermissionTypeFromString(String type) {
    print(type);
    if (type.contains("_")) {}
    return PermissionType.values.firstWhere(
      (e) => e.toString().split('.').last == type,
      orElse: () => PermissionType.product,
    );
  }
}

class Permission {
  bool add;
  bool view;
  bool edit;
  bool delete;

  Permission({
    required this.add,
    required this.view,
    required this.edit,
    required this.delete,
  });
  @override
  String toString() {
    return 'Permission{add: $add, view: $view, edit: $edit, delete: $delete}';
  }

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        add: json["add"],
        view: json["view"],
        edit: json["edit"],
        delete: json["delete"],
      );

  Map<String, dynamic> toJson() => {
        "add": add,
        "view": view,
        "edit": edit,
        "delete": delete,
      };
}
