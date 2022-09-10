import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

class ShareAppDemo extends StatefulWidget {
  const ShareAppDemo({Key? key}) : super(key: key);

  @override
  State<ShareAppDemo> createState() => _ShareAppDemoState();
}

class _ShareAppDemoState extends State<ShareAppDemo> {
  //-----------------------------------------------------Variables---------------------------------------------------------------------------//
  String text = '';
  List<String> images = [];
  @override
  Widget build(BuildContext context) {
    //--------------------------------------------------------------------------UI------------------------------------------------------------//
    return Scaffold(
      ///AppBar--------//
      appBar: AppBar(
        title: const Text("Share App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          ///TextField-------------///
          TextField(
              decoration: const InputDecoration(
                labelText: 'Share text:',
              ),
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              }),
          const SizedBox(height: 20),

          ///buildListTile (Images)-------------------///
          buildListTile(),
          const SizedBox(height: 20),

          ///ElevatedButton-------------------------///
          ElevatedButton(
            onPressed: text.isEmpty && images.isEmpty
                ? null
                : () {
                    sharePhotos();
                  },
            child: const Text('Share'),
          ),
        ]),
      ),
    );
  }

//----------------------------------------sharePhotos function--------------------------------------------------------------------//
  void sharePhotos() async {
    final box = context.findRenderObject() as RenderBox?;

    if (images.isNotEmpty) {
      await Share.shareFiles(images,
          text: text,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(text,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  //-------------------------------------------------buildListTile function------------------------------------------------------------- --//
  buildListTile() {
    return ListTile(
      leading: const Icon(Icons.add),
      title: const Text('Add image'),
      onTap: () async {
        final imagePicker = ImagePicker();
        final pickedFile = await imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (pickedFile != null) {
          setState(() {
            images.add(pickedFile.path);
          });
        }
      },
    );
  }
}
