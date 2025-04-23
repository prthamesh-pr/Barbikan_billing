import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddNewInvoice extends StatefulWidget {
  const AddNewInvoice({super.key});

  @override
  State<AddNewInvoice> createState() => _AddNewInvoiceState();
}

class _AddNewInvoiceState extends State<AddNewInvoice> {
  final _formKey = GlobalKey<FormState>();
  
  // Form data
  final TextEditingController _invoiceNumberController = TextEditingController(text: 'INV1004');
  final TextEditingController _dateController = TextEditingController(text: '2025-03-30');
  final TextEditingController _dueDateController = TextEditingController(text: '2025-04-30');
  String _selectedParty = 'ABC Traders';
  
  // List of parties for dropdown
  final List<String> _parties = ['ABC Traders', 'XYZ Distributors', 'LMN Suppliers', 'PQR Enterprises'];
  
  // List of invoice items
  final List<Map<String, dynamic>> _items = [
    {
      'id': 1,
      'name': 'Product 1',
      'quantity': 2,
      'price': 1000.0,
      'amount': 2000.0,
    }
  ];
  
  // Add a new item to the invoice
  void _addItem() {
    setState(() {
      _items.add({
        'id': _items.length + 1,
        'name': 'Product ${_items.length + 1}',
        'quantity': 1,
        'price': 0.0,
        'amount': 0.0,
      });
    });
  }
  
  // Remove an item from the invoice
  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }
  
  // Calculate total amount
  double get _totalAmount {
    return _items.fold(0, (prev, item) => prev + (item['amount'] as double));
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Invoice'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 600;
          
          return SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create New Invoice',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  
                  // Invoice details section
                  isMobile 
                    ? _buildMobileInvoiceDetails(context)
                    : _buildDesktopInvoiceDetails(context),
                  
                  const SizedBox(height: 30),
                  
                  // Items section
                  Text(
                    'Invoice Items',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  
                  // Table for items
                  isMobile
                    ? _buildMobileItemsList(context)
                    : _buildDesktopItemsList(context),
                  
                  const SizedBox(height: 16),
                  
                  // Add Item button
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Item'),
                    onPressed: _addItem,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Total amount
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Subtotal: ₹${_totalAmount.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Tax (18%): ₹${(_totalAmount * 0.18).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Total: ₹${(_totalAmount * 1.18).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Save invoice logic here
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Invoice saved successfully!')),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save Invoice'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
  
  // Desktop layout for invoice details
  Widget _buildDesktopInvoiceDetails(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _invoiceNumberController,
                decoration: const InputDecoration(
                  labelText: 'Invoice Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter invoice number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Invoice Date',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      // Date picker logic
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter invoice date';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedParty,
                decoration: const InputDecoration(
                  labelText: 'Select Party',
                  border: OutlineInputBorder(),
                ),
                items: _parties.map((party) {
                  return DropdownMenuItem<String>(
                    value: party,
                    child: Text(party),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedParty = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a party';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dueDateController,
                decoration: InputDecoration(
                  labelText: 'Due Date',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () async {
                      // Date picker logic
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  // Mobile layout for invoice details
  Widget _buildMobileInvoiceDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _invoiceNumberController,
          decoration: const InputDecoration(
            labelText: 'Invoice Number',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter invoice number';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _dateController,
          decoration: InputDecoration(
            labelText: 'Invoice Date',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                // Date picker logic
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter invoice date';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedParty,
          decoration: const InputDecoration(
            labelText: 'Select Party',
            border: OutlineInputBorder(),
          ),
          items: _parties.map((party) {
            return DropdownMenuItem<String>(
              value: party,
              child: Text(party),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedParty = value!;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a party';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _dueDateController,
          decoration: InputDecoration(
            labelText: 'Due Date',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                // Date picker logic
              },
            ),
          ),
        ),
      ],
    );
  }
  
  // Desktop layout for items list
  Widget _buildDesktopItemsList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Item')),
          DataColumn(label: Text('Quantity')),
          DataColumn(label: Text('Price')),
          DataColumn(label: Text('Amount')),
          DataColumn(label: Text('Action')),
        ],
        rows: _items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          
          return DataRow(
            cells: [
              DataCell(TextFormField(
                initialValue: item['name'],
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() {
                    item['name'] = value;
                  });
                },
              )),
              DataCell(TextFormField(
                initialValue: item['quantity'].toString(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    item['quantity'] = int.tryParse(value) ?? 0;
                    item['amount'] = item['quantity'] * item['price'];
                  });
                },
              )),
              DataCell(TextFormField(
                initialValue: item['price'].toString(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixText: '₹',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    item['price'] = double.tryParse(value) ?? 0.0;
                    item['amount'] = item['quantity'] * item['price'];
                  });
                },
              )),
              DataCell(Text('₹${item['amount'].toStringAsFixed(2)}')),
              DataCell(IconButton(
                icon: const Icon(Iconsax.trash, color: Colors.red),
                onPressed: () => _removeItem(index),
              )),
            ],
          );
        }).toList(),
      ),
    );
  }
  
  // Mobile layout for items list
  Widget _buildMobileItemsList(BuildContext context) {
    return Column(
      children: _items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: item['name'],
                        decoration: const InputDecoration(
                          labelText: 'Item Name',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            item['name'] = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Iconsax.trash, color: Colors.red),
                      onPressed: () => _removeItem(index),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: item['quantity'].toString(),
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            item['quantity'] = int.tryParse(value) ?? 0;
                            item['amount'] = item['quantity'] * item['price'];
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        initialValue: item['price'].toString(),
                        decoration: const InputDecoration(
                          labelText: 'Price',
                          prefixText: '₹',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            item['price'] = double.tryParse(value) ?? 0.0;
                            item['amount'] = item['quantity'] * item['price'];
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Amount: ₹${item['amount'].toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}