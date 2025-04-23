import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../Forgot_password/recoveryScreen.dart';
import '../../landing_view.dart';
import '../../utils/on_init.dart';
import '../viewModel/login_provider.dart';

class  LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with OnInit {


  @override
  Widget build(BuildContext context) {

    return MediaQuery.of(context).size.width<600 ?
      Scaffold(
        body: Consumer<LoginProvider>(
            builder: (context , model , child) {
              // if (model == null) return Center(child: Text('Loading...'));
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(model.img),
                            ),
                          ],
                        ),
                        Text('Adhicine',style: TextStyle(color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,fontSize: 15),),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign In",
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: model.emailController,
                            decoration: InputDecoration(
                              hintText: 'Enter Email or Phone Number',
                              prefixIcon:Icon(Icons.email),
                              errorText: model.emailError,
                            ),
                              inputFormatters: [
                                //FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                            onChanged: (value) {
                              if (value.length == 10) {
                                FocusScope.of(context).unfocus();};
                              model.clearErrorMessage();
                              model.validateEmailOrPhone(value);
                            }
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: model.passController,
                            obscureText: !model.isPasswordVisible,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  model.isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  model.PasswordVisibility();
                                }),
                    
                              errorText: model.passwordError,
                            ),
                            onChanged: (value) {
                              model.clearErrorMessage();
                              model.validatePassword(value);

                            },

                          ),

                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(builder: (context) => RecoverypasswordScreen()));
                            },
                            child: Text("Forgot Password?", style: TextStyle(color: Colors.blueAccent)),
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              model.loggedIn(
                                context: context,
                                success: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => LandingView()),
                                  );
                                },
                                failure: (error) {
                                  print("Error Message12345======: ${model.errorMessage}");
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                       // title: Text("Login Failed"),
                                        content: Text(model.errorMessage!),
                                        actions: [
                                          TextButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              Navigator.of(context).pop(); // dismiss dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                },

                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            child: Text(
                              "Log In",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        if (model.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              model.errorMessage!,
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          ),
                    
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("OR"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: BorderSide(color: Colors.grey.shade300),
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            ),
                            icon: Image.network(model.google,height: 24),
                            label: Text("Continue with Google", style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("New to Adhicine?"),
                            TextButton(
                              onPressed: () {},
                              child: Text("Sign Up", style: TextStyle(color: Colors.blueAccent)),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            }
        )
    ):Container();



  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<LoginProvider>(context,listen: false).initState(context);
  }
}