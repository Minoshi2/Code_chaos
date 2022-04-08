import 'package:carousel_slider/carousel_slider.dart';
import 'package:drowsiness_app/screens/login_screen/login_screen.dart';
import 'package:drowsiness_app/utils/app_color.dart';
import 'package:drowsiness_app/utils/constants.dart';
import 'package:drowsiness_app/utils/util_functions.dart';
import 'package:flutter/material.dart';

class GettingStarted extends StatefulWidget {
  const GettingStarted({ Key? key }) : super(key: key);

  @override
  _GettingStartedState createState() => _GettingStartedState();
}

class _GettingStartedState extends State<GettingStarted> {
  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;
  List<Widget> list = [
    SliderItem(
      img: "driver.png", 
      text1: "Safety First", 
      text2: "Our own safety is the best prevention\nfor ourselves from the accident.",
    ), 
    SliderItem(
      img: "drowsy.png", 
      text1: "No Drowsiness", 
      text2: "Catch up on your beauty sleep before\ndriving.",
    ),  
    SliderItem(
      img: "tracking.png", 
      text1: "Coffee Shop", 
      text2: "If you feel drowsy you can go the\nnearest coffee shop.",
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    var size = UtillFunction.mediaQuery(context);
    return Scaffold(
      body: Container(
        // width: size.width,
        // height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: size.height / 2,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }
              ),
              carouselController: buttonCarouselController,
              items: list.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      child: Column(
                        children: [i],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: list.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => buttonCarouselController.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key ? Colors.blue : greyColor,
                    ),    
                  ),
                );
              }).toList(),
            ),
            BottomSection(size: size, ontap: () => buttonCarouselController.nextPage(),),
          ],
        ),
      ),
    );
  }
}

class SliderItem extends StatelessWidget {
  const SliderItem({ 
    required this.img,
    required this.text1,
    required this.text2,
    Key? key,

    }) : super(key: key);

  final String img;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          Constants.imageAsset(img)
        ),
        SizedBox(height: 37.0,),
        Text(
          text1,
          style: TextStyle(
            fontSize: 22.0,
          ),
        ),
        SizedBox(height: 5.0,),
        Text(
          text2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
            color: greyColor,
          ),
        )
      ],
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection({
    Key? key,
    required this.size,
    required this.ontap
  }) : super(key: key);

  final size;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(Constants.
            imageAsset('bottom.png'),
            width: size.width,
            fit: BoxFit.fitWidth,  
          ),
          Positioned(
            bottom: 39.0,
            right: 43.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: ontap,
                  child: Text(
                    'Next',
                    style: TextStyle(
                      color: kblack,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: kwhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    )
                  ),
                ),
                TextButton(
                  onPressed: () => UtillFunction.navigateTo(context, LoginPage()), 
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: kblack,
                    ),
                  )  
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}