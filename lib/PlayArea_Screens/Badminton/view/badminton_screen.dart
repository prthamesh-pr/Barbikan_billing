import 'package:billing_web/PlayArea_Screens/Badminton/viewModel/badminton_provider.dart';
import 'package:billing_web/features/utils/on_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../features/config.dart';
import '../../dashBoard/view/dashBoard_screen.dart';

class BadmintonScreen extends StatefulWidget {
  const BadmintonScreen({super.key});

  @override
  State<BadmintonScreen> createState() => _BadmintonScreenState();
}

class _BadmintonScreenState extends State<BadmintonScreen> with OnInit {
  late BadmintonProvider controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int rate = CreationPageConfig.getRate('badminton');

    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 600;
    final double horizontalPadding = isMobile ? 10.0 : 15.0;
    return MediaQuery.of(context).size.width<600 ?
     Scaffold(
      appBar: AppBar(
        title: Text('Badminton '),
        backgroundColor: Colors.white54,
        centerTitle: true,
      ),
      body: Consumer<BadmintonProvider>(
          builder: (context, controller, child) {
            return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 200,width: 200,
                      child: Image.asset("assets/image/PlayArea_image.jpeg",fit: BoxFit.cover, ),
                    ),
                  ),
                  Text(controller.selectedSport,style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold),),
                  Text('$rate/hour',style: TextStyle(fontSize: 15)),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isMobile) ...[
                          _buildInputField(
                              context,
                              "Name",
                              "Enter Your Name",
                              Iconsax.user,
                              isMobile: isMobile,
                              controller: controller.userNameController
                          ),
                          _buildInputField(
                              context,
                              "Phone Name",
                              "Enter Phone Name",
                              Iconsax.mobile,
                              isMobile: isMobile,
                              controller: controller.mobileController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter phone number';
                              } else if (value.trim().length < 10) {
                                return 'Phone number must be at least 10 digits';
                              }
                              return null;
                            },
                          ),
                          _buildInputField(
                              context,
                              "Email",
                              "Enter your Email",
                              Iconsax.message,
                              isMobile: isMobile,
                              controller: controller.emailController
                          ),
                          _buildInputField(
                              context,
                              "Date",
                              "Select Date",
                              Iconsax.calendar,
                              isMobile: isMobile,
                              controller: controller.dateController
                          ),
                          SizedBox(height: 20),

                          Row(
                            children: [
                              // Expanded(
                              //   child: _buildInputField(
                              //     context,
                              //     "Start Time",
                              //     " ",
                              //     Iconsax.calendar,
                              //     isMobile: isMobile,
                              //     controller: controller.startTimeController,
                              //     options: generateTimeSlots(),
                              //     selectedValue: controller.startTimeController.text,
                              //   ),
                              // ),
                              //
                              // SizedBox(width: 10),
                              // Expanded(
                              //   child: _buildInputField(
                              //     context,
                              //     "End Time",
                              //     " ",
                              //     Iconsax.calendar,
                              //     isMobile: isMobile,
                              //    controller:controller.endTimeController,
                              //     options:  generateTimeSlots(),
                              //     selectedValue: controller.endTimeController.text,
                              //   ),
                              // ),

                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showTimePickerPopup(context, (selectedTime) {
                                      controller.startTimeController.text = selectedTime;
                                      //  controller.updateTotalDuration(); // if needed
                                    });
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: controller.startTimeController,
                                      decoration: InputDecoration(
                                        labelText: 'Start Time',
                                        suffixIcon: Icon(Icons.access_time),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    showTimePickerPopup(context, (selectedTime) {
                                      controller.endTimeController.text = selectedTime;
                                      // controller.updateTotalDuration(); // if needed
                                    });
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      controller: controller.endTimeController,
                                      decoration: InputDecoration(
                                        labelText: 'End Time',
                                        suffixIcon: Icon(Icons.access_time),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),


                          SizedBox(height: 10),
                          _buildInputField(
                            context,
                            "Court",
                            "Select Your Court",
                            Iconsax.calendar,
                            isMobile: isMobile,
                            options: ['Court 1', 'Court 1'],
                            selectedValue: controller.selectedCourt ,
                            onChanged: (value) {
                              controller.setSelectedCourt(value);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) return 'Please select court';
                              return null;
                            },
                          ),
                        ],
                        SizedBox(height: 30),
                        Text('Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Hour', style: TextStyle(fontSize: 17)),
                            Text(controller.totalDuration, style: TextStyle(fontSize: 17)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Price', style: TextStyle(fontSize: 17)),
                            Text(controller.totalPrice, style: TextStyle(fontSize: 17)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildFooterButtons(context, isMobile),

                  // Container(
                  //   height: 50,
                  //
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Colors.red,
                  //   ),
                  // ),
                  // SizedBox(height: 20,),
                  // Container(
                  //   height: 50,
                  //
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: Colors.red,
                  //   ),
                  // ),
                  // SizedBox(height: 20,),
                ],
              ),
            ),
          );
        }
      ),
    ):
        
    Scaffold(
    appBar: AppBar(
    title: Text('Badminton '),
    backgroundColor: Colors.white54,
    centerTitle: true,
    ),
    body: Consumer<BadmintonProvider>(
    builder: (context, controller, child) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    child: SingleChildScrollView(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Align(
    alignment: Alignment.center,
    child: Container(
    height: 200,width: 200,
    child: Image.asset("assets/image/PlayArea_image.jpeg",fit: BoxFit.cover, ),
    ),
    ),
    Text(controller.selectedSport,style: TextStyle(fontSize: 20,
    fontWeight: FontWeight.bold),),
    Text('$rate/hour',style: TextStyle(fontSize: 15)),
    SizedBox(height: 20),
    Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    if (isMobile) ...[
    _buildInputField(
    context,
    "Name",
    "Enter Your Name",
    Iconsax.user,
    isMobile: isMobile,
    controller: controller.userNameController
    ),
    _buildInputField(
    context,
    "Phone Name",
    "Enter Phone Name",
    Iconsax.mobile,
    isMobile: isMobile,
    controller: controller.mobileController,
    keyboardType: TextInputType.phone,
    inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
    LengthLimitingTextInputFormatter(10),
    ],
    validator: (value) {
    if (value == null || value.trim().isEmpty) {
    return 'Please enter phone number';
    } else if (value.trim().length < 10) {
    return 'Phone number must be at least 10 digits';
    }
    return null;
    },
    ),
    _buildInputField(
    context,
    "Email",
    "Enter your Email",
    Iconsax.message,
    isMobile: isMobile,
    controller: controller.emailController
    ),
    _buildInputField(
    context,
    "Date",
    "Select Date",
    Iconsax.calendar,
    isMobile: isMobile,
    controller: controller.dateController
    ),
    SizedBox(height: 20),

    Row(
    children: [
    // Expanded(
    //   child: _buildInputField(
    //     context,
    //     "Start Time",
    //     " ",
    //     Iconsax.calendar,
    //     isMobile: isMobile,
    //     controller: controller.startTimeController,
    //     options: generateTimeSlots(),
    //     selectedValue: controller.startTimeController.text,
    //   ),
    // ),
    //
    // SizedBox(width: 10),
    // Expanded(
    //   child: _buildInputField(
    //     context,
    //     "End Time",
    //     " ",
    //     Iconsax.calendar,
    //     isMobile: isMobile,
    //    controller:controller.endTimeController,
    //     options:  generateTimeSlots(),
    //     selectedValue: controller.endTimeController.text,
    //   ),
    // ),

    Expanded(
    child: GestureDetector(
    onTap: () {
    showTimePickerPopup(context, (selectedTime) {
    controller.startTimeController.text = selectedTime;
    //  controller.updateTotalDuration(); // if needed
    });
    },
    child: AbsorbPointer(
    child: TextFormField(
    controller: controller.startTimeController,
    decoration: InputDecoration(
    labelText: 'Start Time',
    suffixIcon: Icon(Icons.access_time),
    border: OutlineInputBorder(),
    ),
    ),
    ),
    ),
    ),
    SizedBox(width: 10),
    Expanded(
    child: GestureDetector(
    onTap: () {
    showTimePickerPopup(context, (selectedTime) {
    controller.endTimeController.text = selectedTime;
    // controller.updateTotalDuration(); // if needed
    });
    },
    child: AbsorbPointer(
    child: TextFormField(
    controller: controller.endTimeController,
    decoration: InputDecoration(
    labelText: 'End Time',
    suffixIcon: Icon(Icons.access_time),
    border: OutlineInputBorder(),
    ),
    ),
    ),
    ),
    ),

    ],
    ),


    SizedBox(height: 10),
    _buildInputField(
    context,
    "Court",
    "Select Your Court",
    Iconsax.calendar,
    isMobile: isMobile,
    options: ['Court 1', 'Court 1'],
    selectedValue: controller.selectedCourt ,
    onChanged: (value) {
    controller.setSelectedCourt(value);
    },
    validator: (value) {
    if (value == null || value.isEmpty) return 'Please select court';
    return null;
    },
    ),
    ],
    SizedBox(height: 30),
    Text('Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
    SizedBox(height: 30),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text('Total Hour', style: TextStyle(fontSize: 17)),
    Text(controller.totalDuration, style: TextStyle(fontSize: 17)),
    ],
    ),
    SizedBox(height: 10),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text('Total Price', style: TextStyle(fontSize: 17)),
    Text(controller.totalPrice, style: TextStyle(fontSize: 17)),
    ],
    ),
    ],
    ),
    ),
    SizedBox(height: 20),
    _buildFooterButtons(context, isMobile),

    // Container(
    //   height: 50,
    //
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     color: Colors.red,
    //   ),
    // ),
    // SizedBox(height: 20,),
    // Container(
    //   height: 50,
    //
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     color: Colors.red,
    //   ),
    // ),
    // SizedBox(height: 20,),
    ],
    ),
    ),
    );
    }
    ),
    );
  }

  Widget _buildInputField(
      BuildContext context,
      String label,
      String hint,
      IconData? icon, {
        int maxLines = 1,
        bool isMobile = false,
        TextEditingController? controller,
        TextInputType? keyboardType,
        List<String>? options,
        String? selectedValue,
        List<TextInputFormatter>? inputFormatters,
        String? Function(String?)? validator,
        Function(String?)? onChanged,
      }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 8 : 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: isMobile ? 13 : 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 3 : 5),
          options == null
              ?
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            maxLines: maxLines,
            cursorHeight: isMobile ? 18 : 20,
            style: TextStyle(fontSize: isMobile ? 14 : 16),
            decoration: InputDecoration(
              prefixIcon: icon != null
                  ? Icon(icon, size: isMobile ? 16 : 18)
                  : null,
              prefixIconConstraints: BoxConstraints(
                minWidth: isMobile ? 36 : 48,
                minHeight: isMobile ? 36 : 48,
              ),
              filled: true,
              fillColor: const Color(0xffEEEEEE),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 15,
                vertical: isMobile ? 12 : 15,
              ),
              hintText: hint,
              hintStyle: TextStyle(fontSize: isMobile ? 14 : 16),
            ),
            validator:  (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $label';
              }
              return null;
            },
          ):
          DropdownButtonFormField<String>(
            value: selectedValue,
            onChanged: onChanged,
            items: options
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e, style: TextStyle(fontSize: isMobile ? 14 : 16)),
            ))
                .toList(),
            decoration: InputDecoration(
              prefixIcon: icon != null
                  ? Icon(icon, size: isMobile ? 16 : 18)
                  : null,
              prefixIconConstraints: BoxConstraints(
                minWidth: isMobile ? 36 : 48,
                minHeight: isMobile ? 36 : 48,
              ),
              filled: true,
              fillColor: const Color(0xffEEEEEE),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 15,
                vertical: isMobile ? 12 : 15,
              ),
              hintText: hint,
              hintStyle: TextStyle(fontSize: isMobile ? 14 : 16),
            ),
            validator: validator,
          ),

        ],
      ),
    );
  }

  Widget _buildFooterButtons(BuildContext context, bool isMobile) {
    return Consumer<BadmintonProvider>(
        builder: (context, controller, child) {
          return Container(
            padding: EdgeInsets.all(isMobile ? 8 : 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
          Navigator.pop(context);
          },
                 child: _buildButton(
                    context,
                    "Cancel",
                    Colors.grey.shade600,
                    const Color(0xffEEEEEE),
                    isMobile,
                  ),
                ),
                SizedBox(width: isMobile ? 8 : 10),
                GestureDetector(
                  onTap: ()async{
                    if (_formKey.currentState!.validate()){
                      await controller.badminton(
                          success: (){
                            // controller. sportNameController.clear();
                            controller. mobileController.clear();
                            controller.  dateController.clear();
                            controller. startTimeController.clear();
                            controller. endTimeController.clear();
                            controller. userNameController.clear();
                            controller. emailController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Data added successfully')),
                            );
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => DashboardScreen()),
                            );
                          },
                          failure: (message) {

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: $message')),
                            );
                          }
                      );
                    } else {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all required fields')),
                      );
                    }
                  },
                  child: _buildButton(
                    context,
                    "Book Now",
                    Colors.white,
                    Theme.of(context).primaryColor,
                    isMobile,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  List<String> generateTimeSlots() {
    return List.generate(15, (index) => '${10 + index}:00');
  }

  void showTimePickerPopup(BuildContext context, Function(String) onTimeSelected) {
    List<String> timeSlots = generateTimeSlots();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: 250,
            width: 200,
            color: Colors.white54,
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: timeSlots.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(child: Text(timeSlots[index])),
                  onTap: () {
                    onTimeSelected(timeSlots[index]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }


  Widget _buildButton(
      BuildContext context,
      String text,
      Color textColor,
      Color bgColor,
      bool isMobile,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 15,
        vertical: isMobile ? 6 : 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: textColor,
          fontSize: isMobile ? 13 : 14,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {

    controller = Provider.of<BadmintonProvider>(context, listen: false);
    controller.initState();
    controller.startTimeController.addListener(() {
      controller.calculateDurationAndPrice();
    });
    controller.endTimeController.addListener(() {
      controller.calculateDurationAndPrice();
    });
  }
}
