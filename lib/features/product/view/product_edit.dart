import 'package:billing_web/features/product/viewModel/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class ProductEditView extends StatefulWidget {
  const ProductEditView({super.key});

  @override
  State<ProductEditView> createState() => _ProductEditViewState();
}

class _ProductEditViewState extends State<ProductEditView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ProductsProvider>(context, listen: false).initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 900;

    return Scaffold(
      body: SafeArea(
        child: Consumer<ProductsProvider>(
            builder: (context, controller, child) {
              // final categoryProvider = Provider.of<CategoryProvider>(context, listen: true);
        
              // print("Dropdown Items: $categoryList");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Padding(
                    padding: EdgeInsets.all(isSmallScreen ? 10.0 : 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Create Product",
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: isSmallScreen ? 18 : null,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Add and manage your product details",
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontSize: isSmallScreen ? 12 : null,
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
                            height: isSmallScreen ? 32 : 40,
                            width: isSmallScreen ? 32 : 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xffEEEEEE),
                            ),
                            child: Center(
                                child: Icon(
                                    Icons.close,
                                    size: isSmallScreen ? 16 : 20
                                )
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
                      padding: EdgeInsets.all(isSmallScreen ? 10 : 15),
                      children: [
                        // Product Name and Category
                        isSmallScreen
                            ? Column(
                          children: [
                            _buildInputField(
                                context,
                                "Product Name",
                                "Enter Product Name",
                                Iconsax.box,
                                isSmallScreen: isSmallScreen,
                                controller:controller.productNameController
                            ),
        
                            _buildInputField(
                                context,
                                "Category",
                                "Select Category",
                                Iconsax.category,
                                isSmallScreen: isSmallScreen,
                                controller:controller.categoryNameController
                              // dropdownItems: categoryList,
                              //   selectedValue: controller.selectedCategory,
                              // onChanged: (value) {
                              //
                              //   controller.selectedCategory = value;
                              //
                              // //  final categoryId = controller.categoryNameToIdMap[value?.trim()];
                              //
                              //     controller.categoryIdController.text = ''; // Handle missing category ID
                              //   }
        
        
                            ),
                          ],
                        )
        
                            : Row(
                          children: [
                            Expanded(
                              child: _buildInputField(
                                  context,
                                  "Product Name",
                                  "Enter Product Name",
                                  Iconsax.box,
                                  isSmallScreen: isSmallScreen,
                                  controller:controller.productNameController
                              ),
                            ),
                            SizedBox(width: isMediumScreen ? 8 : 10),
                            Expanded(
                              child: _buildInputField(
                                  context,
                                  "Category",
                                  "Enter Category",
                                  Iconsax.category,
                                  isSmallScreen: isSmallScreen,
                                  controller:controller.categoryNameController
                              ),
                            ),
                          ],
                        ),
        
                        // HSN and Item Code
                        isSmallScreen
                            ? Column(
                          children: [
                            _buildInputField(
                              context,
                              "HSN No (Optional)",
                              "Enter HSN Number",
                              Iconsax.document,
                              isSmallScreen: isSmallScreen,
                              //controller:controller.
                            ),
                            _buildInputField(
                              context,
                              "Item Code (Optional)",
                              "Enter Item Code",
                              Iconsax.barcode,
                              isSmallScreen: isSmallScreen,
                            ),
                          ],
                        )
                            : Row(
                          children: [
                            Expanded(
                              child: _buildInputField(
                                context,
                                "HSN No",
                                "Enter HSN Number",
                                Iconsax.document,
                                isSmallScreen: isSmallScreen,
                              ),
                            ),
                            SizedBox(width: isMediumScreen ? 8 : 10),
                            Expanded(
                              child: _buildInputField(
                                context,
                                "Item Code",
                                "Enter Item Code",
                                Iconsax.barcode,
                                isSmallScreen: isSmallScreen,
                                //keyboardType: TextInputType.number
                              ),
                            ),
                          ],
                        ),
        
                        SizedBox(height: isSmallScreen ? 10 : 15),
                        const Divider(height: 0, color: Color(0xffEEEEEE)),
                        SizedBox(height: isSmallScreen ? 8 : 10),
        
                        // Stock Details Section
                        _buildSectionHeader(context, "Stock Details", isSmallScreen: isSmallScreen),
                        SizedBox(height: isSmallScreen ? 8 : 10),
        
                        // Opening Stock and Min Stock
                        isSmallScreen
                            ? Column(
                          children: [
                            _buildInputField(
                                context,
                                "Opening Stock",
                                "Enter Opening Stock",
                                Iconsax.box_tick,
                                isSmallScreen: isSmallScreen,
                                controller:controller.openingStockController
                            ),
                            _buildInputField(
                                context,
                                "Min Stock",
                                "Enter Minimum Stock",
                                Iconsax.danger,
                                isSmallScreen: isSmallScreen,
                                controller:controller.minStockController
                            ),
                          ],
                        )
                            : Row(
                          children: [
                            Expanded(
                              child: _buildInputField(
                                  context,
                                  "Opening Stock",
                                  "Enter Opening Stock",
                                  Iconsax.box_tick,
                                  isSmallScreen: isSmallScreen,
                                  controller:controller.openingStockController
                              ),
                            ),
                            SizedBox(width: isMediumScreen ? 8 : 10),
                            Expanded(
                              child: _buildInputField(
                                  context,
                                  "Min Stock",
                                  "Enter Minimum Stock",
                                  Iconsax.danger,
                                  isSmallScreen: isSmallScreen,
                                  controller:controller.minStockController
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
        
                  // Footer buttons
                  _buildFooterButtons(context, isSmallScreen),
                ],
              );
            }
        ),
      ),
    );
  }

  Widget _buildInputField(
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
          ),

        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context,
      String title, {
        bool isSmallScreen = false,
      }) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge!.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: isSmallScreen ? 14 : 16,
      ),
    );
  }

  Widget _buildFooterButtons(BuildContext context, bool isSmallScreen) {
    return Consumer<ProductsProvider>(
        builder: (context, controller, child) {
          return Container(
            padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: _buildButton(
                    context,
                    "Cancel",
                    Colors.grey.shade600,
                    const Color(0xffEEEEEE),
                    isSmallScreen: isSmallScreen,
                  ),
                ),
                SizedBox(width: isSmallScreen ? 8 : 10),

                GestureDetector(
                  onTap: () async{
                    print('this button tapped');
                    await controller.putProductsUpdate(
                        success: (){
                          controller. productNameController.clear();
                          controller.  categoryNameController.clear();
                          controller.  openingStockController.clear();
                          controller.  minStockController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product added successfully')),
                          );
                          Navigator.pop(context);
                        },
                        failure: (message) {

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $message')),
                          );
                        }
                    );
                  },
                  child: _buildButton(
                    context,
                    "Update",
                    Colors.white,
                    Theme.of(context).primaryColor,
                    isSmallScreen: isSmallScreen,
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildButton(
      BuildContext context,
      String text,
      Color textColor,
      Color bgColor, {
        bool isSmallScreen = false,
      }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 12 : 15,
        vertical: isSmallScreen ? 6 : 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: bgColor,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge!.copyWith(
          color: textColor,
          fontSize: isSmallScreen ? 13 : 14,
        ),
      ),
    );
  }
}