import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // لاستخدام DateFormat لتنسيق الوقت
import 'package:supabase_flutter/supabase_flutter.dart';

class SetProfilePicture extends StatefulWidget {
  final void Function(String imageUrl) onUpload;
  final String imageUrl;

  const SetProfilePicture({
    super.key,
    required this.onUpload,
    required this.imageUrl,
  });

  @override
  State<SetProfilePicture> createState() => _SetProfilePictureState();
}

class _SetProfilePictureState extends State<SetProfilePicture> {
  String image = '';
  late String imageUrl = widget.imageUrl; // القيمة الأولية من constructor

  @override
  Widget build(BuildContext context) {
    Future<void> pickImage(ImageSource source) async {
      try {
        final pickedFile = await ImagePicker().pickImage(source: source);
        if (pickedFile != null) {
          setState(() {
            image = pickedFile.path;
          });

          await setPicture();
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No image selected'),
              ),
            );
          }
        }
      } on Exception catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$error'),
            ),
          );
        }
      }
    }

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey,
                  width: 5,
                ),
              ),
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.white,
                ),
                child: image.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.asset(
                          "assets/images/Image/User_scan_duotone_line.png",
                          fit: BoxFit.fill,
                        ),
                      )
                    : Image.file(
                        File(image),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                        color: Colors.white,
                      ),
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.photo_outlined),
                            title: const Text('Pick from gallery'),
                            onTap: () async {
                              pickImage(ImageSource.gallery);

                              // final XFile? image = await ImagePicker()
                              //     .pickImage(source: ImageSource.gallery);
                              // if (image == null) {
                              //   return;
                              // }
                              // final imageBytes = await image.readAsBytes();
                              // final userId =
                              //     FirebaseAuth.instance.currentUser!.uid;
                              // final imagePath = '/$userId/profile.png';
                              // final imageExtenstion =image.path.split('.').last.toLowerCase();
                              // await Supabase.instance.client.storage
                              //     .from('profile')
                              //     .uploadBinary(imagePath, imageBytes,
                              //         fileOptions: FileOptions(
                              //           upsert: true,
                              //           contentType: "image/$imageExtenstion",
                              //         ));
                              // String imageUrl = Supabase.instance.client.storage
                              //     .from('profile')
                              //     .getPublicUrl(imagePath);
                              // imageUrl = Uri.parse(imageUrl).replace(
                              //     queryParameters: {
                              //       't': DateTime.now()
                              //           .millisecondsSinceEpoch
                              //           .toString()
                              //     }).toString();
                              // widget.onUpload(imageUrl);

                              Navigator.of(context).pop();
                            },
                          ),
                          const Divider(
                            height: 0,
                            color: Colors.blue,
                            thickness: 1,
                            indent: 16,
                            endIndent: 18,
                          ),
                          ListTile(
                            leading: const Icon(Icons.camera_alt_outlined),
                            title: const Text('Take a photo'),
                            onTap: () {
                              pickImage(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const CircleAvatar(
                radius: 17,
                backgroundColor: Colors.black,
                child: Icon(
                  color: Colors.white,
                  Icons.add_a_photo_outlined,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> setPicture() async {
    if (image.isNotEmpty) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final imagePath = '/$userId/profile.png';

      final imageExtension = image.split('.').last.toLowerCase();

      await Supabase.instance.client.storage.from('profile').upload(
            imagePath,
            File(image),
            fileOptions: FileOptions(
              upsert: true,
              contentType: 'image/$imageExtension',
            ),
          );

      String imageUrl = Supabase.instance.client.storage
          .from('profile')
          .getPublicUrl(imagePath);
      imageUrl = Uri.parse(imageUrl).replace(queryParameters: {
        't': DateTime.now().millisecondsSinceEpoch.toString()
      }).toString();
      widget.onUpload(imageUrl);
      await FirebaseAuth.instance.currentUser!.updatePhotoURL(imageUrl);

      log(imageUrl);
    }
  }
}
