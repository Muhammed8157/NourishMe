import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nourish_me/database/databaseuser.dart';
import 'package:nourish_me/screens/loginsignup/forgetpassword.dart';
import 'package:nourish_me/screens/loginsignup/sign_up.dart';
import 'package:nourish_me/constants/Constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _textvisible = false;
  signin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      await UserDB.instances.RefreshData();
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Oops', e.code);
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInsets = MediaQuery.of(context).viewInsets.bottom;
    bool isKeyboardOpen = bottomInsets != 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 37),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: (() => Get.to(
                              () => SignUpScreen(),
                            )),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Primary_green),
                        ),
                      ),
                      Text(
                        '/',
                        style: TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: (() => Get.to(
                              ForgetPassword(),
                            )),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Let Continue The Healthy Journey',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Center(
                    child: !isKeyboardOpen
                        ? Padding(
                            padding: const EdgeInsets.all(50),
                            child: SizedBox(
                                height: 150,
                                child: Image.asset(
                                    "assets/images/NourishNavyNobgeyeblink.png")),
                          )
                        : SizedBox(
                            height: 20,
                          ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      6,
                    ),
                    height: 60,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: email,
                              decoration: InputDecoration(
                                fillColor: Primary_green,
                                icon: Icon(Icons.mail),
                                border: InputBorder.none,
                                hintText: 'Mail Id',
                                hintStyle: TextStyle(color: Colors.white54),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      6,
                    ),
                    height: 60,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: TextFormField(
                              obscureText: !_textvisible,
                              controller: password,
                              decoration: InputDecoration(
                                fillColor: Primary_green,
                                icon: Icon(Icons.lock),
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white54),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _textvisible = !_textvisible;
                                    });
                                  },
                                  icon: Icon(
                                    _textvisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(
                      () => ForgetPassword(),
                    ),
                    child: Text(
                      'Forget Password ?',
                      style: TextStyle(
                        color: Primary_green,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Primary_green,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: (() => signin()),
                        child: Text(
                          'login',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
