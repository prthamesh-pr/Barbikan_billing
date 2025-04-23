import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/Strings.dart';

class EditUserView extends StatefulWidget {
  const EditUserView({super.key});

  @override
  State<EditUserView> createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  String? accType = "staff";
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section with title and close button
          Padding(
            padding: EdgeInsets.all(
              screenSize.width * 0.02,
            ).clamp(const EdgeInsets.all(10.0), const EdgeInsets.all(20.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(Strings.update,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        Strings.orgTeam,
                        style: Theme.of(context).textTheme.labelMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffEEEEEE),
                    ),
                    child: const Center(child: Icon(Icons.close, size: 20)),
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 0, color: Color(0xffEEEEEE)),

          // Form content in scrollable container
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate adaptive spacing
                final verticalSpacing = (constraints.maxHeight * 0.02).clamp(
                  10.0,
                  20.0,
                );

                return ListView(
                  padding: EdgeInsets.all(constraints.maxWidth * 0.03).clamp(
                    const EdgeInsets.all(10.0),
                    const EdgeInsets.all(20.0),
                  ),
                  children: [
                    // Username and Mobile fields
                    _buildFormRow(
                      context,
                      isSmallScreen: isSmallScreen,
                      fields: [
                        _buildFormField(
                          context: context,
                          label: "User Name",
                          icon: Iconsax.user,
                          hint: "Enter User Full Name",
                        ),
                        _buildFormField(
                          context: context,
                          label: "Mobile Number",
                          icon: Iconsax.call,
                          hint: "Enter Contact Number",
                        ),
                      ],
                    ),

                    SizedBox(height: verticalSpacing),

                    // Password fields
                    _buildFormRow(
                      context,
                      isSmallScreen: isSmallScreen,
                      fields: [
                        _buildFormField(
                          context: context,
                          label: "Password",
                          icon: Iconsax.lock,
                          hint: "Enter Secure Password",
                          obscureText: true,
                        ),
                        _buildFormField(
                          context: context,
                          label: "Re-enter Password",
                          icon: Iconsax.lock,
                          hint: "Enter Password",
                          obscureText: true,
                        ),
                      ],
                    ),

                    SizedBox(height: verticalSpacing),

                    // Account type dropdown
                    _buildFormRow(
                      context,
                      isSmallScreen: isSmallScreen,
                      fields: [
                        _buildDropdownField(
                          context: context,
                          label: "Account Type",
                          icon: Iconsax.profile_2user,
                          hint: "Choose Account Type",
                        ),
                        if (!isSmallScreen) const Spacer(),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),

          // Bottom action buttons
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: (screenSize.width * 0.02).clamp(10.0, 20.0),
              vertical: (screenSize.height * 0.015).clamp(8.0, 15.0),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.05 * 255).toInt()),
                  blurRadius: 5,
                  offset: const Offset(0, -1),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton(
                  context: context,
                  label: "Cancel",
                  isOutlined: true,
                  onTap: () => Navigator.pop(context),
                ),
                SizedBox(width: (screenSize.width * 0.01).clamp(8.0, 15.0)),
                _buildActionButton(
                  context: context,
                  label: "Add New",
                  onTap: () {
                    // Add user logic here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build form rows that adapt to screen size
  Widget _buildFormRow(
      BuildContext context, {
        required bool isSmallScreen,
        required List<Widget> fields,
      }) {
    return isSmallScreen
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < fields.length; i++) ...[
          if (i > 0) const SizedBox(height: 15),
          fields[i],
        ],
      ],
    )
        : Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < fields.length; i++) ...[
          if (i > 0) const SizedBox(width: 15),
          Expanded(child: fields[i]),
        ],
      ],
    );
  }

  // Helper method to build consistent form fields
  Widget _buildFormField({
    required BuildContext context,
    required String label,
    required IconData icon,
    required String hint,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18),
            filled: true,
            fillColor: const Color(0xffEEEEEE),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            hintText: hint,
            isDense: true,
          ),
        ),
      ],
    );
  }

  // Helper method to build dropdown field
  Widget _buildDropdownField({
    required BuildContext context,
    required String label,
    required IconData icon,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 5),
        DropdownButtonFormField(
          value: accType,
          items: const [
            DropdownMenuItem(value: "staff", child: Text("Staff")),
            DropdownMenuItem(value: "admin", child: Text("Admin")),
          ],
          onChanged: (value) {
            setState(() {
              accType = value;
            });
          },
          decoration: InputDecoration(
            prefixIcon: Icon(icon, size: 18),
            filled: true,
            fillColor: const Color(0xffEEEEEE),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            hintText: hint,
            isDense: true,
          ),
        ),
      ],
    );
  }

  // Helper method to build action buttons
  Widget _buildActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onTap,
    bool isOutlined = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:
          isOutlined
              ? const Color(0xffEEEEEE)
              : Theme.of(context).primaryColor,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: isOutlined ? Colors.grey.shade600 : Colors.white,
          ),
        ),
      ),
    );
  }
}
