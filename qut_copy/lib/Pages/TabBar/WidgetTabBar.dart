


import 'package:flutter/material.dart';
import 'package:qut/Cubits/TabBarCubit.dart';
import 'package:qut/Views/MiniPlayerWidget.dart';

class WidgetTabBar extends StatelessWidget {


  TabBarCubit get _tabBarCubit {
    return MiniPlayerSingelton.shared.getCubit;
  }

  int get _selectedIndex {
    return _tabBarCubit?.state?.selectedIntdex ?? 0;
  }

  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 248,
      // color: Colors.white,
      child: _child,
      decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.1),
        spreadRadius: 5,
        blurRadius: 7,
        offset: Offset(0, 2), // changes position of shadow
      ),
    ],
  ),
    );
  }

 Row get _child {
   return Row(
     children: [
       SizedBox(width: 18),
       _button(0),
       SizedBox(width: 11),
       _button(1),
       SizedBox(width: 10),
       _button(2),
       SizedBox(width: 11),
       _button(3),
       SizedBox(width: 18),
     ]
   );
 }

Widget _button(int index) {
      return Container(
        width: 45,
        height: 45,

        child: Container(
          width: 22,
          height: 22,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: TextButton(
          onPressed: (){
            _tabBarCubit.newSelectedIndex(index);
          },
          child: _getImage(index)),
    )
              ),
            ),
    );
  }



  Image _getImage(int index){

    bool selected = _selectedIndex == index;

    String name = 'assets/icons/TabBarIcon/TabBar$index'; 
    String postfixName = selected ? '_selected.png' : '.png'; 

    return Image.asset(name + postfixName);
  }

}