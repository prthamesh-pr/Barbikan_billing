import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class PartyAboutView extends StatefulWidget {
  const PartyAboutView({super.key});

  @override
  State<PartyAboutView> createState() => _PartyAboutViewState();
}

class _PartyAboutViewState extends State<PartyAboutView> {
  String formatNumber(int amount) {
    final NumberFormat formatter = NumberFormat.currency(
      locale: 'en_IN',
      symbol: "",
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get available width to calculate responsive sizes
        final width = constraints.maxWidth;
        
        // Calculate responsive sizes
        final iconSize = _getResponsiveSize(width, 50, 40, 30);
        final containerSize = _getResponsiveSize(width, 100, 80, 60);
        final spacing = _getResponsiveSize(width, 15, 10, 8);
        final smallSpacing = spacing / 2;
        
        // Determine if we should use mobile layout
        final isMobile = width < 600;
        // Removed unused variable 'isTablet'
        
        return ListView(
          padding: EdgeInsets.all(spacing),
          children: [
            // Profile section with company info
            isMobile
                ? _buildMobileProfileSection(iconSize, containerSize, spacing, smallSpacing)
                : _buildDesktopProfileSection(iconSize, containerSize, spacing, smallSpacing),
            
            isMobile ? _buildResponsiveDivider(context, width) : SizedBox(height: spacing),
            
            // Address section
            isMobile
                ? _buildMobileAddressSection(spacing, smallSpacing, width)
                : _buildDesktopAddressSection(spacing, smallSpacing),
            
            isMobile ? _buildResponsiveDivider(context, width) : SizedBox(height: spacing),
            
            // Tax information
            _buildTaxInfoSection(spacing, smallSpacing),
          ],
        );
      },
    );
  }
  
  Widget _buildMobileProfileSection(double iconSize, double containerSize, double spacing, double smallSpacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile picture
        Center(
          child: Container(
            height: containerSize,
            width: containerSize,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Icon(Iconsax.user, size: iconSize, color: Colors.grey),
            ),
          ),
        ),
        SizedBox(height: spacing),
        
        // Profile header
        Center(
          child: Text(
            "Company Profile",
            style: TextStyle(
              fontSize: _getResponsiveSize(MediaQuery.of(context).size.width, 22, 20, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildResponsiveDivider(context, MediaQuery.of(context).size.width),
        
        // Company details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            aboutContent(title: "Company Name", value: "ABC Traders"),
            aboutContent(title: "Party Name", value: "Sankar M"),
            aboutContent(title: "Mobile Number", value: "+91 9942782219"),
            aboutContent(title: "Email", value: "msankar032@gmail.com"),
            aboutContent(title: "GST Number", value: "33AAQFV9862P1ZZ"),
          ],
        ),
        
        _buildResponsiveDivider(context, MediaQuery.of(context).size.width),
        
        // Account details header
        Text(
          "Account Information",
          style: TextStyle(
            fontSize: _getResponsiveSize(MediaQuery.of(context).size.width, 20, 18, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: smallSpacing),
        
        // Account details
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            aboutContent(title: "Opening Date", value: "20-10-2024"),
            aboutContent(title: "Account", value: "Debit"),
            aboutContent(title: "Opening Balance", value: formatNumber(100000)),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopProfileSection(double iconSize, double containerSize, double spacing, double smallSpacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Text(
          "Company Profile",
          style: TextStyle(
            fontSize: _getResponsiveSize(MediaQuery.of(context).size.width, 22, 20, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: smallSpacing),
        
        // Content
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: containerSize,
                    width: containerSize,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Icon(Iconsax.user, size: iconSize, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        aboutContent(title: "Company Name", value: "ABC Traders"),
                        aboutContent(title: "Party Name", value: "Sankar M"),
                        aboutContent(title: "Mobile Number", value: "+91 9942782219"),
                        aboutContent(title: "Email", value: "msankar032@gmail.com"),
                        aboutContent(title: "GST Number", value: "33AAQFV9862P1ZZ"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Information",
                  style: TextStyle(
                    fontSize: _getResponsiveSize(MediaQuery.of(context).size.width, 18, 16, 14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: smallSpacing),
                aboutContent(title: "Opening Date", value: "20-10-2024"),
                aboutContent(title: "Account", value: "Debit"),
                aboutContent(title: "Opening Balance", value: formatNumber(100000)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileAddressSection(double spacing, double smallSpacing, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Center(
          child: Text(
            "Address Information",
            style: TextStyle(
              fontSize: _getResponsiveSize(width, 22, 20, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        _buildResponsiveDivider(context, width),
        
        // Billing address
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Billing Address",
              style: _getHeadingTextStyle(context),
            ),
            SizedBox(height: smallSpacing),
            Text(
              "37, Velliyan Street, Muthuramana Patti, Virudhunagar, Tamilnadu, India - 626001",
              style: _getBodyTextStyle(context),
            ),
          ],
        ),
        
        _buildResponsiveDivider(context, width),
        
        // Shipping address
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Address",
              style: _getHeadingTextStyle(context),
            ),
            SizedBox(height: smallSpacing),
            Text(
              "37, Velliyan Street, Muthuramana Patti, Virudhunagar, Tamilnadu, India - 626001",
              style: _getBodyTextStyle(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopAddressSection(double spacing, double smallSpacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Text(
          "Address Information",
          style: TextStyle(
            fontSize: _getResponsiveSize(MediaQuery.of(context).size.width, 22, 20, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: smallSpacing),
        
        // Address content
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Billing Address",
                    style: _getHeadingTextStyle(context),
                  ),
                  SizedBox(height: smallSpacing),
                  Text(
                    "37, Velliyan Street, Muthuramana Patti, Virudhunagar, Tamilnadu, India - 626001",
                    style: _getBodyTextStyle(context),
                  ),
                ],
              ),
            ),
            
            SizedBox(width: spacing),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Shipping Address",
                    style: _getHeadingTextStyle(context),
                  ),
                  SizedBox(height: smallSpacing),
                  Text(
                    "37, Velliyan Street, Muthuramana Patti, Virudhunagar, Tamilnadu, India - 626001",
                    style: _getBodyTextStyle(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaxInfoSection(double spacing, double smallSpacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TAX INFORMATION",
          style: TextStyle(
            fontSize: _getResponsiveSize(MediaQuery.of(context).size.width, 22, 20, 18),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: smallSpacing),
        aboutContent(title: "GSTIN / UIN", value: "33AAQFV9862P1ZZ"),
        aboutContent(title: "Place of Supply", value: "Tamil Nadu"),
      ],
    );
  }

  // Creates a responsive divider with proper spacing and thickness
  Widget _buildResponsiveDivider(BuildContext context, double width) {
    final thickness = _getResponsiveSize(width, 1.5, 1.2, 1.0);
    final indent = _getResponsiveSize(width, 16, 12, 8);
    final verticalSpace = _getResponsiveSize(width, 20, 16, 12);
    
    return Column(
      children: [
        SizedBox(height: verticalSpace / 2),
        Divider(
          thickness: thickness,
          indent: indent,
          endIndent: indent,
          color: Colors.grey.shade300,
        ),
        SizedBox(height: verticalSpace / 2),
      ],
    );
  }

  Widget aboutContent({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "$title:",
            style: _getHeadingTextStyle(context),
          ),
          const SizedBox(width: 10),
          Text(
            "$value", 
            style: _getBodyTextStyle(context),
          ),
        ],
      ),
    );
  }
  
  // Helper methods for responsive design
  double _getResponsiveSize(double width, double large, double medium, double small) {
    if (width > 900) {
      return large;
    } else if (width > 600) {
      return medium;
    } else {
      return small;
    }
  }
  
  TextStyle _getHeadingTextStyle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fontSize = _getResponsiveSize(width, 16, 14, 13);
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );
  }
  
  TextStyle _getBodyTextStyle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final fontSize = _getResponsiveSize(width, 16, 14, 13);
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      fontSize: fontSize,
    );
  }
}