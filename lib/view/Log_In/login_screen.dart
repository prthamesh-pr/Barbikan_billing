import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Forgot_password/recoveryScreen.dart';
import '../landing_view.dart';
import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<LoginProvider>(
            builder: (context , model , child) {
              // if (model == null) return Center(child: Text('Loading...'));
              return SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
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
                            prefixIcon:Icon(Icons.email),
                            errorText: model.emailError,
                          ),
                          onChanged: (value) {
                            model.validEmail(value);
                          },
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LandingView()),);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 16)),
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
                      Spacer(),
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
              );
            }
        )
    );

    // appBar: AppBar(
    //   title: const Text('Login Screen',style: TextStyle(
    //       color: Colors.white,fontWeight: FontWeight.bold,fontSize: 23)),
    //   centerTitle: true,
    //   backgroundColor:Colors.indigo,
    //   // leading: IconButton(
    //   //   icon: const Icon(Icons.arrow_back_ios, color: Colors.white), // Custom icon
    //   //   onPressed: () {
    //   //     Navigator.pop(context); // Go back
    //   //   },
    //   // ),
    // ),

  }
}