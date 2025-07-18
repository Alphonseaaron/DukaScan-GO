import 'package:flutter/material.dart';
import 'package:restaurant/presentation/components/components.dart';
import 'package:restaurant/presentation/screens/client/cart_client_screen.dart';
import 'package:restaurant/presentation/screens/client/client_home_screen.dart';
import 'package:restaurant/presentation/screens/client/profile_client_screen.dart';
import 'package:restaurant/presentation/screens/client/search_client_screen.dart';
import 'package:restaurant/presentation/themes/colors_frave.dart';

class BottomNavigationFrave extends StatelessWidget {

  final int index;
  final ValueChanged<int> onChanged;

  BottomNavigationFrave({required this.index, required this.onChanged});

  @override
  Widget build(BuildContext context){
    
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: -5)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _ItemButton(
            i: 0, 
            index: index, 
            iconData: Icons.home_outlined, 
            text: 'Home',
            onPressed: () => onChanged(0),
            ),
          _ItemButton(
            i: 1, 
            index: index, 
            iconData: Icons.qr_code_scanner_outlined,
            text: 'Scan',
            onPressed: () => onChanged(1),
            ),
          _ItemButton(
            i: 2, 
            index: index, 
            iconData: Icons.shopping_bag_outlined,
            text: 'Orders',
            onPressed: () => onChanged(2),
          ),
          _ItemButton(
            i: 3, 
            index: index, 
            iconData: Icons.person_outline_outlined, 
            text: 'Profile',
            onPressed: () => onChanged(3),
            ),
        ],
      )
    );
  }
}

class _ItemButton extends StatelessWidget {
  
  final int i;
  final int index;
  final IconData iconData;
  final String text;
  final VoidCallback? onPressed;

  const _ItemButton({ required this.i, required this.index, required this.iconData, required this.text, this.onPressed });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: ( i == index ) ? ColorsFrave.primaryColor.withOpacity(.9) : Colors.transparent,
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: ( i == index ) 
          ? Row(
            children: [
                Icon(iconData, color: Colors.white, size: 25),
                const SizedBox(width: 6.0),
                TextCustom(text: text, fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500 )
              ],
            )
          :  Icon(iconData, size: 28),
      ),
    );
  }
}