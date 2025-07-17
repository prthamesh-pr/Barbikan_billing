import 'package:barbikan/view/config.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewCompanyView extends StatefulWidget {
  const AddNewCompanyView({super.key});

  @override
  State<AddNewCompanyView> createState() => _AddNewCompanyViewState();
}

class _AddNewCompanyViewState extends State<AddNewCompanyView> {
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _gstController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _fssaiController = TextEditingController();
  final TextEditingController _billPrefixController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _upiNumberController = TextEditingController();

  void _navigateBack() {
    try {
      if (scaffoldKey.currentState != null) {
        scaffoldKey.currentState!.openEndDrawer();
      } else {
        Navigator.of(context).pop();
      }
    } catch (e) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _gstController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _fssaiController.dispose();
    _billPrefixController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ifscCodeController.dispose();
    _upiNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add New Company",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Text(
                        "Add a new company to your organization",
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _navigateBack,
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEEEEEE),
                    ),
                    child: Center(child: Icon(Icons.close, size: 20)),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 0, color: Color(0xffEEEEEE)),

          // Form content
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  // General Information Section
                  Text(
                    "General Information",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Company Name and Mobile Number
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Company Name",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _companyNameController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.building, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "Company Name",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter company name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mobile Number",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _mobileController,
                                cursorHeight: 20,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.call, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "Contact Number",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter mobile number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // GST and FSSAI
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "GST Number",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _gstController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.flag, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "GST Number",
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter GST number';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "FSSAI Number (Optional)",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _fssaiController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.reserve, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "FSSAI Number",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Email and Bill Prefix
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email (Optional)",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _emailController,
                                cursorHeight: 20,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.message, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "Email Address",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bill Prefix (Optional)",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _billPrefixController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.clipboard, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "Bill Prefix",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Billing Address Section
                  Divider(height: 0, color: Color(0xffEEEEEE)),
                  SizedBox(height: 10),
                  Text(
                    "Billing Address",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Address
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: _addressController,
                        cursorHeight: 20,
                        maxLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffEEEEEE),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          hintText: "Address",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // City and State
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "City",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _cityController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.location, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "City",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _stateController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.global, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "State",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),

                  // Bank Details Section
                  Divider(height: 0, color: Color(0xffEEEEEE)),
                  SizedBox(height: 10),
                  Text(
                    "Bank Details (Optional)",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Bank Name and Account Number
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank Name",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _bankNameController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.shop, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "Bank Name",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Number",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _accountNumberController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Iconsax.card, size: 18),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "Account Number",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // IFSC and UPI
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "IFSC Code",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _ifscCodeController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Iconsax.money_recive,
                                    size: 18,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "IFSC Code",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "UPI Number",
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(height: 5),
                            SizedBox(
                              height: 50,
                              child: TextFormField(
                                controller: _upiNumberController,
                                cursorHeight: 20,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Iconsax.receipt_item,
                                    size: 18,
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffEEEEEE),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  hintText: "UPI Number",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Action Buttons
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: _navigateBack,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffEEEEEE),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Cancel",
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      // Save company data
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Company added successfully'),
                        ),
                      );

                      // Close the form with safer navigation
                      _navigateBack();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Add Company",
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge!.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
