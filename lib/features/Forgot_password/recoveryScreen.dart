import 'package:billing_web/features/Forgot_password/forgotPassword_screen.dart';
import 'package:billing_web/features/Forgot_password/viewModel/RecoveryPassword_Provider.dart';
import 'package:billing_web/features//Log_In/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecoverypasswordScreen extends StatefulWidget {
  const RecoverypasswordScreen({super.key});

  @override
  State<RecoverypasswordScreen> createState() => _RecoverypasswordScreenState();
}

class _RecoverypasswordScreenState extends State<RecoverypasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Consumer<RecoveryPasswordProvider>(
        builder: (context, model, child) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text('Recovery Password', style: TextStyle(fontSize: 20)),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey, width: 2),
                  ),
                  child: TextField(
                    controller: model.recoveryEmailController,
                    onChanged: (value) {
                      model
                          .validateRecoveryEmail(); // Trigger validation on every change
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Your Email',
                      border: InputBorder.none,
                      errorText: model.recoveryEmailError,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    bool isValid = model.validateRecoveryEmail();
                    if (isValid) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordScreen(),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter your email")),
                      );
                    }
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        'Send Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have Account ? '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
