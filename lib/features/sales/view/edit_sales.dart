import 'package:billing_web/features/sales/viewModel/salesProvider.dart';
import 'package:billing_web/features/utils/on_init.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class EditSales extends StatefulWidget {
  const EditSales({super.key});

  @override
  State<EditSales> createState() => _EditSalesState();
}

class _EditSalesState extends State<EditSales> with OnInit {
  final _formKey = GlobalKey<FormState>();

  // String _selectedStatus = 'Pending';



  // @override
  // void dispose() {
  //   final provider = Provider.of<SalesProvider>(context, listen: false);
  //   for (var item in provider.listOfItems) {
  //     provider.itemNameController.dispose();
  //     provider.quantityController.dispose();
  //     provider.priceController.dispose();
  //   }
  //   super.dispose();
  // }

  double get _totalAmount {
    final provider = Provider.of<SalesProvider>(context, listen: false);

    double total = 0.0;
    for (var item in provider.listOfItems) {
      // print("Item: ${item.productName}, Qty: ${item.quantity}, Price: ${item.price}");
      final quantity = item.quantity ?? 0;
      final price = double.tryParse(item.price ?? '0') ?? 0.0;
      total += quantity * price;
    }
    return total;
  }

  Future<void> _selectDate(BuildContext context) async {
    final provider = Provider.of<SalesProvider>(context, listen: false);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: provider.selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.indigo),
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != provider.selectedDate) {
      provider.setSelectedDate(picked);
    }
  }

  // void _saveSale()async {
  //
  //   // if (_formKey.currentState!.validate()) {
  //   //   // Here you would save the sale to your database
  //   //   // For now, just print the data and navigate back
  //   //
  //   //   print('Status: $_selectedStatus');
  //   //   print('Total Amount: \$${_totalAmount.toStringAsFixed(2)}');
  //   //
  //   //   // Display success message
  //   //   ScaffoldMessenger.of(context).showSnackBar(
  //   //     const SnackBar(
  //   //       content: Text('Sale added successfully!'),
  //   //       backgroundColor: Colors.green,
  //   //     ),
  //   //   );
  //   //
  //   //   // Navigate back to the sales list
  //   //   Navigator.pop(context);
  //   // }
  //   final provider = Provider.of<SalesProvider>(context, listen: false);
  //
  // }

  void _saveSale() async {
    final provider = Provider.of<SalesProvider>(context, listen: false);
    provider.totalAmountController.text = _totalAmount.toStringAsFixed(2);
    await provider.putSalesUpdate(

      success: () {

        provider.customerNameController.clear();
        provider.saleDateController.clear();
        provider.statusController.clear();
        provider. totalAmountController.clear();
        provider.itemNameControllers.forEach((controller) {
          controller.clear();
        });
        provider.quantityControllers.forEach((controller) {
          controller.clear();
        });
        provider.priceControllers.forEach((controller) {
          controller.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sale added successfully")),
        );
        Navigator.pop(context); // or clear fields, or redirect
      },
      failure: (message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add sale: $message")),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Sale'),
        backgroundColor: Colors.white,
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
            child: isMobile ? _buildMobileForm() : _buildDesktopForm(),
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
            Expanded(flex: 2, child: _buildCustomerField()),
            const SizedBox(width: 16),
            Expanded(child: _buildDateField()),
            const SizedBox(width: 16),
            Expanded(child: _buildStatusField()),
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
        // const Text(
        //   'Create New Sale',
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(height: 8),
        // Text(
        //   'Add a new sale record to the system',
        //   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        // ),
      ],
    );
  }

  Widget _buildCustomerField() {
    return Consumer<SalesProvider>(
        builder: (context, controller, child) {
          return TextFormField(
            controller: controller.customerNameController,
            decoration: InputDecoration(
              labelText: 'Customer Name',
              hintText: 'Enter customer name',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
    );
  }

  Widget _buildDateField() {
    return Consumer<SalesProvider>(
        builder: (context, controller, child) {
          return InkWell(
            onTap: () async{
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: controller.selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                controller.setSelectedDate(pickedDate);
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Sale Date',
                prefixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                fillColor: Colors.white,
                filled: true,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('MMM dd, yyyy').format(controller.selectedDate),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildStatusField() {
    final provider = Provider.of<SalesProvider>(context);
    return DropdownButtonFormField<String>(
      value: provider.statusController.text.isNotEmpty
          ? provider.statusController.text
          : null,
      decoration: InputDecoration(
        labelText: 'Status',
        prefixIcon: const Icon(Icons.flag_outlined),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        fillColor: Colors.white,
        filled: true,
      ),
      items: provider.statusOptions
          .map(
            (status) => DropdownMenuItem(
          value: status,
          child: Text(status),
        ),
      )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          provider.setSelectedStatus(value);
        }
      },
    );
  }

  Widget _buildItemsSection() {
    return Consumer<SalesProvider>(
        builder: (context, controller, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              // color: Colors.green,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha((0.1 * 255).toInt()),
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton.icon(
                      onPressed:(){
                        controller.addItem(SaleItemModel());
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Item'),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Consumer<SalesProvider>(
                    builder: (context, controller, child) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.listOfItems.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          return _buildItemRow(index);
                        },
                      );

                    })
              ],
            ),
          );
        }
    );
  }

  Widget _buildItemRow(int index) {
    final provider = Provider.of<SalesProvider>(context, listen: false);

    final items = provider.listOfItems[index];
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: ()
                //=> _removeItem(index),
                {
                  Provider.of<SalesProvider>(context, listen: false).removeItem(index);
                },
                tooltip: 'Remove item',
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: provider.itemNameControllers[index],
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
            onChanged: (value) {
              provider.listOfItems[index].productName = value;
            },
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: provider.quantityControllers[index],
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
                  onChanged: (value) {
                    provider.listOfItems[index].quantity = int.tryParse(value);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: provider.priceControllers[index],
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
                  onChanged: (value) {
                    provider.listOfItems[index].price = value;
                  },

                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Subtotal: \₹${_calculateSubtotal(index)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
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
              controller:provider.itemNameControllers[index],
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
              controller: provider.quantityControllers[index],
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
              controller: provider.priceControllers[index],
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
              '\$${_calculateSubtotal(index)}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              Provider.of<SalesProvider>(context, listen: false).removeItem(index);
            },
            tooltip: 'Remove item',
          ),
        ],
      );
    }
  }

  String _calculateSubtotal(int index) {
    final provider = Provider.of<SalesProvider>(context, listen: false);

    final quantityText = provider.quantityControllers[index]?.text ?? '0';
    final priceText = provider.priceControllers[index]?.text ?? '0';

    final quantity = double.tryParse(quantityText) ?? 0;
    final price = double.tryParse(priceText) ?? 0;

    final subtotal = quantity * price;

    return subtotal.toStringAsFixed(2);
  }

  Widget _buildTotalSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Total Amount:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '\₹${_totalAmount.toStringAsFixed(2)}',
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
            label: const Text('Update Sale'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,

              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),

              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.grey),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.indigo,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              side: const BorderSide(color: Colors.indigo),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Cancel'),
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

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    final provider = Provider.of<SalesProvider>(context, listen: false).inItState();
  }
}


