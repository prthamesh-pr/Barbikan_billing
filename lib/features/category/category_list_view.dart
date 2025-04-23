import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'create_category_view.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  final List<Map<String, dynamic>> categoryList = [
    {
      'sno': 1,
      'categoryName': 'Electronics',
      'active': true,
      'noOfProducts': 120,
    },
    {'sno': 2, 'categoryName': 'Fashion', 'active': false, 'noOfProducts': 80},
    {
      'sno': 3,
      'categoryName': 'Home Appliances',
      'active': true,
      'noOfProducts': 50,
    },
  ];

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoryCreateView();
      },
    );
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
              child: isSmallScreen
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Category List",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              "Manage and features all categories",
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
                              "Category List",
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              "Manage and features all categories",
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
              child: isSmallScreen
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
      onTap: _showCategoryDialog,
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
            Icon(Icons.add, color: Colors.white, size: isVerySmallScreen ? 16 : 20),
            SizedBox(width: isVerySmallScreen ? 5 : 10),
            Text(
              isVerySmallScreen ? "Add New" : "Add New Category",
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
        DataColumn(label: Text('Category Name')),
        DataColumn(label: Text('Active')),
        DataColumn(label: Text('No. of Products')),
        DataColumn(label: Text('Action')),
      ],
      rows: categoryList.map((category) {
        return DataRow(
          cells: [
            DataCell(Text(category['sno'].toString())),
            DataCell(Text(category['categoryName'])),
            DataCell(
              Switch(
                value: category['active'],
                onChanged: (bool newValue) {
                  setState(() {
                    category['active'] = newValue;
                  });
                },
              ),
            ),
            DataCell(Text(category['noOfProducts'].toString())),
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
      children: categoryList.map((category) {
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
                    // S.NO and Category Name
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'S.NO: ${category['sno']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Category: ${category['categoryName']}',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.visible,
                          ),
                        ],
                      ),
                    ),
                    // No. of Products
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Products:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${category['noOfProducts']}',
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
                        Text('Active:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: category['active'],
                            onChanged: (bool newValue) {
                              setState(() {
                                category['active'] = newValue;
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
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(Iconsax.edit, size: 16),
                          label: Text('Edit', style: TextStyle(fontSize: 12)),
                          onPressed: () {
                            // Handle edit action
                          },
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            minimumSize: Size(0, 32),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: Icon(Iconsax.trash, size: 16),
                          label: Text('Delete', style: TextStyle(fontSize: 12)),
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