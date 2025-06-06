import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomerCreateView extends StatefulWidget {
  const CustomerCreateView({super.key});

  @override
  State<CustomerCreateView> createState() => _CustomerCreateViewState();
}

class _CustomerCreateViewState extends State<CustomerCreateView> {
  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    final bool isMediumScreen = screenSize.width >= 600 && screenSize.width < 1200;
    
    // Calculate responsive values
    final double basePadding = isSmallScreen ? 10 : (isMediumScreen ? 12 : 15);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        const Divider(height: 0, color: Color(0xffEEEEEE)),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(basePadding),
            children: [
              // Basic Information Section
              if (isSmallScreen) ...[
                // For small screens, stack fields vertically
                _buildInputField(context, "Company Name", "Enter Company Name", Iconsax.building),
                _buildInputField(context, "Party Name", "Enter Party Name", Iconsax.user),
                _buildInputField(context, "GST No", "Enter GST Number", Iconsax.flag),
                _buildInputField(context, "Mobile Number", "Enter Mobile Number", Iconsax.call),
                _buildInputField(context, "Alternate Number", "Enter Alternate Number", Iconsax.call),
                _buildInputField(context, "Email Address", "Enter Email Address", Iconsax.sms),
              ] else ...[
                // For larger screens, use two columns
                _buildTwoFields(
                  context,
                  "Company Name", "Enter Company Name", Iconsax.building,
                  "Party Name", "Enter Party Name", Iconsax.user,
                ),
                _buildTwoFields(
                  context,
                  "GST No", "Enter GST Number", Iconsax.flag,
                  "Mobile Number", "Enter Mobile Number", Iconsax.call,
                ),
                _buildTwoFields(
                  context,
                  "Alternate Number", "Enter Alternate Number", Iconsax.call,
                  "Email Address", "Enter Email Address", Iconsax.sms,
                ),
              ],

              SizedBox(height: basePadding),
              const Divider(height: 0, color: Color(0xffEEEEEE)),
              SizedBox(height: basePadding * 0.7),

              // Billing Address Section
              _buildSectionHeader(context, "Billing Address"),
              _buildInputField(
                context,
                "Address",
                "Enter Address",
                null,
                maxLines: 3,
              ),
              
              if (isSmallScreen) ...[
                _buildInputField(context, "City", "Enter City", Iconsax.location),
                _buildInputField(context, "State", "Enter State", Iconsax.global),
              ] else ...[
                _buildTwoFields(
                  context,
                  "City", "Enter City", Iconsax.location,
                  "State", "Enter State", Iconsax.global,
                ),
              ],
              
              SizedBox(height: basePadding),
              const Divider(height: 0, color: Color(0xffEEEEEE)),
              SizedBox(height: basePadding * 0.7),
              
              // Shipping Address Section
              _buildSectionHeader(context, "Shipping Address"),
              _buildInputField(
                context,
                "Address",
                "Enter Address",
                null,
                maxLines: 3,
              ),
              
              if (isSmallScreen) ...[
                _buildInputField(context, "City", "Enter City", Iconsax.location),
                _buildInputField(context, "State", "Enter State", Iconsax.global),
              ] else ...[
                _buildTwoFields(
                  context,
                  "City", "Enter City", Iconsax.location,
                  "State", "Enter State", Iconsax.global,
                ),
              ],
              
              SizedBox(height: basePadding),
              const Divider(height: 0, color: Color(0xffEEEEEE)),
              SizedBox(height: basePadding * 0.7),
              
              // Credit & Balance Section
              _buildSectionHeader(context, "Credit & Balance"),
              
              if (isSmallScreen) ...[
                _buildDropdownField(context, "Category", ["DR", "CR"]),
                _buildInputField(context, "Opening Balance", "Enter Opening Balance", Iconsax.money),
              ] else ...[
                _buildTwoFieldsDropdown(
                  context,
                  "Category", ["DR", "CR"],
                  "Opening Balance", "Enter Opening Balance", Iconsax.money,
                ),
              ],
              
              _buildInputField(
                context,
                "Opening Date",
                "Select Opening Date",
                Iconsax.calendar,
              ),
            ],
          ),
        ),
        _buildFooterButtons(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 10.0 : 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Customer",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontSize: isSmallScreen ? 18 : 24,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Manage and collaborate with your customers",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: isSmallScreen ? 32 : 40,
              width: isSmallScreen ? 32 : 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffEEEEEE),
              ),
              child: Center(
                child: Icon(Icons.close, size: isSmallScreen ? 16 : 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoFields(
    BuildContext context,
    String label1,
    String hint1,
    IconData icon1,
    String label2,
    String hint2,
    IconData icon2,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildInputField(context, label1, hint1, icon1)),
        const SizedBox(width: 10),
        Expanded(child: _buildInputField(context, label2, hint2, icon2)),
      ],
    );
  }

  Widget _buildTwoFieldsDropdown(
    BuildContext context,
    String label1,
    List<String> options,
    String label2,
    String hint2,
    IconData icon2,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildDropdownField(context, label1, options)),
        const SizedBox(width: 10),
        Expanded(child: _buildInputField(context, label2, hint2, icon2)),
      ],
    );
  }

  Widget _buildInputField(
    BuildContext context,
    String label,
    String hint,
    IconData? icon, {
    int maxLines = 1,
  }) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, 
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: isSmallScreen ? 13 : 14,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            maxLines: maxLines,
            cursorHeight: isSmallScreen ? 18 : 20,
            style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
            decoration: InputDecoration(
              prefixIcon: icon != null 
                ? Icon(icon, size: isSmallScreen ? 16 : 18) 
                : null,
              prefixIconConstraints: BoxConstraints(
                minWidth: isSmallScreen ? 36 : 40,
                minHeight: isSmallScreen ? 36 : 40,
              ),
              filled: true,
              fillColor: const Color(0xffEEEEEE),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: isSmallScreen ? 12 : 15,
              ),
              hintText: hint,
              hintStyle: TextStyle(fontSize: isSmallScreen ? 14 : 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
    BuildContext context,
    String label,
    List<String> options,
  ) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label, 
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: isSmallScreen ? 13 : 14,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xffEEEEEE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: InputBorder.none),
              hint: Text(
                "Choose $label",
                style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
              ),
              style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
              isDense: true,
              // Fixed itemHeight to meet Flutter's minimum requirement
              itemHeight: 48.0, // Must be at least 48.0 (kMinInteractiveDimension)
              items: options.map((value) => 
                DropdownMenuItem(
                  value: value, 
                  child: Text(value),
                ),
              ).toList(),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 5),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: isSmallScreen ? 14 : 16,
        ),
      ),
    );
  }

  Widget _buildFooterButtons(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    
    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xffEEEEEE))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildButton(
            context,
            "Cancel",
            Colors.grey.shade600,
            const Color(0xffEEEEEE),
          ),
          SizedBox(width: isSmallScreen ? 8 : 10),
          _buildButton(
            context,
            "Add New",
            Colors.white,
            Theme.of(context).primaryColor,
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
  ) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          if (text == "Cancel") {
            Navigator.pop(context);
          } else {
            // Handle add new logic
            // For demonstration purposes, you could show a success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Customer added successfully')),
            );
            Navigator.pop(context);
          }
        },
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12 : 15, 
            vertical: isSmallScreen ? 8 : 10, // Increased from 6 to 8 for better touch targets
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: textColor,
              fontSize: isSmallScreen ? 13 : 14,
            ),
          ),
        ),
      ),
    );
  }
}