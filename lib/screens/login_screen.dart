import 'package:flower_fall/constants/colors.dart';
import 'package:flower_fall/constants/copyright_text.dart';
import 'package:flower_fall/constants/custom_button.dart';
import 'package:flower_fall/provider/user_provider.dart';
import 'package:flower_fall/screens/accountDetails_screen.dart';
import 'package:flower_fall/screens/analysis_screen.dart';
import 'package:flower_fall/screens/basicDetails_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode? password;
  FocusNode? mail;
  FocusNode? submit;
  final _auth = FirebaseAuth.instance;

  var pass;
  var email;
  bool spinner = false;
  var formkey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  bool isObsecure = true;

  buttonValidation() async {
    if (formkey.currentState!.validate()) {
      try {
        final newUser = await _auth.signInWithEmailAndPassword(
            email: email, password: pass);

        if (newUser != null) {
          print('if');
          final provider = Provider.of<UserProvider>(context, listen: false);
          provider.user.email = email;
          var exists = await provider.isExists(email);
          if (exists == true) {
            await provider.readUserByEmail();
            addIntToSF() async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt('intValue', provider.user.id!);
            }

            print('stored user id from sf is ${addIntToSF()}');
            //provider = Provider.of<UserProvider>(context, listen: false);

            //  var periodExists = await periodProvider.periodExistsByUID(userId: provider.user.id!);
            //  if(periodExists == true){
            // await  periodProvider.readPeriodByUserIdAndChosen(userId: provider.user.id!);}
            setState(() {
              spinner = true;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Analysis()),
            );
          } else {
            print('in else');
            final provider = Provider.of<UserProvider>(context, listen: false);
            provider.user.email = email;
            await provider.addUser();
            addIntToSF() async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt('intValue', provider.user.id!);
            }

            print('stored user id from sf is ${addIntToSF()}');
            // addPeriodIntToSF() async {
            //   SharedPreferences prefs = await SharedPreferences.getInstance();
            //   prefs.setInt('intValue', provider.user.id!);
            // }
            // print('stored period id from sf is ${addIntToSF()}');
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BasicDetailsPage()));
            setState(() {
              spinner = true;
            });
          }
        }
      } catch (e) {
        print(e);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text("Enter correct credential"),
                actions: <Widget>[
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    password = FocusNode();
    mail = FocusNode();
    submit = FocusNode();
  }

  @override
  void dispose() {
    password!.dispose();
    mail!.dispose();
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
          body: ModalProgressHUD(
            inAsyncCall: spinner,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height,
                ),
                child: IntrinsicHeight(
                  child: Form(
                    key: formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                            child: Image.asset('images/flowerFallColoured.png'),
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          ListTile(
                            dense: true,
                            leading: Text(
                              'Login',
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
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.5),
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
                                // user.email = email;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: TextFormField(
                              autofocus: true,
                              focusNode: password,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (term){
                                password!.unfocus();
                                FocusScope.of(context).requestFocus(submit);
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
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                labelText: "Password",
                                suffixIcon: isObsecure ? IconButton(
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
                                pass = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          kCustomButton(
                            focusNode: submit,
                            text: 'Next',
                            onPressed: () => buttonValidation(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account?',
                                  style: TextStyle(
                                      color: kDarkBlue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AccountDetailsPage()));
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.lightBlueAccent,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ))
                              ],
                            ),
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
          )),
    );
  }
}
