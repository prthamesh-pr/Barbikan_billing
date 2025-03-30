import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSales extends StatefulWidget {
  const AddSales({Key? key}) : super(key: key);

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _customerController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedStatus = 'Pending';
  
  // Items in the sale
  final List<SaleItem> _items = [SaleItem()];
  
  @override
  void dispose() {
    _customerController.dispose();
    for (var item in _items) {
      item.nameController.dispose();
      item.quantityController.dispose();
      item.priceController.dispose();
    }
    super.dispose();
  }
  
  double get _totalAmount {
    double total = 0.0;
    for (var item in _items) {
      final quantity = double.tryParse(item.quantityController.text) ?? 0;
      final price = double.tryParse(item.priceController.text) ?? 0;
      total += quantity * price;
    }
    return total;
  }
  
  void _addItem() {
    setState(() {
      _items.add(SaleItem());
    });
  }
  
  void _removeItem(int index) {
    if (_items.length > 1) {
      setState(() {
        final item = _items.removeAt(index);
        item.nameController.dispose();
        item.quantityController.dispose();
        item.priceController.dispose();
      });
    }
  }
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.indigo),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
  
  void _saveSale() {
    if (_formKey.currentState!.validate()) {
      // Here you would save the sale to your database
      // For now, just print the data and navigate back
      print('Customer: ${_customerController.text}');
      print('Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}');
      print('Status: $_selectedStatus');
      print('Total Amount: \$${_totalAmount.toStringAsFixed(2)}');
      
      // Display success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sale added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Navigate back to the sales list
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Sale'),
        backgroundColor: Colors.indigo,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: isMobile
                ? _buildMobileForm()
                : _buildDesktopForm(),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMobileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormHeader(),
        const SizedBox(height: 24),
        _buildCustomerField(),
        const SizedBox(height: 16),
        _buildDateField(),
        const SizedBox(height: 16),
        _buildStatusField(),
        const SizedBox(height: 24),
        _buildItemsSection(),
        const SizedBox(height: 24),
        _buildTotalSection(),
        const SizedBox(height: 24),
        _buildActionButtons(true),
      ],
    );
  }
  
  Widget _buildDesktopForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormHeader(),
        const SizedBox(height: 24),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildCustomerField(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDateField(),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatusField(),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildItemsSection(),
        const SizedBox(height: 24),
        _buildTotalSection(),
        const SizedBox(height: 24),
        _buildActionButtons(false),
      ],
    );
  }
  
  Widget _buildFormHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Create New Sale',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Add a new sale record to the system',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
  
  Widget _buildCustomerField() {
    return TextFormField(
      controller: _customerController,
      decoration: InputDecoration(
        labelText: 'Customer Name',
        hintText: 'Enter customer name',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter customer name';
        }
        return null;
      },
    );
  }
  
  Widget _buildDateField() {
    return InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Sale Date',
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('MMM dd, yyyy').format(_selectedDate),
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  
  Widget _buildStatusField() {
    return DropdownButtonFormField<String>(
      value: _selectedStatus,
      decoration: InputDecoration(
        labelText: 'Status',
        prefixIcon: const Icon(Icons.flag_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
      items: ['Pending', 'Paid', 'Completed']
          .map((status) => DropdownMenuItem(
                value: status,
                child: Text(status),
              ))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedStatus = value;
          });
        }
      },
    );
  }
  
  Widget _buildItemsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Items',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: _addItem,
                icon: const Icon(Icons.add),
                label: const Text('Add Item'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.indigo,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _items.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return _buildItemRow(index);
            },
          ),
        ],
      ),
    );
  }
  
  Widget _buildItemRow(int index) {
    final item = _items[index];
    final isMobile = MediaQuery.of(context).size.width < 800;
    
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Item ${index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _removeItem(index),
                tooltip: 'Remove item',
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: item.nameController,
            decoration: const InputDecoration(
              labelText: 'Item Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter item name';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: item.quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Invalid number';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: item.priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                    prefixText: '\$',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Invalid number';
                    }
                    return null;
                  },
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Subtotal: \$${_calculateSubtotal(item)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: item.nameController,
              decoration: const InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter item name';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              controller: item.quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (double.tryParse(value) == null) {
                  return 'Invalid number';
                }
                return null;
              },
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: TextFormField(
              controller: item.priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                prefixText: '\$',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (double.tryParse(value) == null) {
                  return 'Invalid number';
                }
                return null;
              },
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 100,
            child: Text(
              '\$${_calculateSubtotal(item)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () => _removeItem(index),
            tooltip: 'Remove item',
          ),
        ],
      );
    }
  }
  
  String _calculateSubtotal(SaleItem item) {
    final quantity = double.tryParse(item.quantityController.text) ?? 0;
    final price = double.tryParse(item.priceController.text) ?? 0;
    final subtotal = quantity * price;
    return subtotal.toStringAsFixed(2);
  }
  
  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Amount:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '\$${_totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildActionButtons(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton.icon(
            onPressed: _saveSale,
            icon: const Icon(Icons.save),
            label: const Text('Save Sale'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.indigo),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: const BorderSide(color: Colors.indigo),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: _saveSale,
            icon: const Icon(Icons.save),
            label: const Text('Save Sale'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      );
    }
  }
}

class SaleItem {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  
  SaleItem() {
    quantityController.text = '1';
    priceController.text = '0.00';
  }
}