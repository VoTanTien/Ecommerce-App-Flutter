import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';

class AddressItem extends StatefulWidget{
  final name;
  final phone;
  final address;
  final isDefault;
  const AddressItem({Key? key, required this.name, required this.phone, required this.address, required this.isDefault,}) : super(key: key) ;
  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  bool isChecked = false;
  var _name;
  var _phone;
  var _address;
  var _isDefault;

  @override
  void initState() {
    _name = widget.name;
    _phone = widget.phone;
    _address = widget.address;
    _isDefault= widget.isDefault;
    isChecked = _isDefault;
  }

  @override
  Widget build(BuildContext context) {
    // print(_name);
    // print(_phone);
    // print(_address);
    // print(_isDefault);
    return Column(
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(_name,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,),
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      thickness: 1,
                      width: 15,
                    ),
                    Text(_phone,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Text(_address,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white,),
              ),
              if (_isDefault)
                Text('Default',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: redColor,),
                ),
            ],
          ),
          leading: Checkbox(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              side: BorderSide(color: Colors.white, width: 2),
              activeColor: redColor,
              value: isChecked,
              onChanged:(bool? value){
                setState(() {
                  isChecked = value!;
                });
              }
          ),
        ),
        Divider(
          color: Colors.white,
          height: 20,
          thickness: 1,
        ),
      ],
    );
  }
}