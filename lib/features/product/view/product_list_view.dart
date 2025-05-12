import 'package:billing_web/features/category/viewModel/cetegory_provider.dart';
import 'package:billing_web/features/product/view/product_edit.dart';
import 'package:billing_web/features/product/viewModel/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../config.dart';
import '../../utils/on_init.dart';
import 'product_create_view.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> with OnInit {
  // final List<Map<String, dynamic>> productList = [
  //   {
  //     'sno': 1,
  //     'productName': 'Laptop',
  //     'category': 'Electronics',
  //     'currentStock': 50,
  //     'active': true,
  //   },
  //   {
  //     'sno': 2,
  //     'productName': 'Smartphone',
  //     'category': 'Electronics',
  //     'currentStock': 150,
  //     'active': false,
  //   },
  //   {
  //     'sno': 3,
  //     'productName': 'Headphones',
  //     'category': 'Accessories',
  //     'currentStock': 80,
  //     'active': true,
  //   },
  // ];


  void _showProductDialog() async{
    // Try the EndDrawer approach first
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    await provider.getCategoryList();
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
                                "Manage and features all products",
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
                                "Manage and features all products",
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
    final provider = Provider.of<ProductsProvider>(context);
    final categoryList = provider.listOfProducts;
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
      List.generate(categoryList.length, (index){
        final product = categoryList[index];
            return DataRow(
              cells: [
                DataCell(Text({index + 1}.toString())),
                DataCell(Text(product.productName!)),
                DataCell(Text(product.category!.categoryName!)),
                DataCell(Text(product.openingStock.toString())),
                DataCell(
                  Switch(
                    value: product.isActive!,
                    onChanged: (bool newValue) {
                      setState(() {
                        product.isActive = newValue;
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
    return Consumer<ProductsProvider>(
        builder: (context, controller, child) {
        return Column(
          children:[
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.listOfProducts.length,
          itemBuilder: (context, index) {
            final user = controller.listOfProducts[index];
            return Card(
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
                        // S.NO and Product Name
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
                                'Product: ${user.productName}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                              Text(
                                'Opining Stock: ${user.openingStock}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Category and Current Stock
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Category: ${user.categoryName}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 20),

                            Text(
                              'Minimum Stock:${user.minStock}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),

                          ],
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
                            final RenderBox overlay = Overlay
                                .of(context)
                                .context
                                .findRenderObject() as RenderBox;

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
                              // Handle Edit
                              print('Edit Clicked');
                              controller.loadUserData(user);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductEditView()));
                            } else if (value == 'delete') {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) =>
                                    AlertDialog(
                                      backgroundColor: Colors.white,

                                      title: Text('Confirm Delete'),
                                      content: Text(
                                          'Are you sure you want to delete this company?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: Text('Delete',
                                              style: TextStyle(
                                                  color: Colors.red)),
                                        ),
                                      ],
                                    ),
                              );

                              if (confirmDelete == true) {
                                 await controller.deleteProducts(user.id!);


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
          }
        )


          ]

        );
      }
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<ProductsProvider>(context,listen: false).initState();
  }
}
