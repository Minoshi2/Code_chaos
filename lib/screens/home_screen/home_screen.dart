import 'package:drowsiness_app/components/custom_header.dart';
import 'package:drowsiness_app/components/custom_text.dart';
import 'package:drowsiness_app/screens/camera_screen/camera_screen.dart';
import 'package:drowsiness_app/screens/tracking_screen/tracking_screen.dart';
import 'package:drowsiness_app/utils/app_color.dart';
import 'package:drowsiness_app/utils/constants.dart';
import 'package:drowsiness_app/utils/util_functions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = UtillFunction.mediaQuery(context);
    return Scaffold(
      body: Column(
        children: [
          HeaderSection(
            size: size,
            image: 'top.png',
            widget: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomText(text: "Tesla", fontSize: 25.0,),
                      CustomText(text: "Car Type", fontSize: 13.0,),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,),
            child: Image.asset(Constants.imageAsset('car.png')),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () {}, 
          //       child: CustomText(text: "Click Here",)),
          //     SettingSection(),
          //     SettingSection(),
          //   ],
          // ),
          ApplicationStartSection(img: 'car.png', text: 'Start', tagline: 'Start the application', icon: Icons.car_rental, screen: CameraScreen(),),
          SizedBox(height: 10.0,),
          ApplicationStartSection(img: 'location.png', text: 'Location', tagline: 'Nearest Coffee Shop', icon: Icons.coffee, screen: TrackingScreen(),),
        ],
      ),  
    );
  }
}

class ApplicationStartSection extends StatelessWidget {
  const ApplicationStartSection({
    required this.img,
    required this.text,
    required this.tagline,
    required this.icon,
    required this.screen,
    Key? key,
  }) : super(key: key);

  final String img;
  final String text;
  final String tagline;
  final IconData icon;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: () {
          UtillFunction.navigateTo(context, screen);
        },
        child: Container(
          decoration: BoxDecoration(
            color: kwhite,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 20,
                color: Colors.black12
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 120.0,
                    height: 120.0,
                    margin: EdgeInsets.only(right: 20,),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Image.asset(Constants.iconAsset(img)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: text,
                        fontSize: 20.0,
                      ),
                      CustomText(
                        text: tagline,
                        fontSize: 14.0,
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(icon),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class SettingSection extends StatelessWidget {
//   const SettingSection({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Column(
//         children: [
//           Container(
//             width: 106.0,
//             height: 69.0,
//             padding: EdgeInsets.all(17.0),
//             decoration: BoxDecoration(
//               color: korange,
//               borderRadius: BorderRadius.circular(15.0)
//             ),
//             child: Image.asset(Constants.iconAsset('location.png')),
//           ),
//           CustomText(
//             text: 'Drowsiness \n     Level'
//           ),
//         ],
//       ),
//     );
//   }
// }