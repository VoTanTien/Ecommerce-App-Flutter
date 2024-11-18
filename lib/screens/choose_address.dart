import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/common_widget/address_item.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/objects/address.dart';
import 'package:t_t_project/screens/new_address.dart';
import 'package:t_t_project/services/database_service.dart';



class AddressScreen extends StatefulWidget{
  final Address? initiallySelectedAddress;

  const AddressScreen({Key? key, this.initiallySelectedAddress}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<Address> _addresses = [];
  String? _selectedAddressId;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
    _selectedAddressId = widget.initiallySelectedAddress?.id;
  }

  Future<void> _loadAddresses() async{
    try{
      final addresses = await DatabaseService().getAddressesForUser();
      setState(() {
        _addresses = addresses;
      });
    }catch (e){
      print('Error load addresses: $e');
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: blackColor,
          appBar: AppBar(
            title: Text('Delivery Address',
                style: GoogleFonts.inter(
                    fontSize: 26,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            centerTitle: true,
            backgroundColor: blackColor,
            leading: BackButton(
              color: Colors.white,
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                children: [
                  Wrap(
                    runSpacing: 10,
                    children: _addresses.map((address) {
                      return AddressItem(
                        address: address,
                        isSelected: address.id == _selectedAddressId,
                        onTap: () {
                          setState(() {
                            _selectedAddressId = address.id;
                          });
                          Navigator.pop(context, address); // Return selected address
                        },
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      backgroundColor: redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (cntext) => NewAddress()));
                    },
                    child: Text(
                      'Add new address',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}