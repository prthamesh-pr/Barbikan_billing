import 'package:flutter/material.dart';

class AddNewItemPage extends StatefulWidget {
  const AddNewItemPage({Key? key}) : super(key: key);

  @override
  State<AddNewItemPage> createState() => _AddNewItemPageState();
}

class _AddNewItemPageState extends State<AddNewItemPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _skuController = TextEditingController();
  String? _selectedCategory;
  bool _isOnSale = false;

  final List<String> _categories = [
    'Electronics',
    'Clothing',
    'Groceries',
    'Household',
    'Others'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    _skuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;
          
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 1000 : 600,
                  ),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.inventory,
                                  size: 32,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Item Information',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            const Divider(height: 40),
                            
                            // Basic Info Section
                            if (isDesktop)
                              _buildDesktopLayout()
                            else
                              _buildMobileLayout(),
                              
                            const SizedBox(height: 30),
                            
                            // Action Buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(Icons.cancel),
                                  label: const Text('Cancel'),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    foregroundColor: Colors.grey[800],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  onPressed: _saveItem,
                                  icon: const Icon(Icons.save),
                                  label: const Text('Save Item'),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                    backgroundColor: Theme.of(context).primaryColor,
                                    foregroundColor: Colors.white,
                                    elevation: 2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: Name and SKU
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTextField(
                controller: _nameController,
                label: 'Item Name',
                icon: Icons.shopping_bag,
                isRequired: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _skuController,
                label: 'SKU/Item Code',
                icon: Icons.qr_code,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // Row 2: Price, Quantity, and Category
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildTextField(
                controller: _priceController,
                label: 'Price',
                icon: Icons.attach_money,
                isRequired: true,
                isNumber: true,
                prefixText: '\$',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                controller: _quantityController,
                label: 'Quantity',
                icon: Icons.inventory_2,
                isRequired: true,
                isNumber: true,
                isInteger: true,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildCategoryDropdown(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        
        // Row 3: On Sale Switch and Description
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: _buildOnSaleSwitch(),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: _buildTextField(
                controller: _descriptionController,
                label: 'Description (Optional)',
                icon: Icons.description,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: _nameController,
          label: 'Item Name',
          icon: Icons.shopping_bag,
          isRequired: true,
        ),
        const SizedBox(height: 16),
        
        _buildTextField(
          controller: _skuController,
          label: 'SKU/Item Code',
          icon: Icons.qr_code,
        ),
        const SizedBox(height: 16),
        
        _buildTextField(
          controller: _priceController,
          label: 'Price',
          icon: Icons.attach_money,
          isRequired: true,
          isNumber: true,
          prefixText: '\$',
        ),
        const SizedBox(height: 16),
        
        _buildTextField(
          controller: _quantityController,
          label: 'Quantity',
          icon: Icons.inventory_2,
          isRequired: true,
          isNumber: true,
          isInteger: true,
        ),
        const SizedBox(height: 16),
        
        _buildCategoryDropdown(),
        const SizedBox(height: 16),
        
        _buildOnSaleSwitch(),
        const SizedBox(height: 16),
        
        _buildTextField(
          controller: _descriptionController,
          label: 'Description (Optional)',
          icon: Icons.description,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isRequired = false,
    bool isNumber = false,
    bool isInteger = false,
    String? prefixText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: Icon(icon),
        prefixText: prefixText,
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      validator: isRequired
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (isNumber && double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              if (isInteger && int.tryParse(value) == null) {
                return 'Please enter a valid integer';
              }
              return null;
            }
          : null,
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: const Icon(Icons.category),
        filled: true,
        fillColor: Colors.white,
      ),
      value: _selectedCategory,
      hint: const Text('Select a category'),
      items: _categories.map((category) {
        return DropdownMenuItem(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a category';
        }
        return null;
      },
    );
  }

  Widget _buildOnSaleSwitch() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text('On Sale')),
          Switch(
            value: _isOnSale,
            onChanged: (value) {
              setState(() {
                _isOnSale = value;
              });
            },
            activeColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      // Save the new item
      // You can add your saving logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 16),
              Text('Item added successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      Navigator.pop(context);
    }
  }
}