import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreatePurchasePartyView extends StatefulWidget {
  const CreatePurchasePartyView({super.key});

  @override
  State<CreatePurchasePartyView> createState() =>
      _CreatePurchasePartyViewState();
}

class _CreatePurchasePartyViewState extends State<CreatePurchasePartyView> {
  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 600;
    final double horizontalPadding = isMobile ? 10.0 : 15.0;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Padding(
          padding: EdgeInsets.all(horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create Purchase Party",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: isMobile ? 18 : 24,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Manage and collaborate with your vendors",
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: isMobile ? 32 : 40,
                  width: isMobile ? 32 : 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffEEEEEE),
                  ),
                  child: Center(
                    child: Icon(Icons.close, size: isMobile ? 16 : 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0, color: Color(0xffEEEEEE)),
        
        // Form content
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(horizontalPadding),
            children: [
              // Basic Information Fields
              if (isMobile) ...[
                // Mobile layout: Stack vertically
                _buildInputField(
                  context,
                  "Company Name",
                  "Enter Company Name",
                  Iconsax.building,
                  isMobile: isMobile,
                ),
                _buildInputField(
                  context,
                  "Party Name",
                  "Enter Party Name",
                  Iconsax.user,
                  isMobile: isMobile,
                ),
              ] else ...[
                // Tablet/Desktop layout: Side by side
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        "Company Name",
                        "Enter Company Name",
                        Iconsax.building,
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInputField(
                        context,
                        "Party Name",
                        "Enter Party Name",
                        Iconsax.user,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                ),
              ],
              
              // GST and Mobile Number
              if (isMobile) ...[
                _buildInputField(
                  context,
                  "GST No",
                  "Enter GST Number",
                  Iconsax.flag,
                  isMobile: isMobile,
                ),
                _buildInputField(
                  context,
                  "Mobile Number",
                  "Enter Mobile Number",
                  Iconsax.call,
                  isMobile: isMobile,
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        "GST No",
                        "Enter GST Number",
                        Iconsax.flag,
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInputField(
                        context,
                        "Mobile Number",
                        "Enter Mobile Number",
                        Iconsax.call,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                ),
              ],
              
              // Alternate Number and Email
              if (isMobile) ...[
                _buildInputField(
                  context,
                  "Alternate Number",
                  "Enter Alternate Number",
                  Iconsax.call,
                  isMobile: isMobile,
                ),
                _buildInputField(
                  context,
                  "Email Address",
                  "Enter Email Address",
                  Iconsax.sms,
                  isMobile: isMobile,
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        "Alternate Number",
                        "Enter Alternate Number",
                        Iconsax.call,
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInputField(
                        context,
                        "Email Address",
                        "Enter Email Address",
                        Iconsax.sms,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: isMobile ? 10 : 15),
              const Divider(height: 0, color: Color(0xffEEEEEE)),
              SizedBox(height: isMobile ? 8 : 10),
              
              // Billing Address Section
              _buildSectionHeader(context, "Billing Address", isMobile: isMobile),
              _buildInputField(
                context,
                "Address",
                "Enter Address",
                null,
                maxLines: 3,
                isMobile: isMobile,
              ),
              
              // City and State
              if (isMobile) ...[
                _buildInputField(
                  context,
                  "City",
                  "Enter City",
                  Iconsax.location,
                  isMobile: isMobile,
                ),
                _buildInputField(
                  context,
                  "State",
                  "Enter State",
                  Iconsax.global,
                  isMobile: isMobile,
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildInputField(
                        context,
                        "City",
                        "Enter City",
                        Iconsax.location,
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInputField(
                        context,
                        "State",
                        "Enter State",
                        Iconsax.global,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                ),
              ],

              SizedBox(height: isMobile ? 10 : 15),
              const Divider(height: 0, color: Color(0xffEEEEEE)),
              SizedBox(height: isMobile ? 8 : 10),
              
              // Credit & Balance Section
              _buildSectionHeader(context, "Credit & Balance", isMobile: isMobile),
              
              // Category and Opening Balance
              if (isMobile) ...[
                _buildDropdownField(
                  context, 
                  "Category", 
                  ["DR", "CR"],
                  isMobile: isMobile,
                ),
                _buildInputField(
                  context,
                  "Opening Balance",
                  "Enter Opening Balance",
                  Iconsax.money,
                  isMobile: isMobile,
                ),
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildDropdownField(
                        context, 
                        "Category", 
                        ["DR", "CR"],
                        isMobile: isMobile,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildInputField(
                        context,
                        "Opening Balance",
                        "Enter Opening Balance",
                        Iconsax.money,
                        isMobile: isMobile,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        _buildFooterButtons(context, isMobile),
      ],
    );
  }

  Widget _buildInputField(
    BuildContext context,
    String label,
    String hint,
    IconData? icon, {
    int maxLines = 1,
    bool isMobile = false,
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
          TextFormField(
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
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    BuildContext context,
    String label,
    List<String> options, {
    bool isMobile = false,
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 15),
            decoration: BoxDecoration(
              color: const Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(isMobile ? 8 : 10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: InputBorder.none),
              hint: Text(
                "Choose $label",
                style: TextStyle(fontSize: isMobile ? 14 : 16),
              ),
              style: TextStyle(fontSize: isMobile ? 14 : 16),
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, size: isMobile ? 24 : 30),
              itemHeight: isMobile ? 48 : 56,
              items: options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, {bool isMobile = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isMobile ? 8 : 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: isMobile ? 14 : 16,
        ),
      ),
    );
  }

  Widget _buildFooterButtons(BuildContext context, bool isMobile) {
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
            onTap: () {
              // Add save functionality here
            },
            child: _buildButton(
              context,
              "Add New",
              Colors.white,
              Theme.of(context).primaryColor,
              isMobile,
            ),
          ),
        ],
      ),
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
}