import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:save_websites_with_hive/src/boxes.dart';
import 'package:save_websites_with_hive/src/models/website.dart';
import 'package:save_websites_with_hive/src/utils/app_theme.dart';

class WebsitesScreen extends StatefulWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => const WebsitesScreen(),
      );

  const WebsitesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _WebsitesScreenState createState() => _WebsitesScreenState();
}

class _WebsitesScreenState extends State<WebsitesScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController websiteNameController = TextEditingController();
  TextEditingController websiteUrlController = TextEditingController();
  String websiteName = "";
  String websiteUrl = "";
  @override
  void dispose() {
    // TODO 10 : Close Box
    Hive.box('websites').close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO 14 : Read All Box
      body: ValueListenableBuilder<Box<Website>>(
        valueListenable: Boxes.getWebsites().listenable(),
        builder: (context, box, _) {
          final websites = box.values.toList().cast<Website>();
          return buildContent(websites);
        },
      ),
    );
  }

  Widget buildContent(List<Website> websites) {
    if (websites.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            newWebsite(),
            const SizedBox(
              height: 50,
            ),
            const Text(
              "No websites yet!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            newWebsite(),
            Expanded(
                child: SizedBox(
              width: 500,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: websites.length,
                  itemBuilder: (BuildContext context, int index) {
                    final website = websites[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              website.websiteName,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(website.websiteUrl)),
                          Align(
                              alignment: Alignment.centerRight,
                              child: deleteWebsiteButton(
                                  websites[index].websiteUrl)),
                        ],
                      ),
                    );
                  }),
            ))
          ],
        ),
      );
    }
  }

  Widget newWebsite() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
            child: TextFormField(
                maxLines: 1,
                controller: websiteNameController,
                onSaved: (value) {
                  if (value != null) {
                    websiteName = value;
                    websiteNameController.text = "";
                  }
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 16, right: 16),
                    labelText: "Enter website name",
                    labelStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    isDense: true),
                keyboardType: TextInputType.emailAddress),
          ),
          Container(
            width: 300,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(25.0)),
            child: TextFormField(
                maxLines: 1,
                controller: websiteUrlController,
                onSaved: (value) {
                  if (value != null) {
                    websiteUrl = value;
                    websiteUrlController.text = "";
                  }
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 15, bottom: 15, left: 16, right: 16),
                    labelText: "Enter website url",
                    labelStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.0),
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    isDense: true),
                keyboardType: TextInputType.emailAddress),
          ),
          GestureDetector(
            onTap: () {
              final form = formKey.currentState;
              form?.save();

              if (websiteName.isNotEmpty && websiteUrl.isNotEmpty) {
                addNewWebsite(websiteName, websiteUrl);
              }
            },
            child: Container(
              width: 300,
              height: 45,
              margin: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 40, top: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  color: AppTheme.primaryColor),
              child: const Text(
                "Add New website",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget deleteWebsiteButton(String websiteUrl) {
    return GestureDetector(
      onTap: () {
        deleteWebsite(websiteUrl);
      },
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            color: AppTheme.primaryColor),
        child: const Center(
          child: Text(
            "delete",
            style: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // TODO 11 : Add new website to Box
  Future? addNewWebsite(String websiteName, String websiteUrl) {
    final website = Website()
      ..websiteName = websiteName
      ..websiteUrl = websiteUrl;

    // TODO 12 : Create Boxes class
    final box = Boxes.getWebsites();
    box.put(websiteUrl, website);
  }

  // TODO 13 : Delete website from Box
  Future? deleteWebsite(String websiteUrl) {
    final box = Boxes.getWebsites();
    box.delete(websiteUrl);
  }
}
