import 'package:billing_web/features/category/viewModel/cetegory_provider.dart';
import 'package:billing_web/features/utils/on_init.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'create_category_view.dart';
import 'edit_category_view.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> with OnInit {
  // final List<Map<String, dynamic>> categoryList = [
  //   {
  //     'sno': 1,
  //     'categoryName': 'Electronics',
  //     'active': true,
  //     'noOfProducts': 120,
  //   },
  //   {'sno': 2, 'categoryName': 'Fashion', 'active': false, 'noOfProducts': 80},
  //   {
  //     'sno': 3,
  //     'categoryName': 'Home Appliances',
  //     'active': true,
  //     'noOfProducts': 50,
  //   },
  // ];

  void _showCategoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CategoryEditView();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    
    return Scaffold(
      body: Consumer<CategoryProvider>(
        builder: (context, controller, child) {
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
      ),
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

    final provider = Provider.of<CategoryProvider>(context);
    final categoryList = provider.listOfCategory;

    return DataTable(
      columnSpacing: 20.0,
      columns: [
        DataColumn(label: Text('S.NO')),
        DataColumn(label: Text('Category Name')),
        DataColumn(label: Text('Active')),
        DataColumn(label: Text('No. of Products')),
        DataColumn(label: Text('Action')),
      ],
      rows:  List.generate(categoryList.length, (index){
        final category = categoryList[index];
        return DataRow(
          cells: [
            DataCell(Text({index + 1}.toString())),
            DataCell(Text(category.categoryName!)),
            DataCell(
              Switch(
                value: category.isActive!,
                onChanged: (bool newValue) {
                  setState(() {
                    category.isActive= newValue;
                  });
                },
              ),
            ),
            DataCell(Text(category.noOfProducts.toString())),
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
    return Consumer<CategoryProvider>(
      builder: (context, controller, child) {
        return Column(
            children:[
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.listOfCategory.length,
                itemBuilder: (context, index){
                  final user = controller.listOfCategory[index];
             return  Card(
               color: Colors.white,
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
                        'S.NO: ${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Category: ${user.categoryName}',
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
                        '${user.noOfProducts}',
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
                        value: user.isActive!,
                        onChanged: (bool newValue) {
                          setState(() {
                            user.isActive = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                // Action buttons
                GestureDetector(
                  onTapDown: (TapDownDetails details) async {
                    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

                    final value = await showMenu(
                      context: context,
                      position: RelativeRect.fromRect(
                        details.globalPosition & const Size(40, 40),
                        Offset.zero & overlay.size,
                      ),

                      color: Colors.white,
                      items: [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: const [
                              Icon(Icons.edit, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: const [
                              Icon(Icons.delete, color: Colors.black),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                    );

                    if (value == 'edit') {
                      print('Edit Clicked');
                      controller.loadUserData(user);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryEditView()));
                    } else if (value == 'delete') {

                      bool confirmDelete = await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,

                          title: Text('Confirm Delete'),
                          content: Text('Are you sure you want to delete this company?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );

                      if (confirmDelete == true) {
                        // print("user.id!===${user.id!}");
                        await controller.deleteCategory(user.id!);
                        //controller.deleteUsers(user.id!);

                      }
                    }
                  },
                  child: Icon(Icons.more_horiz),
                )
              ],
            ),
          ],
        ),
          ),
        );
                })
             ]
        );
      }
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<CategoryProvider>(context,listen: false).initState();
  }
}