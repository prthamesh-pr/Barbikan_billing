import 'package:billing_web/features/category/viewModel/cetegory_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'category_list_view.dart';

class CategoryEditView extends StatefulWidget {
  const CategoryEditView({super.key});

  @override
  State<CategoryEditView> createState() => _CategoryEditViewState();
}

class _CategoryEditViewState extends State<CategoryEditView> {
  // TextEditingController categoryController = TextEditingController();
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive calculations
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    // Calculate responsive sizes
    final double dialogWidth = isSmallScreen
        ? screenSize.width * 0.9
        : screenSize.width < 1200
        ? 400
        : 500;

    final double iconSize = isSmallScreen ? 16 : 20;
    final double paddingScale = isSmallScreen ? 0.8 : 1.0;
    final double buttonPadding = isSmallScreen ? 10 : 15;

    // Responsive text styles
    final TextStyle titleStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
      fontSize: isSmallScreen ? 18 : 22,
    );

    final TextStyle subtitleStyle = Theme.of(context).textTheme.bodyMedium!.copyWith(
      fontSize: isSmallScreen ? 12 : 14,
    );

    final TextStyle buttonTextStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
      fontSize: isSmallScreen ? 12 : 14,
    );

    return Consumer<CategoryProvider>(
        builder: (context, controller, child) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: dialogWidth,
                  constraints: BoxConstraints(
                    maxWidth: 600, // Maximum width on large screens
                    minWidth: 280, // Minimum width on very small screens
                  ),
                  padding: EdgeInsets.all(15 * paddingScale),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Update Category",
                                  style: titleStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Add a new category for better organization",
                                  style: subtitleStyle,
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
                                  child: Icon(
                                      Icons.close,
                                      size: iconSize
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25 * paddingScale),
                      TextField(
                        controller: controller.categoryNameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.tag, size: iconSize),
                          filled: true,
                          fillColor: const Color(0xffEEEEEE),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15 * paddingScale,
                            vertical: 15 * paddingScale,
                          ),
                          labelText: "Category Name",
                          labelStyle: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ),
                      SizedBox(height: 20 * paddingScale),
                      TextField(
                        controller: controller.noOfProductController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.tag, size: iconSize),
                          filled: true,
                          fillColor: const Color(0xffEEEEEE),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15 * paddingScale,
                            vertical: 15 * paddingScale,
                          ),
                          labelText: "No. of Product",
                          labelStyle: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ),

                      _buildFooterButtons(
                          context,
                          buttonPadding,
                          buttonTextStyle,
                          paddingScale,
                          isSmallScreen
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }

  Widget _buildFooterButtons(
      BuildContext context,
      double buttonPadding,
      TextStyle buttonTextStyle,
      double paddingScale,
      bool isSmallScreen
      ) {
    return Consumer<CategoryProvider>(
        builder: (context,controller, child) {
          return Container(
            padding: EdgeInsets.all(10 * paddingScale),
            child: isSmallScreen
            // Stack buttons vertically on very small screens
                ? Column(
              children: [
                _buildButton(
                  context,
                  "Cancel",
                  Colors.grey.shade600,
                  const Color(0xffEEEEEE),
                  buttonPadding,
                  buttonTextStyle,
                  isSmallScreen, onPressed: () {
                  Navigator.of(context).pop();
                },
                ),
                SizedBox(height: 10 * paddingScale),
                _buildButton(
                  context,
                  "Update",
                  Colors.white,
                  Theme.of(context).primaryColor,
                  buttonPadding,
                  buttonTextStyle,
                  isSmallScreen, onPressed: ()  async{

                  await controller.newCategory(
                    success: () async {
                      print("Success callback reached");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Category updated successfully")),
                      );
                      await Future.delayed(Duration(milliseconds: 300));
                      print("Navigating to CompanyListView...");
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => CategoryListView()),
                      );

                    },
                    failure: (error) {
                      print("Failure callback: $error");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Update failed: $error")),
                      );
                    },
                  );
                },
                ),
              ],
            )
            // Row layout for larger screens
                : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildButton(
                  context,
                  "Cancel",
                  Colors.grey.shade600,
                  const Color(0xffEEEEEE),
                  buttonPadding,
                  buttonTextStyle,
                  isSmallScreen, onPressed: () {
                  Navigator.of(context).pop();
                },
                ),
                SizedBox(width: 10 * paddingScale),
                _buildButton(
                  context,
                  "Update",
                  Colors.white,
                  Theme.of(context).primaryColor,
                  buttonPadding,
                  buttonTextStyle,
                  isSmallScreen, onPressed: () async{
                  await controller.putPurchasePartyUpdate(
                      success: (){
                        controller.categoryNameController.clear();
                        controller.noOfProductController.clear();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Category added successfully')),
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
      Color bgColor,
      double padding,
      TextStyle style,
      bool isSmallScreen, {
        required VoidCallback onPressed,
      }) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: isSmallScreen ? double.infinity : null,
          padding: EdgeInsets.symmetric(
            horizontal: padding,
            vertical: isSmallScreen ? padding * 0.8 : padding * 0.6,
          ),
          child: Text(
            text,
            textAlign: isSmallScreen ? TextAlign.center : TextAlign.start,
            style: style.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }

}