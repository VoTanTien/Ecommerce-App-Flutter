import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:t_t_project/constants/colors.dart';
import 'package:t_t_project/objects/address.dart';

class AddressItem extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final VoidCallback onTap;

  const AddressItem({Key? key, required this.address, required this.isSelected, required this.onTap,}) : super(key: key) ;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Row(
                  children: [
                    Text(address.name,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        color: Colors.white,),
                    ),
                    VerticalDivider(
                      color: Colors.white,
                      thickness: 1,
                      width: 15,
                    ),
                    Text(address.phone,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Text(address.address,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white,),
              ),
              if (address.isDefault)
                Text('Default',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: redColor,),
                ),
            ],
          ),
          leading: Radio<String>( // Use Radio instead of Checkbox
            value: address.id,
            groupValue: isSelected ? address.id : null, // Manage selection
            onChanged: (value) {
              onTap();
            },
          ),
          onTap: onTap,
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