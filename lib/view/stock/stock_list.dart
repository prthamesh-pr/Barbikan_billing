import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'add_new_item.dart';

class StockListView extends StatefulWidget {
  const StockListView({super.key});

  @override
  State<StockListView> createState() => _StockListViewState();
}

class _StockListViewState extends State<StockListView> {
  // Mock data for stock items
  final List<Map<String, dynamic>> stockItems = [
    {
      'id': 1,
      'name': 'Laptop HP ProBook',
      'sku': 'LT-HP-001',
      'category': 'Electronics',
      'quantity': 15,
      'unit': 'pcs',
      'buyingPrice': '₹45,000',
      'sellingPrice': '₹52,000',
      'status': 'In Stock',
    },
    {
      'id': 2,
      'name': 'Office Chair Ergonomic',
      'sku': 'FN-CH-021',
      'category': 'Furniture',
      'quantity': 8,
      'unit': 'pcs',
      'buyingPrice': '₹5,200',
      'sellingPrice': '₹7,500',
      'status': 'In Stock',
    },
    {
      'id': 3,
      'name': 'Wireless Mouse',
      'sku': 'AC-MS-103',
      'category': 'Accessories',
      'quantity': 3,
      'unit': 'pcs',
      'buyingPrice': '₹800',
      'sellingPrice': '₹1,200',
      'status': 'Low Stock',
    },
    {
      'id': 4,
      'name': 'Printer Ink Cartridge',
      'sku': 'PR-INK-234',
      'category': 'Supplies',
      'quantity': 22,
      'unit': 'pcs',
      'buyingPrice': '₹1,200',
      'sellingPrice': '₹1,800',
      'status': 'In Stock',
    },
    {
      'id': 5,
      'name': 'External Hard Drive 1TB',
      'sku': 'ST-HD-567',
      'category': 'Storage',
      'quantity': 0,
      'unit': 'pcs',
      'buyingPrice': '₹3,800',
      'sellingPrice': '₹4,500',
      'status': 'Out of Stock',
    },
  ];

  // Search functionality
  String searchQuery = '';
  List<Map<String, dynamic>> get filteredStockItems {
    if (searchQuery.isEmpty) {
      return stockItems;
    }
    return stockItems.where((item) {
      return item['name'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          item['sku'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          item['category'].toString().toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if we're on a mobile device (width < 600)
        final isMobile = constraints.maxWidth < 600;

        return ListView(
          padding: EdgeInsets.all(isMobile ? 10 : 15),
          children: [
            // Header section
            SizedBox(
              width: double.infinity,
              child:
                  isMobile
                      ? _buildMobileHeader(context)
                      : _buildDesktopHeader(context),
            ),

            SizedBox(height: isMobile ? 10 : 15),

            // Search bar
            _buildSearchBar(context),

            SizedBox(height: isMobile ? 10 : 15),

            // Stock items list
            isMobile
                ? _buildMobileStockList(context)
                : _buildDesktopStockList(context),
          ],
        );
      },
    );
  }

  Widget _buildDesktopHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Inventory Management",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Manage your stock and inventory items",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNewItemPage()),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Theme.of(context).primaryColor,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: Colors.white, size: 20),
                const SizedBox(width: 10),
                Text(
                  "Add New Item",
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Inventory Management",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Manage your stock and inventory items",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: Icon(Icons.add, color: Colors.white, size: 16),
            label: Text("Add New Item", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            onPressed: () {
              // Handle add item action
              _showAddItemDialog(context);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Search by name, SKU or category',
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildDesktopStockList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.05 * 255).toInt()),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      width: double.infinity,
      child: DataTable(
        columnSpacing: 20.0,
        columns: [
          DataColumn(label: Text('SKU')),
          DataColumn(label: Text('Item Name')),
          DataColumn(label: Text('Category')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Buying Price')),
          DataColumn(label: Text('Selling Price')),
          DataColumn(label: Text('Status')),
          DataColumn(label: Text('Action')),
        ],
        rows:
            filteredStockItems.map((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item['sku'])),
                  DataCell(Text(item['name'])),
                  DataCell(Text(item['category'])),
                  DataCell(Text('${item['quantity']} ${item['unit']}')),
                  DataCell(Text(item['buyingPrice'])),
                  DataCell(Text(item['sellingPrice'])),
                  DataCell(_buildStatusIndicator(item['status'])),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          color: Colors.blue,
                          icon: Icon(Iconsax.edit),
                          onPressed: () => _showEditItemDialog(context, item),
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: Icon(Iconsax.trash),
                          onPressed:
                              () => _showDeleteConfirmation(context, item),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }

  Widget _buildMobileStockList(BuildContext context) {
    return Column(
      children:
          filteredStockItems.map((item) {
            return Card(
              margin: EdgeInsets.only(bottom: 12),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        _buildStatusIndicator(item['status']),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      'SKU: ${item['sku']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category: ${item['category']}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Qty: ${item['quantity']} ${item['unit']}',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Buy: ${item['buyingPrice']}',
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Sell: ${item['sellingPrice']}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Divider(height: 1),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          icon: Icon(Iconsax.edit, size: 18),
                          label: Text('Edit'),
                          onPressed: () => _showEditItemDialog(context, item),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 8),
                        TextButton.icon(
                          icon: Icon(Iconsax.trash, size: 18),
                          label: Text('Delete'),
                          onPressed:
                              () => _showDeleteConfirmation(context, item),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
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

  Widget _buildStatusIndicator(String status) {
    Color color;

    switch (status) {
      case 'In Stock':
        color = Colors.green;
        break;
      case 'Low Stock':
        color = Colors.orange;
        break;
      case 'Out of Stock':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController skuController = TextEditingController();
    final TextEditingController categoryController = TextEditingController();
    final TextEditingController quantityController = TextEditingController();
    final TextEditingController unitController = TextEditingController(
      text: 'pcs',
    );
    final TextEditingController buyingPriceController = TextEditingController();
    final TextEditingController sellingPriceController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Stock Item'),
          content: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: skuController,
                      decoration: InputDecoration(
                        labelText: 'SKU',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: quantityController,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: unitController,
                            decoration: InputDecoration(
                              labelText: 'Unit',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: buyingPriceController,
                      decoration: InputDecoration(
                        labelText: 'Buying Price',
                        prefixText: '₹',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: sellingPriceController,
                      decoration: InputDecoration(
                        labelText: 'Selling Price',
                        prefixText: '₹',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Add new item logic
                final newItem = {
                  'id': stockItems.length + 1,
                  'name': nameController.text,
                  'sku': skuController.text,
                  'category': categoryController.text,
                  'quantity': int.tryParse(quantityController.text) ?? 0,
                  'unit': unitController.text,
                  'buyingPrice': '₹${buyingPriceController.text}',
                  'sellingPrice': '₹${sellingPriceController.text}',
                  'status':
                      int.tryParse(quantityController.text) == 0
                          ? 'Out of Stock'
                          : (int.tryParse(quantityController.text) ?? 0) < 5
                          ? 'Low Stock'
                          : 'In Stock',
                };

                setState(() {
                  stockItems.add(newItem);
                });

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item added successfully')),
                );
              },
              child: Text('Add Item'),
            ),
          ],
        );
      },
    );
  }

  void _showEditItemDialog(BuildContext context, Map<String, dynamic> item) {
    final TextEditingController nameController = TextEditingController(
      text: item['name'],
    );
    final TextEditingController skuController = TextEditingController(
      text: item['sku'],
    );
    final TextEditingController categoryController = TextEditingController(
      text: item['category'],
    );
    final TextEditingController quantityController = TextEditingController(
      text: item['quantity'].toString(),
    );
    final TextEditingController unitController = TextEditingController(
      text: item['unit'],
    );
    final TextEditingController buyingPriceController = TextEditingController(
      text: item['buyingPrice'].toString().replaceAll('₹', ''),
    );
    final TextEditingController sellingPriceController = TextEditingController(
      text: item['sellingPrice'].toString().replaceAll('₹', ''),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Stock Item'),
          content: SingleChildScrollView(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Item Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: skuController,
                      decoration: InputDecoration(
                        labelText: 'SKU',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            controller: quantityController,
                            decoration: InputDecoration(
                              labelText: 'Quantity',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: TextFormField(
                            controller: unitController,
                            decoration: InputDecoration(
                              labelText: 'Unit',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: buyingPriceController,
                      decoration: InputDecoration(
                        labelText: 'Buying Price',
                        prefixText: '₹',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: sellingPriceController,
                      decoration: InputDecoration(
                        labelText: 'Selling Price',
                        prefixText: '₹',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Update item logic
                final updatedItem = {
                  'id': item['id'],
                  'name': nameController.text,
                  'sku': skuController.text,
                  'category': categoryController.text,
                  'quantity': int.tryParse(quantityController.text) ?? 0,
                  'unit': unitController.text,
                  'buyingPrice': '₹${buyingPriceController.text}',
                  'sellingPrice': '₹${sellingPriceController.text}',
                  'status':
                      int.tryParse(quantityController.text) == 0
                          ? 'Out of Stock'
                          : (int.tryParse(quantityController.text) ?? 0) < 5
                          ? 'Low Stock'
                          : 'In Stock',
                };

                setState(() {
                  final index = stockItems.indexWhere(
                    (element) => element['id'] == item['id'],
                  );
                  if (index != -1) {
                    stockItems[index] = updatedItem;
                  }
                });

                Navigator.of(context).pop();

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item updated successfully')),
                );
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item'),
          content: Text('Are you sure you want to delete ${item['name']}?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  stockItems.removeWhere(
                    (element) => element['id'] == item['id'],
                  );
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Item deleted successfully')),
                );
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
