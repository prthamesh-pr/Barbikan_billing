import 'package:billing_web/features/purchase_list/viewModel/purchaseBill_list_provider.dart';
import 'package:billing_web/features/utils/on_init.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../product/viewModel/products_provider.dart';

class PurchaseCreateView extends StatefulWidget {
  const PurchaseCreateView({super.key});

  @override
  State<PurchaseCreateView> createState() => _PurchaseCreateViewState();
}

class _PurchaseCreateViewState extends State<PurchaseCreateView> with OnInit{
  // final List<Map<String, dynamic>> productItems = [
  //   {
  //     'id': 1,
  //     'name': 'Laptop',
  //     'qty': 1,
  //     'rate': 45000,
  //     'tax': 18,
  //     'amount': 53100,
  //   },
  // ];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
                style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
              ),
            ),
        ],
      ),
      body: Consumer<PurchaseListProvider>(
        builder: (context, model, child) {

          return SingleChildScrollView(

            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 10 : 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Purchase details card
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 16),
                      child: Padding(
                        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Purchase Details",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
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
                                      controller: model.billNumberController
                                    ),
                                    _buildTextField(
                                      context,
                                      "Date",
                                      "Select date",
                                      Iconsax.calendar,
                                      isSmallScreen: isSmallScreen,
                                      controller: model.billDateController
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
                                        controller: model.billNumberController
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
                                          controller: model.billDateController

                                      ),
                                    ),
                                  ],
                                ),
                            SizedBox(height: isSmallScreen ? 8 : 12),
                            // Party/supplier information

                            _buildTextField(
                              context,
                              "Supplier/Party",
                              "Enter supplier name",
                              Iconsax.profile_2user,
                              isSmallScreen: isSmallScreen,
                              controller: model.partyNameController

                              //TextEditingController(text: model.listOfPurchaseBill.first.partyName),

                              // dropdownItems: listOfPurchaseParty,
                              // selectedValue: model.selectedCategory,
                              // onChanged: (value) {
                              //   model.selectedCategory = value;
                              //   model.partyIdController.text = model.purchaseBillNameToIdMap[value]!;
                              //  // print('object${listO.}')
                              //   model.notifyListeners();
                              // },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Products card
                    Card(
                      color: Colors.white,
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
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isSmallScreen ? 15 : 16,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Add new product line
                                   model.addProduct();

                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: isSmallScreen ? 16 : 18,
                                  ),
                                  label: Text(
                                    "Add Product",
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 12 : 14,
                                    ),
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
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: isSmallScreen ? 10 : 16),
                      child: Padding(
                        padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Payment Details",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: isSmallScreen ? 15 : 16,
                              ),
                            ),
                            SizedBox(height: isSmallScreen ? 12 : 16),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Subtotal:",
                                  style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                                ),
                                Text(
                                //  "₹53,100.00",
                                    "₹${model.totalAmount.toStringAsFixed(2)}",

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
                                Text(
                                  "Tax Amount:",
                                  style: TextStyle(fontSize: isSmallScreen ? 13 : 14),
                                ),
                                Text(
                                  "₹${model.totalTaxAmount.toStringAsFixed(2)}",
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
                                //  "₹53,100.00",
                                 // model.productItems.isNotEmpty? model.productItems.first.subTotal.toString(): '₹0.00',
                                 model.grandTotalString,
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
                              controller: model.paymentMethodController
                              // dropdownItems: listOfPurchaseParty,
                              // selectedValue: model.selectedCategory,
                              // onChanged: (value) {
                              //   model.selectedCategory = value;
                              //   model.partyIdController.text = model.purchaseBillNameToIdMap[value]!;
                              //   model.notifyListeners();
                              // },

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
          );
        }
      ),
      bottomNavigationBar: Consumer<PurchaseListProvider>(
        builder: (context,model, child) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 10 : 16,
              vertical: isSmallScreen ? 8 : 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.05 * 255).toInt()),
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
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 10 : 14,
                      ),
                    ),
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: ()async{
                      if (_formKey.currentState!.validate()){
                      await model.newPurchaseBill(
                          success: (){
                            model. partyNameController.clear();
                            model. paymentMethodController.clear();
                            model.  grandTotalController.clear();
                            model. billDateController.clear();
                            model. billNumberController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Company added successfully')),
                            );
                            Navigator.pop(context);
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        vertical: isSmallScreen ? 10 : 14,
                      ),
                    ),
                    child: Text("Save Purchase"),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label,
    String hint,
    IconData icon, {
    bool isSmallScreen = false,
    TextEditingController? controller,
    TextInputType? keyboardType,
    List<String>? dropdownItems,
    String? selectedValue,
    Function(String?)? onChanged,
    int maxLines = 2,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isSmallScreen ? 8 : 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontSize: isSmallScreen ? 13 : null,
            ),
          ),
          SizedBox(height: isSmallScreen ? 3 : 5),

          dropdownItems != null && dropdownItems.isNotEmpty
              ? DropdownButtonFormField<String>(
            value: selectedValue, // Can be null or default selected value
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down),
            dropdownColor: Colors.white,
            decoration: InputDecoration(

              prefixIcon: Icon(icon, size: isSmallScreen ? 16 : 18),
              filled: true,
              fillColor: const Color(0xffEEEEEE),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 10 : 15,
                vertical: isSmallScreen ? 12 : 15,
              ),
              hintText: hint,
              hintStyle: TextStyle(fontSize: isSmallScreen ? 13 : 14),
            ),
            style: TextStyle(fontSize: isSmallScreen ? 14 : 16,color: Colors.black),
            items: dropdownItems
                .map((item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ))
                .toList(),
            onChanged: onChanged,
          )
              :
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            cursorHeight: isSmallScreen ? 18 : 20,
            style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, size: isSmallScreen ? 16 : 18),
              filled: true,
              fillColor: const Color(0xffEEEEEE),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),

              contentPadding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 10 : 15,
                vertical: isSmallScreen ? 12 : 15,
              ),
              hintText: hint,
              hintStyle: TextStyle(fontSize: isSmallScreen ? 13 : 14),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return  'Please enter $label';
              }
              return null;
            },
          ),

        ],
      ),
    );
  }

  Widget _buildDesktopProductTable() {
    return Consumer<PurchaseListProvider>(
      builder: (context, controller, child) {
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
                    Expanded(
                      flex: 3,
                      child: Text(
                        "Product",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Qty",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Rate",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Tax (%)",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Amount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),

              // Product rows
              ...controller.productItems.map((product) {
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
                                // Text(
                                //   "Product",
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w500,
                                //     fontSize: 12,
                                //   ),
                                // ),
                                SizedBox(height: 4),
                                // TextFormField(
                                //   initialValue: product['name'],
                                //   decoration: InputDecoration(
                                //     hintText: "Select product",
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(4),
                                //     ),
                                //     contentPadding: EdgeInsets.symmetric(
                                //       horizontal: 8,
                                //       vertical: 8,
                                //     ),
                                //   ),
                                //   style: TextStyle(fontSize: 13),
                                // ),
                                _buildTextField(
                                  context,
                                  "Product",
                                  "Select Product name",
                                  Iconsax.profile_2user,
                                  // isSmallScreen: isSmallScreen,
                                  // dropdownItems: model.listOfProducts
                                  //     .map((e) => e.productName ?? '')
                                  //     .toList(),
                                  // selectedValue: model.selectedProduct,
                                  // onChanged: (value) {
                                  //   model.selectedProduct = value;
                                  //   model.notifyListeners();
                                  // },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              controller.removeProduct(product);

                            },
                            icon: Icon(Icons.delete_outline),
                            iconSize: 25,
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
                                  //  initialValue: product.qtyController.toString(),
                                  controller: product.qtyController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
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
                                  // initialValue: product.rateController.toString(),
                                  controller: product.rateController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
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
                                  //  initialValue: product.tax.toString(),
                                  controller: product.taxController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 13),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          // Tax Amount
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Tax Amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey[300]!),
                                    color: Colors.grey[50],
                                  ),
                                  child: Text(
                                    "₹${product.taxAmount}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey[300]!),
                                    color: Colors.grey[50],
                                  ),
                                  child: Text(
                                    "₹${product.amount}",
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
              }),
            ],
          ),
        );
      }
    );
  }

  Widget _buildMobileProductList() {

    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    return Consumer<PurchaseListProvider>(
      builder: (context,controller, child) {
      //  print("Product list count: ${controller.productItems.length}");

        return Column(
          children:
             controller. productItems.map((product) {
            // return _buildProductCard(product, isSmallScreen);
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
                                // Text(
                                //   "Product",
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.w500,
                                //     fontSize: 12,
                                //   ),
                                // ),
                                SizedBox(height: 4),
                                // TextFormField(
                                //   initialValue: product['name'],
                                //   decoration: InputDecoration(
                                //     hintText: "Select product",
                                //     border: OutlineInputBorder(
                                //       borderRadius: BorderRadius.circular(4),
                                //     ),
                                //     contentPadding: EdgeInsets.symmetric(
                                //       horizontal: 8,
                                //       vertical: 8,
                                //     ),
                                //   ),
                                //   style: TextStyle(fontSize: 13),
                                // ),
                                _buildTextField(
                                  context,
                                   "Product",
                                   "Select Product name",
                                  Iconsax.profile_2user,
                                  isSmallScreen: isSmallScreen,
                                  // dropdownItems: model.listOfProducts
                                  //     .map((e) => e.productName ?? '')
                                  //     .toList(),
                                  // selectedValue: model.selectedProduct,
                                  // onChanged: (value) {
                                  //   model.selectedProduct = value;
                                  //
                                  //   model.notifyListeners();
                                  // },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () {
                              controller.removeProduct(product);

                            },
                            icon: Icon(Icons.delete_outline),
                            iconSize: 25,
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
                                //  initialValue: product.qtyController.toString(),
                                  controller: product.qtyController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
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
                                 // initialValue: product.rateController.toString(),
                                  controller: product.rateController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
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
                                //  initialValue: product.tax.toString(),
                                  controller: product.taxController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 8,
                                    ),
                                  ),
                                  style: TextStyle(fontSize: 13),
                                  keyboardType: TextInputType.number,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 8),
                          // Tax Amount
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  " Tax Amount",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey[300]!),
                                    color: Colors.grey[50],
                                  ),
                                  child: Text(
                                    "₹${product.taxAmount}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
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
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 9,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.grey[300]!),
                                    color: Colors.grey[50],
                                  ),
                                  child: Text(
                                    "₹${product.amount}",
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
    );
  }

  // Widget _buildProductCard(ProductItem product, bool isSmallScreen) {
  //   return Consumer<PurchaseListProvider>(
  //       builder: (context,controller, child) {
  //       return Container(
  //         margin: EdgeInsets.only(bottom: 10),
  //         padding: EdgeInsets.all(10),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.grey[300]!),
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       // Text(
  //                       //   "Product",
  //                       //   style: TextStyle(
  //                       //     fontWeight: FontWeight.w500,
  //                       //     fontSize: 12,
  //                       //   ),
  //                       // ),
  //                       SizedBox(height: 4),
  //                       // TextFormField(
  //                       //   initialValue: product['name'],
  //                       //   decoration: InputDecoration(
  //                       //     hintText: "Select product",
  //                       //     border: OutlineInputBorder(
  //                       //       borderRadius: BorderRadius.circular(4),
  //                       //     ),
  //                       //     contentPadding: EdgeInsets.symmetric(
  //                       //       horizontal: 8,
  //                       //       vertical: 8,
  //                       //     ),
  //                       //   ),
  //                       //   style: TextStyle(fontSize: 13),
  //                       // ),
  //                       _buildTextField(
  //                         context,
  //                         "Product",
  //                         "Select Product name",
  //                         Iconsax.profile_2user,
  //                         isSmallScreen: isSmallScreen,
  //                         // dropdownItems: model.listOfProducts
  //                         //     .map((e) => e.productName ?? '')
  //                         //     .toList(),
  //                         // selectedValue: model.selectedProduct,
  //                         // onChanged: (value) {
  //                         //   model.selectedProduct = value;
  //                         //
  //                         //   model.notifyListeners();
  //                         // },
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(width: 10),
  //                 IconButton(
  //                   onPressed: () {
  //                     controller.removeProduct(product);
  //
  //                   },
  //                   icon: Icon(Icons.delete_outline),
  //                   iconSize: 25,
  //                   padding: EdgeInsets.zero,
  //                   constraints: BoxConstraints(),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 8),
  //             Row(
  //               children: [
  //                 // Quantity
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Qty",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 12,
  //                         ),
  //                       ),
  //                       SizedBox(height: 4),
  //                       TextFormField(
  //                         //  initialValue: product.qtyController.toString(),
  //                         controller: product.qtyController,
  //                         decoration: InputDecoration(
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(4),
  //                           ),
  //                           contentPadding: EdgeInsets.symmetric(
  //                             horizontal: 8,
  //                             vertical: 8,
  //                           ),
  //                         ),
  //                         style: TextStyle(fontSize: 13),
  //                         keyboardType: TextInputType.number,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(width: 8),
  //                 // Rate
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Rate",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 12,
  //                         ),
  //                       ),
  //                       SizedBox(height: 4),
  //                       TextFormField(
  //                         // initialValue: product.rateController.toString(),
  //                         controller: product.rateController,
  //                         decoration: InputDecoration(
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(4),
  //                           ),
  //                           contentPadding: EdgeInsets.symmetric(
  //                             horizontal: 8,
  //                             vertical: 8,
  //                           ),
  //                         ),
  //                         style: TextStyle(fontSize: 13),
  //                         keyboardType: TextInputType.number,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 8),
  //             Row(
  //               children: [
  //                 // Tax
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Tax (%)",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 12,
  //                         ),
  //                       ),
  //                       SizedBox(height: 4),
  //                       TextFormField(
  //                         //  initialValue: product.tax.toString(),
  //                         controller: product.taxController,
  //                         decoration: InputDecoration(
  //                           border: OutlineInputBorder(
  //                             borderRadius: BorderRadius.circular(4),
  //                           ),
  //                           contentPadding: EdgeInsets.symmetric(
  //                             horizontal: 8,
  //                             vertical: 8,
  //                           ),
  //                         ),
  //                         style: TextStyle(fontSize: 13),
  //                         keyboardType: TextInputType.number,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 SizedBox(width: 8),
  //                 // Tax Amount
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         " Tax Amount",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 12,
  //                         ),
  //                       ),
  //                       SizedBox(height: 4),
  //                       Container(
  //                         padding: EdgeInsets.symmetric(
  //                           horizontal: 10,
  //                           vertical: 9,
  //                         ),
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(4),
  //                           border: Border.all(color: Colors.grey[300]!),
  //                           color: Colors.grey[50],
  //                         ),
  //                         child: Text(
  //                           "₹${product.taxAmount}",
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 13,
  //                           ),
  //                         ),
  //                       ),
  //
  //                     ],
  //                   ),
  //                 ),
  //                 // Amount
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         "Amount",
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           fontSize: 12,
  //                         ),
  //                       ),
  //                       SizedBox(height: 4),
  //                       Container(
  //                         padding: EdgeInsets.symmetric(
  //                           horizontal: 10,
  //                           vertical: 9,
  //                         ),
  //                         decoration: BoxDecoration(
  //                           borderRadius: BorderRadius.circular(4),
  //                           border: Border.all(color: Colors.grey[300]!),
  //                           color: Colors.grey[50],
  //                         ),
  //                         child: Text(
  //                           "₹${product.amount}",
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w500,
  //                             fontSize: 13,
  //                           ),
  //                         ),
  //                       ),
  //
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     }
  //   );
  // }


  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<ProductsProvider>(context,listen: false).initState();
  }
}
