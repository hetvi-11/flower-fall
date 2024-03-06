import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flower_fall/constants/copyright_text.dart';
import 'package:flower_fall/constants/custom_button.dart';
import 'package:flower_fall/screens/periodDuration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BasicDetailsPage extends StatefulWidget {
  const BasicDetailsPage({Key? key}) : super(key: key);

  @override
  _BasicDetailsPageState createState() => _BasicDetailsPageState();
}

class _BasicDetailsPageState extends State<BasicDetailsPage> {
  FocusNode? name;
  FocusNode? birthDate;
  FocusNode? kg;
  FocusNode? submit;
  String username = "";
  DateTime dob = DateTime.now();
  String weight = "";
  TextEditingController _dateController = TextEditingController();
  var image;
  var formKey = GlobalKey<FormState>();
  DateTime dateTime = DateTime.now();
  File? _storedImage;

  buttonValidation() {
    if (formKey.currentState!.validate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.user.name = username;
      userProvider.user.dob = dob;
      userProvider.user.weight = weight;
      userProvider.user.image = image;

      userProvider.updateUserBasic();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PeriodDuration()));
    }
  }

  void _uploadImage() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

       FilePickerResult? _picker = await FilePicker.platform.pickFiles();

    if (_picker == null) {
      return;
    }
   File _pickedImage = File(_picker.files.single.path!);
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    Directory dir = await Directory(documentDirectory.path + '/' + userProvider.user.id.toString())

        .create(recursive: true);

    final pat = path.join(dir.path, 'profile_image.png');

    File file = File(pat);
    print(".......$pat");

     file.writeAsBytesSync(await _pickedImage.readAsBytes());

    setState(() {
      _pickedImage!= null ? image = pat : image = null;
    });
  }
@override
  void initState() {
    super.initState();
    name = FocusNode();
    birthDate = FocusNode();
    kg = FocusNode();
    submit = FocusNode();
  }

  @override
  void dispose() {
    name!.dispose();
    birthDate!.dispose();
    kg!.dispose();
    submit!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: LayoutBuilder(
            builder: (context, constraint) {
              double deviceHeight = constraint.maxHeight;
              double occupiedHeight = 1.h+100+150+40+50+(80*3)+85+12;
              bool withScroll = deviceHeight>occupiedHeight ? false : true;
              return WithScroll(
                withScroll: withScroll,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Column(children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                            child: Image.asset('images/flowerFallColoured.png',
                            height: 100,),
                          ),
                          Container(
                            height: 150,
                            child: Stack(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(110.0, 5, 100, 0),
                                child: Image.asset('images/Vector.png',
                                height: 150,),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(140.0, 20, 100, 0),
                                child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      color: kDarkBlue,
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
                                        : null,
                                  ),
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
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            height: 50,
                            child: ListTile(
                              dense: true,
                              leading: Text(
                                'Basic Details',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: TextFormField(
                                autofocus: true,
                                focusNode: name,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (term){
                                  name!.unfocus();
                                  FocusScope.of(context).requestFocus(birthDate);
                                },
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                                    return 'Enter valid name';
                                  }
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  labelText: "Full name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                onChanged: (value) {
                                  username = value;
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: TextFormField(
                                autofocus: true,
                                focusNode: birthDate,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (term){
                                  birthDate!.unfocus();
                                  FocusScope.of(context).requestFocus(kg);
                                },
                                validator: (value) {
                                  if (value!.isEmpty||
                                      !RegExp(r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$').hasMatch(value)) {
                                    return 'Enter your birth date';
                                  }
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$')),
                                ],
                                controller: _dateController
                                  ..text = DateFormat("dd-MM-yyyy").format(dateTime),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  labelText: "Date of Birth (dd-mm-yyyy)",

                                  suffixIcon: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
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
                                        if (value != null) {
                                           setState(() {
                                          dateTime = value;
                                          dob = value;
                                        });
                                        }
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
                          ),
                          Container(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 10.0),
                              child: TextFormField(
                                autofocus: true,
                                focusNode: kg,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (term){
                                  kg!.unfocus();
                                  FocusScope.of(context).requestFocus(submit);
                                },
                                maxLength: 3,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[1-9][0-9]?$|^100$').hasMatch(value)) {
                                    return 'Enter weight in Kg';
                                  }
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black, width: 1.5),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  labelText: "Weight in kgs",
                                  counterText: "",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]?$|^100$')),
                                ],
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  weight = value;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          kCustomButton(
                            focusNode: submit,
                              text: 'Next', onPressed: () => buttonValidation()),


                        ]),
                        if(!withScroll)
                          Spacer(),
                        Padding(
                          padding:  EdgeInsets.only(bottom: withScroll ? 0 : 20.0,top: !withScroll ? 0 : 10.0,),
                          child: kCopyright(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          )),
    );
  }
  Widget WithScroll({required bool withScroll, required Widget child}){
    if(withScroll){
      return SingleChildScrollView(child: child,);
    }
    else
      return child;
  }
}
