import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PurchaseCreateView extends StatefulWidget {
  const PurchaseCreateView({super.key});

  @override
  State<PurchaseCreateView> createState() => _PurchaseCreateViewState();
}

class _PurchaseCreateViewState extends State<PurchaseCreateView> {
  final List<Map<String, dynamic>> productItems = [
    {
      'id': 1,
      'name': 'Laptop',
      'qty': 1,
      'rate': 45000,
      'tax': 18,
      'amount': 53100,
    }
  ];
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titleSpacing: 0,
        centerTitle: false,
        title: ListTile(
          title: Text(
            "Create New Purchase Bill",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: isSmallScreen ? 16 : 18,
            ),
          ),
          subtitle: Text(
            "Barbikan Technologies Private Limited",
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: Colors.black45,
              fontSize: isSmallScreen ? 11 : 12,
            ),
          ),
        ),
        actions: [
          if (!isSmallScreen)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
                label: Text("Close"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 10 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Purchase details card
              Card(
                margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 16),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Purchase Details",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 15 : 16,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      isSmallScreen
                          ? Column(
                              children: [
                                _buildTextField(
                                  context, 
                                  "Bill Number", 
                                  "Enter bill number",
                                  Iconsax.receipt,
                                  isSmallScreen: isSmallScreen,
                                ),
                                _buildTextField(
                                  context, 
                                  "Date", 
                                  "Select date",
                                  Iconsax.calendar,
                                  isSmallScreen: isSmallScreen,
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    context, 
                                    "Bill Number", 
                                    "Enter bill number",
                                    Iconsax.receipt,
                                    isSmallScreen: isSmallScreen,
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: _buildTextField(
                                    context, 
                                    "Date", 
                                    "Select date",
                                    Iconsax.calendar,
                                    isSmallScreen: isSmallScreen,
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      // Party/supplier information
                      _buildTextField(
                        context, 
                        "Supplier/Party", 
                        "Select or enter supplier name",
                        Iconsax.profile_2user,
                        isSmallScreen: isSmallScreen,
                      ),
                    ],
                  ),
                ),
              ),
              
              // Products card
              Card(
                margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 16),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Products",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: isSmallScreen ? 15 : 16,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Add new product line
                              setState(() {
                                productItems.add({
                                  'id': productItems.length + 1,
                                  'name': '',
                                  'qty': 1,
                                  'rate': 0,
                                  'tax': 0,
                                  'amount': 0,
                                });
                              });
                            },
                            icon: Icon(Icons.add, size: isSmallScreen ? 16 : 18),
                            label: Text(
                              "Add Product",
                              style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: isSmallScreen ? 8 : 12,
                                vertical: isSmallScreen ? 4 : 8,
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 10 : 16),
                      
                      // Products list
                      isSmallScreen
                          ? _buildMobileProductList()
                          : _buildDesktopProductTable(),
                    ],
                  ),
                ),
              ),
              
              // Payment details
              Card(
                margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 16),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Payment Details",
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: isSmallScreen ? 15 : 16,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal:", style: TextStyle(fontSize: isSmallScreen ? 13 : 14)),
                          Text(
                            "₹53,100.00",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 13 : 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 6 : 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tax Amount:", style: TextStyle(fontSize: isSmallScreen ? 13 : 14)),
                          Text(
                            "₹8,100.00",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 13 : 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Divider(height: isSmallScreen ? 20 : 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Grand Total:",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 14 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹53,100.00",
                            style: TextStyle(
                              fontSize: isSmallScreen ? 16 : 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 12 : 16),
                      _buildTextField(
                        context, 
                        "Payment Method", 
                        "Select payment method",
                        Iconsax.wallet,
                        isSmallScreen: isSmallScreen,
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 12),
                      _buildTextField(
                        context, 
                        "Notes", 
                        "Enter additional notes (optional)",
                        Iconsax.note,
                        isSmallScreen: isSmallScreen,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 10 : 16,
          vertical: isSmallScreen ? 8 : 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 10 : 14,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Save purchase and return
                  Navigator.pop(context, true);
                },
                child: Text("Save Purchase"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: isSmallScreen ? 10 : 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    String hint,
    IconData icon, {
    bool isSmallScreen = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 8 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: isSmallScreen ? 13 : 14,
            ),
          ),
          SizedBox(height: 4),
          TextFormField(
            maxLines: maxLines,
            style: TextStyle(fontSize: isSmallScreen ? 14 : 15),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 10 : 12,
                vertical: isSmallScreen ? 8 : 10,
              ),
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.grey[400],
                fontSize: isSmallScreen ? 13 : 14,
              ),
              prefixIcon: Icon(icon, size: isSmallScreen ? 18 : 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopProductTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Table header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(flex: 3, child: Text("Product", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text("Qty", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text("Rate", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text("Tax (%)", style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold))),
                SizedBox(width: 40),
              ],
            ),
          ),
          
          // Product rows
          ...productItems.map((product) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      initialValue: product['name'],
                      decoration: InputDecoration(
                        hintText: "Select product",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      initialValue: product['qty'].toString(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      initialValue: product['rate'].toString(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      initialValue: product['tax'].toString(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      ),
                      style: TextStyle(fontSize: 14),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "₹${product['amount']}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 32,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          productItems.remove(product);
                        });
                      },
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                      iconSize: 18,
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildMobileProductList() {
    return Column(
      children: productItems.map((product) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Product",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextFormField(
                          initialValue: product['name'],
                          decoration: InputDecoration(
                            hintText: "Select product",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          ),
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        productItems.remove(product);
                      });
                    },
                    icon: Icon(Icons.delete_outline, color: Colors.red),
                    iconSize: 18,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  // Quantity
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Qty",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextFormField(
                          initialValue: product['qty'].toString(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          ),
                          style: TextStyle(fontSize: 13),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  // Rate
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rate",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextFormField(
                          initialValue: product['rate'].toString(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          ),
                          style: TextStyle(fontSize: 13),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  // Tax
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tax (%)",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        TextFormField(
                          initialValue: product['tax'].toString(),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          ),
                          style: TextStyle(fontSize: 13),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  // Amount
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Amount",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey[300]!),
                            color: Colors.grey[50],
                          ),
                          child: Text(
                            "₹${product['amount']}",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
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
        );
      }).toList(),
    );
  }
}