import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../config.dart';
import 'product_create_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  final List<Map<String, dynamic>> productList = [
    {
      'sno': 1,
      'productName': 'Laptop',
      'category': 'Electronics',
      'currentStock': 50,
      'active': true,
    },
    {
      'sno': 2,
      'productName': 'Smartphone',
      'category': 'Electronics',
      'currentStock': 150,
      'active': false,
    },
    {
      'sno': 3,
      'productName': 'Headphones',
      'category': 'Accessories',
      'currentStock': 80,
      'active': true,
    },
  ];

  void _showProductDialog() {
    // Try the EndDrawer approach first
    try {
      creationPageConfig.changePage(ProductCreateView());
      scaffoldKey.currentState!.openEndDrawer();
    } catch (e) {
      // Fallback to dialog approach if the drawer fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: ProductCreateView(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          padding: EdgeInsets.all(isSmallScreen ? 10 : 15),
          children: [
            // Header section
            SizedBox(
              width: double.infinity,
              child:
                  isSmallScreen
                      ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product List",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                "Manage and view all products",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          _buildAddButton(context),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product List",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                "Manage and view all products",
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          _buildAddButton(context),
                        ],
                      ),
            ),

            SizedBox(height: 15),

            // Data table section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              width: double.infinity,
              child:
                  isSmallScreen
                      ? _buildMobileDataView()
                      : _buildDesktopDataTable(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isVerySmallScreen = screenWidth < 360;

    return GestureDetector(
      onTap: _showProductDialog,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isVerySmallScreen ? 10 : 15,
          vertical: isVerySmallScreen ? 6 : 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: isVerySmallScreen ? 16 : 20,
            ),
            SizedBox(width: isVerySmallScreen ? 5 : 10),
            Text(
              isVerySmallScreen ? "Add New" : "Add New Product",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: Colors.white,
                fontSize: isVerySmallScreen ? 12 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopDataTable() {
    return DataTable(
      columnSpacing: 20.0,
      columns: [
        DataColumn(label: Text('S.NO')),
        DataColumn(label: Text('Product Name')),
        DataColumn(label: Text('Category')),
        DataColumn(label: Text('Current Stock')),
        DataColumn(label: Text('Active')),
        DataColumn(label: Text('Action')),
      ],
      rows:
          productList.map((product) {
            return DataRow(
              cells: [
                DataCell(Text(product['sno'].toString())),
                DataCell(Text(product['productName'])),
                DataCell(Text(product['category'])),
                DataCell(Text(product['currentStock'].toString())),
                DataCell(
                  Switch(
                    value: product['active'],
                    onChanged: (bool newValue) {
                      setState(() {
                        product['active'] = newValue;
                      });
                    },
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        color: Colors.blue,
                        icon: Icon(Iconsax.edit),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Iconsax.trash),
                        onPressed: () {
                          // Handle delete action
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildMobileDataView() {
    return Column(
      children:
          productList.map((product) {
            return Card(
              margin: EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // S.NO and Product Name
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'S.NO: ${product['sno']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Product: ${product['productName']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                            ],
                          ),
                        ),
                        // Category and Current Stock
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Category:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${product['category']}',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Stock:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                '${product['currentStock']}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Active status and Action buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Active switch
                        Row(
                          children: [
                            Text(
                              'Active:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: product['active'],
                                onChanged: (bool newValue) {
                                  setState(() {
                                    product['active'] = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        // Action buttons
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                minimumSize: Size(0, 32),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(Iconsax.edit, size: 16),
                              label: Text(
                                'Edit',
                                style: TextStyle(fontSize: 12),
                              ),
                              onPressed: () {
                                // Handle edit action
                              },
                            ),
                            SizedBox(width: 8),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                minimumSize: Size(0, 32),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              icon: Icon(Iconsax.trash, size: 16),
                              label: Text(
                                'Delete',
                                style: TextStyle(fontSize: 12),
                              ),
                              onPressed: () {
                                // Handle delete action
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
