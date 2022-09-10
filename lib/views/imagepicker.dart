import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageDemo extends StatefulWidget {
  const ImageDemo({Key? key}) : super(key: key);

  @override
  State<ImageDemo> createState() => _ImageDemoState();
}

class _ImageDemoState extends State<ImageDemo> {
  //-----------------------------------------------------Variables----------------------------------------------------------//
  Reference ref = FirebaseStorage.instance.ref("images");
  String? imagesUrls;
  ImagePicker imagePicker = ImagePicker();
  XFile? img;
  File? image;

  ///initState----------------------------------------///

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    //--------------------------------------------------------------------------UI------------------------------------------------------------//
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 100,
          ),
          Stack(children: [
            (image == null)
                ? const CircleAvatar(
                    radius: 80,
                  )
                : CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(image!),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 100, top: 120),
              child: CircleAvatar(
                radius: 20,
                child: GestureDetector(
                  onTap: () {
                    selectImages();
                  },
                  child: const Icon(Icons.camera_alt_outlined),
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 30,
          ),

          ///ElevatedButton (uploadImage)----------------//
          ElevatedButton(
              onPressed: () {
                uploadImage(image);
              },
              child: const Text("UploadImage"))
        ]),
      ),
    );
  }

//---------------------------------------------------------selectImages function--------------------------------------------------//
  void selectImages() {
    showModalBottomSheet(
        context: context,
        builder: (context) => SizedBox(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Profile Photo",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(children: [
                      ///camera pickImage----------------------------//
                      CircleAvatar(
                        radius: 30,
                        child: GestureDetector(
                            child: const Icon(Icons.camera_alt),
                            onTap: () async {
                              img = await imagePicker.pickImage(
                                  source: ImageSource.camera);
                              if (img != null) {
                                setState(() {
                                  image = File(img!.path);
                                  // uploadImage(image);
                                });
                              }
                              Navigator.pop(context);
                            }),
                      ),
                      const SizedBox(
                        width: 40,
                      ),

                      ///Gallery PickImage-------------------------------///
                      GestureDetector(
                        onTap: () async {
                          img = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (img != null) {
                            setState(() {
                              image = File(img!.path);
                              //   uploadImage(image);
                            });
                          }
                          Navigator.pop(context);
                        },
                        child: const CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.image),
                        ),
                      )
                    ]),
                  ],
                ),
              ),
            ));
  }

  //----------------------------------------------getImage function---------------------------------------------------------------//
  getImage() async {
    imagesUrls = await ref.getDownloadURL();
  }

//--------------------------------------------uploadImage function-------------------------------------------//
  uploadImage(File? image) async {
    await ref.child("123").putFile(image!);
  }
}
