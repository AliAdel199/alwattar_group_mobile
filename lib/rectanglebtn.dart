

import 'package:flutter/material.dart';

class RectangleButton extends StatelessWidget {
  RectangleButton(
      {super.key,
        required this.title,
        required this.bgColor,
        required this.width,
        required this.onPressed,this.height=40,this.hasIcon=false});
  String? title;
  Color? bgColor;
  double? width;
   double? height;
   bool? hasIcon;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: width!,
          height: height!,
          child: ElevatedButton(
              onPressed: onPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(bgColor!),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
      
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 hasIcon!? Padding(
                   padding: const EdgeInsets.only(left: 5.0),
                   child: Image.asset('assets/images/add 1.png',width: 20,),
                 ):Container(),
                  Text(
                    title!,
                    style: const TextStyle(
                      fontFamily: 'Tajawal-Light',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ))
        // Container(child: Center(child:
        // Text(title!,style:  TextStyle(
        //             fontFamily: 'Tajawal-Light',fontSize: 20,
        //             color:  Colors.white,
        //           ),),
      ),
    );
  }
}
