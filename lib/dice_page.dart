 import 'package:dice/roller_dice.dart';
import 'package:flutter/material.dart';

const beginAligment=Alignment.topCenter;
const endAligment=Alignment.bottomCenter;

class DicePage extends StatelessWidget{
  const DicePage({super.key,required this.colors});
final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin:beginAligment,
          end:endAligment,
          )),
         child:const Center(child: RollerDice()),
    );
}
}