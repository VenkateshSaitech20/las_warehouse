import 'package:flutter/material.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/authentications/login_screen.dart';

class Forgetpwdpage extends StatefulWidget {
  const Forgetpwdpage({super.key});

  @override
  State<Forgetpwdpage> createState() => _ForgetpwdpageState();
}

class _ForgetpwdpageState extends State<Forgetpwdpage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 50, top: 160, right: 50, bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Image.asset(Constant.logo),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Reset Password",
                  style: TextStyle(
                    fontSize: 23 * MediaQuery.of(context).textScaleFactor,
                    color: MyColors.grey,
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "email@example.com",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your Email Address';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    // Return null if the entered email is valid
                    return null;
                  },
                  onChanged: (value) => {},
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryblue,
                    ),
                    onPressed: _trySubmitForm,
                    child: Text(
                      "Send Link",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Back to?",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login Here",
                            style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              color: MyColors.primarydarkblue,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
