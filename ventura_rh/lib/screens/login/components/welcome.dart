import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/responsive.dart';

class Welcome extends StatelessWidget {

  const Welcome({Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
   final Responsive responsive = Responsive.of(context);


    return AspectRatio(
      aspectRatio: 16 / 11,
      child: LayoutBuilder(
        builder: (_, constraints) {
          return Container(
            color: const Color.fromARGB(255, 128, 222, 234),
            child: Stack(
              children: [
                Positioned(
                  top: 19,
                  left: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/images/login/curriculo.svg',
                    height: constraints.maxHeight *0.6 ,

                  ),
                ),
                Positioned(
                  top: constraints.maxHeight*0.18,
                  right: 20,
                  child: SvgPicture.asset(
                    'assets/images/login/homen2.svg',
                    width: constraints.maxHeight * 0.21,
                  ),
                ),

                Positioned(
                  top: constraints.maxHeight*0.18,
                  left: 35,
                  child: SvgPicture.asset(
                    'assets/images/login/homen3.svg',
                    width: constraints.maxHeight * 0.25,
                  ),
                ),

                Positioned(
                  top: constraints.maxHeight *0.74,
                  child: Column(
                    children: [
                      Container(
                        height: 3,
                        width:constraints.maxWidth,
                        color: const Color(0xffb2ebf2),
                      ),
                      const SizedBox(height: 20,),
                       Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'raleway'
                        ),

                      ),
                    ],
                  ),
                ),


                Positioned(
                  top: constraints.maxHeight*0.48,
                  child: SvgPicture.asset(
                    'assets/images/login/homen.svg',
                    width: constraints.maxHeight * 0.21,
                  ),
                ),

                Positioned(
                  top: constraints.maxHeight*0.43,
                  right: 1,
                  child: SvgPicture.asset(
                    'assets/images/login/mulher1.svg',
                    width: constraints.maxHeight * 0.21,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


