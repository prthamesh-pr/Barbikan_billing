import 'package:billing_web/features/party/customer/viewModel/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CustomerAboutView extends StatefulWidget {
  final int index;
  const CustomerAboutView({super.key,required this.index});

  @override
  State<CustomerAboutView> createState() => _CustomerAboutViewState();
}

class _CustomerAboutViewState extends State<CustomerAboutView> {
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
        
        return ListView(
          padding: EdgeInsets.all(spacing),
          children: [
            // Section title for mobile
            if (isMobile) ...[
              Center(
                child: Text(
                  "Company Profile",
                  style: TextStyle(
                    fontSize: _getResponsiveSize(width, 22, 20, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildResponsiveDivider(),
            ],
            
            // Profile section
            isMobile
                ? _buildMobileProfileSection(iconSize, containerSize, spacing, smallSpacing,widget.index,)
                : _buildDesktopProfileSection(iconSize, containerSize, spacing, smallSpacing,widget.index),
            
            // Separator between profile and address
            isMobile
                ? _buildResponsiveDivider()
                : SizedBox(height: spacing),
            
            // Section title for address on mobile
            if (isMobile) ...[
              Center(
                child: Text(
                  "Address Information",
                  style: TextStyle(
                    fontSize: _getResponsiveSize(width, 22, 20, 18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildResponsiveDivider(),
            ],
            
            // Address section
            isMobile
                ? _buildMobileAddressSection(spacing, smallSpacing,widget.index)
                : _buildDesktopAddressSection(spacing, smallSpacing,widget.index),
            
            // Separator between address and tax info
            isMobile
                ? _buildResponsiveDivider()
                : SizedBox(height: spacing),
            
            // Tax information
            _buildTaxInfoSection(spacing, smallSpacing,widget.index),
          ],
        );
      },
    );
  }
  
  Widget _buildMobileProfileSection(
      double iconSize,
      double containerSize,
      double spacing,
      double smallSpacing,
      int index,
      ) {
    return Consumer<CustomerProvider>(
        builder: (context, controller, child) {
          final party = controller.listOfCustomer[controller.selectedPartyIndex!];
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

            // Company details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                aboutContent(title: "Company Name", value:party.companyName),
                aboutContent(title: "Party Name", value:party.partyName),
                aboutContent(title: "Mobile Number", value: party.phone),
                aboutContent(title: "Email", value: party.email),
                aboutContent(title: "GST Number", value: party.gstNumber),
              ],
            ),

            _buildResponsiveDivider(),

            // Account details
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Information",
                  style: _getHeadingTextStyle().copyWith(
                    fontSize: _getResponsiveSize(MediaQuery.of(context).size.width, 18, 16, 14),
                  ),
                ),
                SizedBox(height: smallSpacing),
                aboutContent(title: "Opening Date", value:  party.openingDate != null
                    ? DateFormat('dd-MM-yyyy').format(DateTime.parse(party.openingDate!))
                    : "-",),
                aboutContent(title: "Account", value: "Debit"),
                aboutContent(title: "Opening Balance", value:party.openingBalance),
              ],
            ),
          ],
        );
      }
    );
  }

  Widget _buildDesktopProfileSection(double iconSize, double containerSize, double spacing, double smallSpacing,int index) {
    return  Consumer<CustomerProvider>(
        builder: (context, controller, child) {
          final party = controller.listOfCustomer[controller.selectedPartyIndex!];
        return Row(
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
                        aboutContent(title: "Company Name", value: party.companyName),
                        aboutContent(title: "Party Name", value: party.partyName),
                        aboutContent(title: "Mobile Number", value:party.phone),
                        aboutContent(title: "Email", value: party.email),
                        aboutContent(title: "GST Number", value:party.gstNumber),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                aboutContent(title: "Opening Date",value: party.openingDate),
                aboutContent(title: "Account", value: "Debit"),
                aboutContent(title: "Opening Balance", value:party.openingBalance),
              ],
            ),
          ],
        );
      }
    );
  }

  Widget _buildMobileAddressSection(double spacing, double smallSpacing,int index,) {
    final controller = Provider.of<CustomerProvider>(context);
    final party = controller.listOfCustomer[controller.selectedPartyIndex!];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Billing address
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Billing Address",
              style: _getHeadingTextStyle(),
            ),
            SizedBox(height: smallSpacing),
            Text(
             // "37, Velliyan Street, Muthuramana Patti, Virudhunagar, Tamilnadu, India - 626001",
              party.billingAddress!,
              style: _getBodyTextStyle(),
            ),
          ],
        ),
        
        _buildResponsiveDivider(),
        
        // Shipping address
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shipping Address",
              style: _getHeadingTextStyle(),
            ),
            SizedBox(height: smallSpacing),
            Text(
             // "37, Velliyan Street, Muthuramana Patti, Virudhunagar, Tamilnadu, India - 626001",
              party.shippingAddress!,
              style: _getBodyTextStyle(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopAddressSection(double spacing, double smallSpacing,int index) {
    final controller = Provider.of<CustomerProvider>(context);
    final party = controller.listOfCustomer[controller.selectedPartyIndex!];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Address Information",
          style: _getHeadingTextStyle().copyWith(
            fontSize: _getResponsiveSize(MediaQuery.of(context).size.width, 20, 18, 16),
          ),
        ),
        SizedBox(height: smallSpacing),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Billing Address",
                    style: _getHeadingTextStyle(),
                  ),
                  SizedBox(height: smallSpacing),
                  Text(
                  //  "37, Velliyan Street, Muthuramana Patti, Virudhunagar, Tamilnadu, India - 626001",
                    party.billingAddress!,
                    style: _getBodyTextStyle(),
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
                    style: _getHeadingTextStyle(),
                  ),
                  SizedBox(height: smallSpacing),
                  Text(
                  //  "37, Velliyan Street, Muthuramana Patti, Virudhunagar, Tamilnadu, India - 626001",
                    party.shippingAddress!,
                    style: _getBodyTextStyle(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTaxInfoSection(double spacing, double smallSpacing,int index) {
    final controller = Provider.of<CustomerProvider>(context);
    final party = controller.listOfCustomer[controller.selectedPartyIndex!];
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header for mobile
        if (isMobile) ...[
          Center(
            child: Text(
              "TAX INFORMATION",
              style: TextStyle(
                fontSize: _getResponsiveSize(width, 22, 20, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildResponsiveDivider(),
        ] else ...[
          Text(
            "TAX INFORMATION",
            style: _getHeadingTextStyle().copyWith(
              fontSize: _getResponsiveSize(width, 20, 18, 16),
            ),
          ),
          SizedBox(height: smallSpacing),
        ],
        
        // Tax details
        aboutContent(title: "GSTIN / UIN", value: party.gstNumber),
        aboutContent(title: "Place of Supply", value:party.billingState),
      ],
    );
  }

  Widget _buildResponsiveDivider() {
    final width = MediaQuery.of(context).size.width;
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
      padding: EdgeInsets.symmetric(
        vertical: _getResponsiveSize(MediaQuery.of(context).size.width, 5, 4, 3),
      ),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            "$title:",
            style: _getHeadingTextStyle(),
          ),
          SizedBox(width: _getResponsiveSize(MediaQuery.of(context).size.width, 10, 8, 6)),
          Text(
            "$value", 
            style: _getBodyTextStyle(),
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
  
  TextStyle _getHeadingTextStyle() {
    final width = MediaQuery.of(context).size.width;
    final fontSize = _getResponsiveSize(width, 16, 14, 13);
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );
  }
  
  TextStyle _getBodyTextStyle() {
    final width = MediaQuery.of(context).size.width;
    final fontSize = _getResponsiveSize(width, 16, 14, 13);
    return Theme.of(context).textTheme.labelLarge!.copyWith(
      fontSize: fontSize,
    );
  }
}