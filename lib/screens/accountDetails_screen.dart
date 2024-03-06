import 'package:flower_fall/constants/custom_button.dart';
import 'package:flower_fall/model/period_model.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/basicDetails_screen.dart';
import 'package:flower_fall/screens/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flower_fall/constants/copyright_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({Key? key}) : super(key: key);

  @override
  _AccountDetailsPageState createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  FocusNode? mail;
  FocusNode? password;
  FocusNode? cPass;
  FocusNode? submit;
  final _auth = FirebaseAuth.instance;
   PeriodUser user = PeriodUser();
  var pass;
  var email;
  bool isObsecure = true;
  bool spinner = false;
  var formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  buttonValidation()async{
    if (formKey.currentState!.validate()) {
      if (_passwordController.text ==
          _confirmPasswordController.text) {
        try {
          final newUser = await _auth
              .createUserWithEmailAndPassword(
              email: email, password: pass);

            if(newUser!= null) {
              print(newUser);
             final userProvider =  Provider.of<UserProvider>(context, listen: false);
              userProvider.user.email = email;
             await userProvider.addUser();
             addIntToSF() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt('intValue', userProvider.user.id!);
              }
              print('stored user id from sf is ${addIntToSF()}');
            }
          setState(() {
            spinner = true;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    BasicDetailsPage()),
          );
        }
        catch (e) {
          print(e);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Error"),
                  content: Text(
                      "You already have an account. Please Login."),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Login"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage()));
                      },
                    )
                  ],
                );
              });
        }
      }
    }
  }
  @override
  void initState() {
    super.initState();
    mail = FocusNode();
    password = FocusNode();
    cPass = FocusNode();
    submit = FocusNode();
  }

  @override
  void dispose() {
    mail!.dispose();
    password!.dispose();
    cPass!.dispose();
    submit!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: spinner,
          child: LayoutBuilder(
            builder: (context, constraint) {
              double deviceHeight = constraint.maxHeight;
              double occupiedHeight = 20.h+80+50+17.h+(80*3)+85+12;
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
                        // mainAxisSize: MainAxisSize.max,
                        children: [
                         Column(
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.0),
                                  child: Image.asset('images/flowerFallColoured.png',
                                    height: 17.h,
                                  ),
                                ),
                                SizedBox(
                                  height: 80,
                                ),
                                Container(
                                  height: 50,
                                  child: ListTile(
                                    dense: true,
                                    leading: Text(
                                      'Account Details',
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
                                      focusNode: mail,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (term){
                                        mail!.unfocus();
                                        FocusScope.of(context).requestFocus(password);
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty ||
                                            !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                                .hasMatch(value)) {
                                          return 'Enter valid email id';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black, width: 1.5),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        labelText: "Email id",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(' '),
                                      ],
                                      onChanged: (value) {
                                        email = value.trim().toLowerCase();
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
                                      focusNode: password,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (term){
                                        password!.unfocus();
                                        FocusScope.of(context).requestFocus(cPass);
                                      },
                                      controller: _passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty || value.length < 5) {
                                          return 'Enter at least 5 digit password ';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black, width: 1.5),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        labelText: "Password",
                                        suffixIcon:isObsecure ? IconButton(
                                          icon: Icon(CupertinoIcons.eye_fill),
                                          onPressed: () {
                                            setState(() {
                                              isObsecure = !isObsecure;
                                            });
                                          },
                                        ): IconButton(
                                          icon: Icon(CupertinoIcons.eye_slash_fill),
                                          onPressed: () {
                                            setState(() {
                                              isObsecure = !isObsecure;
                                            });
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: isObsecure,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(' '),
                                      ],
                                      onChanged: (value) {
                                        pass = value.trim().toLowerCase();
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
                                      focusNode: cPass,
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (term){
                                        cPass!.unfocus();
                                        FocusScope.of(context).requestFocus(submit);
                                      },
                                      controller: _confirmPasswordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Password not entered';
                                        }
                                        if (value != pass) {
                                          return 'password not matching';
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.black, width: 1.5),
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        labelText: "Confirm Password",
                                        suffixIcon:isObsecure ? IconButton(
                                          icon: Icon(CupertinoIcons.eye_fill),
                                          onPressed: () {
                                            setState(() {
                                              isObsecure = !isObsecure;
                                            });
                                          },
                                        ): IconButton(
                                          icon: Icon(CupertinoIcons.eye_slash_fill),
                                          onPressed: () {
                                            setState(() {
                                              isObsecure = !isObsecure;
                                            });
                                          },
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),
                                      keyboardType: TextInputType.visiblePassword,
                                      obscureText: isObsecure,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(' '),
                                      ],
                                      onChanged: (value) {},
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                kCustomButton(
                                  focusNode: submit,
                                    text: 'Next',
                                    onPressed: () => buttonValidation()
                                ),
                              ],
                            ),

                          if(!withScroll)
                            Spacer(),
                           Padding(
                                padding: EdgeInsets.only(bottom: withScroll ? 0 : 20.0,top: !withScroll ? 0 : 15.0,),
                                child: kCopyright(),
                              )
                        ]),
                  ),
                ),
              );
            }
          ),
        ));
  }
  Widget WithScroll({required bool withScroll, required Widget child}){
    if(withScroll){
      return SingleChildScrollView(child: child,);
    }
    else
    return child;
  }

}


