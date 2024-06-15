import 'package:t_t_project/objects/address.dart';

class AddressManager {
  static final AddressManager _instance = AddressManager._internal();

  factory AddressManager() {
    return _instance;
  }

  AddressManager._internal();

  List<Address> addresses = [
    Address('Vo Tan Tien', '0379743117',
        '123 Street A, District 1, Ho Chi Minh City', true),
    Address('Vo Tan Tien', '0379743117',
        '456 Street A, District 1, Ho Chi Minh City', false),
    Address(
        'Vo Tan Tien', '0379743117', '789 Street A, District 1, Ho Chi Minh City',
        false),
  ];

  // Thêm các phương thức để thao tác với danh sách addresses ở đây
  void addAddress(Address newAddress) {
    addresses.add(newAddress);
  }

  void removeAddress(Address addressToRemove) {
    addresses.remove(addressToRemove);
  }
}