import 'dart:async';
import 'package:drowsiness_app/components/custom_text.dart';
import 'package:drowsiness_app/utils/constants.dart';
import 'package:drowsiness_app/utils/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({ Key? key }) : super(key: key);

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(kGooglePlex: _kGooglePlex, controller: _controller),
          FooterSection()
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the coffee shop!'),
        icon: Icon(Icons.coffee),
      ),
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: UtillFunction.mediaQuery(context).height/2,
        child: Stack(
          children: [
            Image.asset(Constants.imageAsset('tracking-footer.png'),
            width: UtillFunction.mediaQuery(context).width,
            fit: BoxFit.fill,
            ),
            Positioned(
              top: 87.0,
              left: 32.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Time',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: 5.0,),
                  Row(
                    children: [
                      Icon(Icons.timer),
                      SizedBox(width: 5.0,),
                      CustomText(
                        text: '20 Min',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                  SizedBox(height: 30.0,),
                  TrackingDetails(status: 'order confirmed', statusText: 'Your order has been confirmed',),
                  SizedBox(height: 30.0,),
                  TrackingDetails(status: 'order confirmed', statusText: 'Your order has been confirmed',),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TrackingDetails extends StatelessWidget {
  const TrackingDetails({
    required this.status,
    required this.statusText,
    Key? key,
  }) : super(key: key);

  final String status;
  final String statusText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(Constants.iconAsset('check.png')),
        SizedBox(width: 24.0,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: status,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 5.0,),
            CustomText(
              text: statusText,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ],
        )
      ],
    );
  }
}

class MapWidget extends StatelessWidget {
  const MapWidget({
    Key? key,
    required CameraPosition kGooglePlex,
    required Completer<GoogleMapController> controller,
  }) : _kGooglePlex = kGooglePlex, _controller = controller, super(key: key);

  final CameraPosition _kGooglePlex;
  final Completer<GoogleMapController> _controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 529,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          Marker(markerId: MarkerId("0"),
          position: LatLng(37.43296265331129, -122.08832357078792),
          ),
        },
      ),
    );
  }
}