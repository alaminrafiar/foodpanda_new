import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodpanda/widget/custom_text_field.dart';
import 'package:foodpanda/widget/error_dailog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class register_screen extends StatefulWidget {
  const register_screen({Key? key}) : super(key: key);

  @override
  State<register_screen> createState() => _register_screenState();
}

class _register_screenState extends State<register_screen> {
  // final GlobalKey<FromState> _formKey = GlobalKey<FromState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController confirmPasswordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  XFile? imageXfile;
  final ImagePicker _picker = ImagePicker();

  Position? position;
  List<Placemark>? placemarks; //location dekhar jonnno aita use kora hoi

  Future<void> _getImage() async {
    imageXfile = await _picker.pickImage(source: ImageSource.gallery);
// kono image add korar jonno ai code use kora hoi ,,niche sodo ai container sathe porichoi koriye dilei hobe
    setState(() {
      imageXfile;
    });
  }

  getCurrentLocation() async {
    //location dekhar jonno aitao
    Position newPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = newPosition;
    placemarks = await placemarkFromCoordinates(
      position!.latitude,
      position!.longitude,
    );
    Placemark pMark = placemarks![0];
    String completeAddress =
        '${pMark.subThoroughfare} ${pMark.thoroughfare}, ${pMark.subLocality}, ${pMark.locality}, ${pMark.subAdministrativeArea}, ${pMark.administrativeArea} ${pMark.postalCode}, ${pMark.country}';

    locationcontroller.text = completeAddress;
  }

  //ai porjonto shop location ar jonno use kora hoise

  Future<void> formValidation() async {
    if (imageXfile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return Error_dailog(
              message: "Please Selected an image.",
            );
          });
    } else {
      if (passwordcontroller.text == confirmPasswordcontroller.text) {
        //start uploading image
        if (confirmPasswordcontroller.text.isNotEmpty &&
            emailcontroller.text.isNotEmpty &&
            namecontroller.text.isNotEmpty &&
            phonecontroller.text.isNotEmpty &&
            locationcontroller.text.isNotEmpty)
        {
          //start uploading image
        }
        else
        {
          showDialog(
              context: context,
              builder: (c) {
                return Error_dailog(
                  message: "Please write the required info for Registration",
                );
              });
        }
      } else {
        showDialog(
            context: context,
            builder: (c) {
              return Error_dailog(
                message: "password Not match.",
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 17,
            ),
            InkWell(
              onTap: () {
                _getImage(); // image add korar jonno use kora hoi (coding Cafe.video number 8)
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imageXfile == null
                    ? null
                    : FileImage(File(imageXfile!.path)),
                child: imageXfile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        size: MediaQuery.of(context).size.width * 0.20,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              // key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    data: Icons.person,
                    controller: namecontroller,
                    hintText: "Name",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.email,
                    controller: emailcontroller,
                    hintText: "Email",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: passwordcontroller,
                    hintText: "Password",
                    isObsecre: true,
                  ),
                  CustomTextField(
                    data: Icons.lock_open,
                    controller: confirmPasswordcontroller,
                    hintText: "Confirm_Password",
                    isObsecre: true,
                  ),
                  CustomTextField(
                    data: Icons.phone,
                    controller: phonecontroller,
                    hintText: "Phone Number",
                    isObsecre: false,
                  ),
                  CustomTextField(
                    data: Icons.place_rounded,
                    controller: locationcontroller,
                    hintText: " Location/Cafe",
                    isObsecre: false,
                    enbled: false,
                  ),
                  Container(
                    width: 400,
                    height: 40,
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      label: const Text(
                        "Get My Current Location",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: const Icon(
                        Icons.location_on,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        getCurrentLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                ),
                onPressed: () {
                  formValidation();
                }),
          ],
        ),
      ),
    );
    // return Column(
    //   children: [
    //     CustomTextField(
    //       controller: anycontroller,
    //       data: Icons.phone,
    //       hintText: "Phone",
    //       isObsecre: false,
    //       // aite dile container ar bitore ja ja lekhbo ta kiso dekha jabe na
    //       enbled:
    //           true, //aita container ar bitore kiso lekha hoitase kina ta dekha jabe na
    //     ),
    //     CustomTextField(
    //       controller: anycontroller,
    //       data: Icons.lock,
    //       hintText: "Lock",
    //       isObsecre: false,
    //       // aite dile container ar bitore ja ja lekhbo ta kiso dekha jabe na
    //       enbled:
    //           true, //aita container ar bitore kiso lekha hoitase kina ta dekha jabe na
    //     ),
    //   ],
    // );
  }
}
