import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';

class FetchContact extends StatefulWidget {
  const FetchContact({Key? key}) : super(key: key);

  @override
  State<FetchContact> createState() => _FetchContactState();
}

class _FetchContactState extends State<FetchContact> {
  //-----------------------------------------------------Variables---------------------------------------------------------------------------//
  List<Contact> contacts = [];
  @override

  ///initState----------------------------------------///
  void initState() {
    super.initState();
    getPhoneData();
  }

  @override
  Widget build(BuildContext context) {
    //--------------------------------------------------------------------------UI------------------------------------------------------------//
    return Scaffold(
      ///AppBAr----------------------------------------------///
      appBar: AppBar(
        title: const Text(
          "Contacts",
          style: TextStyle(color: Colors.blue),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),

      ///ListView ----------------------------///
      body: bulidListView(),
    );
  }

//-----------------------------------------------LunchUrl Function---------------------------------------------------------------//
  lunchNumber(String s) async {
    await launchUrl(
      Uri(scheme: 'tel', path: s),
    );
  }

//----------------------------------------getPhoneData Function---------------------------------------------------//
  Future<void> getPhoneData() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      setState(() {});
    }
  }

  ///bulidListView function-----------------------------------///
  bulidListView() {
    return ListView.builder(
      itemCount: contacts.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Uint8List? image = contacts[index].photo;
        String number = (contacts[index].phones.isNotEmpty)
            ? contacts[index].phones.first.number
            : "---";

        ///ListTile----------------------------------///
        return ListTile(
          leading: (image == null)
              ? const CircleAvatar(
                  child: Icon(Icons.person),
                )
              : CircleAvatar(
                  backgroundImage: MemoryImage(image),
                ),
          title: Text(contacts[index].displayName),
          subtitle: Text(number),
          onTap: () {
            if (contacts[index].phones.isNotEmpty) {
              lunchNumber(number);
            }
          },
        );
      },
    );
  }
}
