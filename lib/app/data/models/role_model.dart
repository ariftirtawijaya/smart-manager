// // To parse this JSON data, do
// //
// //     final roleModel = roleModelFromJson(jsonString);

// import 'dart:convert';

// RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

// String roleModelToJson(RoleModel data) => json.encode(data.toJson());

// class RoleModel {
//   String name;
//   String description;
//   List<Permission> permission;

//   RoleModel({
//     required this.name,
//     required this.description,
//     required this.permission,
//   });

//   @override
//   String toString() {
//     return 'RoleModel(name: $name, description: $description, permission: $permission)';
//   }

//   factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
//         name: json["name"],
//         description: json["description"],
//         permission: List<Permission>.from(
//             json["permission"].map((x) => Permission.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "description": description,
//         "permission": List<dynamic>.from(permission.map((x) => x.toJson())),
//       };
// }

// class Permission {
//   Category? product;
//   Category? category;
//   Category? employee;
//   Category? paymentMethod;
//   Category? customer;
//   Category? order;
//   Category? preOrder;
//   Category? historyTransaction;
//   Category? report;
//   Category? roles;
//   Category? inventory;
//   Category? returnOrder;
//   Category? storeSetting;

//   Permission({
//     this.product,
//     this.category,
//     this.employee,
//     this.paymentMethod,
//     this.customer,
//     this.order,
//     this.preOrder,
//     this.historyTransaction,
//     this.report,
//     this.roles,
//     this.inventory,
//     this.returnOrder,
//     this.storeSetting,
//   });

//   @override
//   String toString() {
//     return 'Permission(product: $product, category: $category, employee: $employee, paymentMethod: $paymentMethod, customer: $customer, order: $order, preOrder: $preOrder, historyTransaction: $historyTransaction, report: $report, roles: $roles, inventory: $inventory, returnOrder: $returnOrder, storeSetting: $storeSetting)';
//   }

//   factory Permission.fromJson(Map<String, dynamic> json) => Permission(
//         product:
//             json["product"] == null ? null : Category.fromJson(json["product"]),
//         category: json["category"] == null
//             ? null
//             : Category.fromJson(json["category"]),
//         employee: json["employee"] == null
//             ? null
//             : Category.fromJson(json["employee"]),
//         paymentMethod: json["payment_method"] == null
//             ? null
//             : Category.fromJson(json["payment_method"]),
//         customer: json["customer"] == null
//             ? null
//             : Category.fromJson(json["customer"]),
//         order: json["order"] == null ? null : Category.fromJson(json["order"]),
//         preOrder: json["pre_order"] == null
//             ? null
//             : Category.fromJson(json["pre_order"]),
//         historyTransaction: json["history_transaction"] == null
//             ? null
//             : Category.fromJson(json["history_transaction"]),
//         report:
//             json["report"] == null ? null : Category.fromJson(json["report"]),
//         roles: json["roles"] == null ? null : Category.fromJson(json["roles"]),
//         inventory: json["inventory"] == null
//             ? null
//             : Category.fromJson(json["inventory"]),
//         returnOrder:
//             json["return"] == null ? null : Category.fromJson(json["return"]),
//         storeSetting: json["store_setting"] == null
//             ? null
//             : Category.fromJson(json["store_setting"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "product": product?.toJson(),
//         "category": category?.toJson(),
//         "employee": employee?.toJson(),
//         "payment_method": paymentMethod?.toJson(),
//         "customer": customer?.toJson(),
//         "order": order?.toJson(),
//         "pre_order": preOrder?.toJson(),
//         "history_transaction": historyTransaction?.toJson(),
//         "report": report?.toJson(),
//         "roles": roles?.toJson(),
//         "inventory": inventory?.toJson(),
//         "return": returnOrder?.toJson(),
//         "store_setting": storeSetting?.toJson(),
//       };
// }

// class Category {
//   bool add;
//   bool view;
//   bool edit;
//   bool delete;

//   Category({
//     required this.add,
//     required this.view,
//     required this.edit,
//     required this.delete,
//   });

//   @override
//   String toString() {
//     return 'Category(add: $add, view: $view, edit: $edit, delete: $delete)';
//   }

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         add: json["add"],
//         view: json["view"],
//         edit: json["edit"],
//         delete: json["delete"],
//       );

//   Map<String, dynamic> toJson() => {
//         "add": add,
//         "view": view,
//         "edit": edit,
//         "delete": delete,
//       };
// }

// To parse this JSON data, do
//
//     final roleModel = roleModelFromJson(jsonString);

import 'dart:convert';

List<RoleModel> roleModelFromJson(String str) =>
    List<RoleModel>.from(json.decode(str).map((x) => RoleModel.fromJson(x)));

String roleModelToJson(List<RoleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class RoleModel {
//   String name;
//   String description;
//   List<Map<String, Permission>> permission;

//   RoleModel({
//     required this.name,
//     required this.description,
//     required this.permission,
//   });

//   static void printRole(List<RoleModel> roles) {
//     for (var role in roles) {
//       print('Role Name: ${role.name}');
//       print('Description: ${role.description}');
//       for (var permission in role.permission) {
//         final key = permission.keys.first;
//         final permissionData = permission[key];
//         print('Permission for $key:');
//         print('  Add: ${permissionData?.add}');
//         print('  View: ${permissionData?.view}');
//         print('  Edit: ${permissionData?.edit}');
//         print('  Delete: ${permissionData?.delete}');
//       }
//       print('-------------------------');
//     }
//   }

//   factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
//         name: json["name"],
//         description: json["description"],
//         permission: List<Map<String, Permission>>.from(json["permission"].map(
//           (x) => Map.from(x).map(
//             (k, v) => MapEntry<String, Permission>(k, Permission.fromJson(v)),
//           ),
//         )),
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "description": description,
//         "permission": List<dynamic>.from(permission.map(
//           (x) => Map.from(x).map(
//             (k, v) => MapEntry<String, dynamic>(k, v.toJson()),
//           ),
//         )),
//       };

//   @override
//   String toString() {
//     return 'RoleModel{name: $name, description: $description, permission: $permission}';
//   }
// }

// class Permission {
//   bool add;
//   bool view;
//   bool edit;
//   bool delete;

//   Permission({
//     required this.add,
//     required this.view,
//     required this.edit,
//     required this.delete,
//   });

//   factory Permission.fromJson(Map<String, dynamic> json) => Permission(
//         add: json["add"],
//         view: json["view"],
//         edit: json["edit"],
//         delete: json["delete"],
//       );

//   Map<String, dynamic> toJson() => {
//         "add": add,
//         "view": view,
//         "edit": edit,
//         "delete": delete,
//       };

//   @override
//   String toString() {
//     return 'Permission{add: $add, view: $view, edit: $edit, delete: $delete}';
//   }
// }
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
  String name;
  String description;
  List<Map<PermissionType, Permission>> permission;

  RoleModel({
    required this.name,
    required this.description,
    required this.permission,
  });
  @override
  String toString() {
    return 'RoleModel{name: $name, description: $description, permission: $permission}';
  }

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        name: json["name"],
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
