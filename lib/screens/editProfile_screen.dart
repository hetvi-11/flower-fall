import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flower_fall/constants/copyright_text.dart';
import 'package:flower_fall/constants/custom_button.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/analysis_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var formkey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  String? selectedImage;

  var image;
  void _uploadImage() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    FilePickerResult? _picker = await FilePicker.platform.pickFiles();

    if (_picker == null) {
      return;
    }
    File _pickedImage = File(_picker.files.single.path!);
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    Directory dir = await Directory(
            documentDirectory.path + '/' + userProvider.user.id.toString())
        .create(recursive: true);

    final pat =
        path.join(dir.path, '${DateTime.now().millisecondsSinceEpoch}.png');

    File file = File(pat);
    print(".......$pat");

    file.writeAsBytesSync(await _pickedImage.readAsBytes());

    setState(() {
      image = pat;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _dateController = TextEditingController();
    Provider.of<UserProvider>(context);

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: formkey,
                child: SafeArea(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      child: Image.asset('images/flowerFallColoured.png'),
                    ),
                    Stack(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(110.0, 5, 100, 0),
                        child: Image.asset('images/Vector.png'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(140.0, 20, 100, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey[800],
                              ),
                              height: 130.0,
                              width: 130.0,
                              child: image != null
                                  ? Image.file(
                                      File(image),
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    )
                                  : Consumer<UserProvider>(
                                      builder: (context, userProvider, child) {
                                      return userProvider.user.image == null
                                          ? Image.asset('images/Flower.png')
                                          : Image.file(
                                              File(userProvider.user.image!),
                                              fit: BoxFit.cover,
                                            );
                                    })),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(180.0, 60, 110, 0),
                        child: IconButton(
                          alignment: Alignment.center,
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _uploadImage();
                          },
                        ),
                      ),
                    ]),
                    SizedBox(
                      height: 60,
                    ),
                    ListTile(
                      dense: true,
                      leading: Text(
                        'Edit Profile Details',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText:
                              Provider.of<UserProvider>(context, listen: false)
                                  .user
                                  .name,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        onChanged: (value) {
                          final provider =
                              Provider.of<UserProvider>(context, listen: false);
                          provider.user.name = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: TextFormField(
                        controller: _dateController
                          ..text =
                              // DateFormat("dd-MM-yyyy").format(widget.user.dob!),
                              DateFormat("dd-MM-yyyy").format(
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .user
                                      .dob!),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText: DateTime.now().toString(),
                          // labelText: widget.user.dob.toString(),
                          suffixIcon: GestureDetector(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5.0),
                              child: SvgPicture.asset(
                                'assets/icons/Calender 3.svg',
                                semanticsLabel: 'Calendar Logo',
                              ),
                            ),
                            onTap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now())
                                  .then((value) {
                                setState(() {
                                  dateTime = value!;
                                  final provider = Provider.of<UserProvider>(
                                      context,
                                      listen: false);
                                  provider.user.dob = value;
                                });
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: TextFormField(
                        maxLength: 3,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.5),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          labelText:
                              Provider.of<UserProvider>(context, listen: false)
                                  .user
                                  .weight,
                          // labelText: widget.user.weight,
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9.,]+')),
                        ],
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final provider =
                              Provider.of<UserProvider>(context, listen: false);
                          provider.user.weight = value;
                          //provider.readUserById();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    kCustomButton(
                      text: 'Done',
                      onPressed: () async {
                        final provider =
                            Provider.of<UserProvider>(context, listen: false);
                        provider.user.image = image;
                        provider.updateUserBasic();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Analysis()));
                      },
                    ),
                    Spacer(),
                    kCopyright(),
                    SizedBox(
                      height: 10.0,
                    )
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
