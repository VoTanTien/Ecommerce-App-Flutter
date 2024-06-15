import 'package:flutter/cupertino.dart';
import 'package:t_t_project/constants/image_strings.dart';
import 'package:t_t_project/objects/comment.dart';

class CommentManager {
  static final CommentManager _instance = CommentManager._internal();

  factory CommentManager() {
    return _instance;
  }

  CommentManager._internal();

  List<Comment> comments = [
    Comment('Vo Tan Tien', 4.0,
        'Nice product and very good quality', AssetImage(lt4s)),
    Comment('Nguyen Chau Thang', 4.0,
        'Nice product', null),
    Comment('Nguyen Van Thien', 5.0,
        'very good', null),
  ];

// Thêm các phương thức để thao tác với danh sách addresses ở đây
// void addAddress(Address newAddress) {
//   addresses.add(newAddress);
// }
//
// void removeAddress(Address addressToRemove) {
//   addresses.remove(addressToRemove);
// }
}