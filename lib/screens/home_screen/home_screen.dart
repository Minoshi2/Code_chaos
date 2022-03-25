import 'package:drowsiness_app/components/custom_header.dart';
import 'package:drowsiness_app/components/custom_text.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {}, 
                child: CustomText(text: "Click Here",)),
              SettingSection(),
              SettingSection(),
            ],
          ),
          SizedBox(height: 10.0,),
          ApplicationStartSection()
        ],
      ),  
    );
  }
}

class ApplicationStartSection extends StatelessWidget {
  const ApplicationStartSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                          child: Image.asset(Constants.iconAsset('car.png')),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 5.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Start',
                      fontSize: 14.0,
                    ),
                    CustomText(
                      text: 'Start the application',
                      fontSize: 12.0,
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class SettingSection extends StatelessWidget {
  const SettingSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 106.0,
            height: 69.0,
            padding: EdgeInsets.all(17.0),
            decoration: BoxDecoration(
              color: korange,
              borderRadius: BorderRadius.circular(15.0)
            ),
            child: Image.asset(Constants.iconAsset('location.png')),
          ),
          CustomText(
            text: 'Drowsiness \n     Level'
          ),
        ],
      ),
    );
  }
}