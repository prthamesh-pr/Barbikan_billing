import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'add_new_invoice.dart';

class InvoiceListView extends StatefulWidget {
  const InvoiceListView({super.key});

  @override
  State<InvoiceListView> createState() => _InvoiceListViewState();
}

class _InvoiceListViewState extends State<InvoiceListView> {
  final List<Map<String, dynamic>> invoiceList = [
    {
      'sno': 1,
      'date': '2025-03-01',
      'billNumber': 'INV1001',
      'partyName': 'ABC Traders',
      'amount': '₹10,000',
    },
    {
      'sno': 2,
      'date': '2025-03-02',
      'billNumber': 'INV1002',
      'partyName': 'XYZ Distributors',
      'amount': '₹15,500',
    },
    {
      'sno': 3,
      'date': '2025-03-03',
      'billNumber': 'INV1003',
      'partyName': 'LMN Suppliers',
      'amount': '₹8,750',
    },
  ];

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
              child: isMobile 
                ? _buildMobileHeader(context)
                : _buildDesktopHeader(context),
            ),

            SizedBox(height: isMobile ? 10 : 15),

            // Invoice list
            isMobile 
                ? _buildMobileInvoiceList(context)
                : _buildDesktopInvoiceList(context),
          ],
        );
      }
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
                "Invoice List",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Manage and features all invoices",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 8,
          ),
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
                "Add New Invoice",
                style: Theme.of(
                  context,
                ).textTheme.labelLarge!.copyWith(color: Colors.white),
              ),
            ],
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
          "Invoice List",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Manage and features all invoices",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
  icon: Icon(Icons.add, color: Colors.white, size: 16),
  label: Text(
    "Add New Invoice",
    style: TextStyle(color: Colors.white),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).primaryColor,
    padding: EdgeInsets.symmetric(vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
  ),
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNewInvoice()),
    );
  },
),
        ),
      ],
    );
  }

  Widget _buildDesktopInvoiceList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: DataTable(
        columnSpacing: 20.0,
        columns: [
          DataColumn(label: Text('S.NO')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Bill Number')),
          DataColumn(label: Text('Party Name')),
          DataColumn(label: Text('Amount')),
          DataColumn(label: Text('Action')),
        ],
        rows: invoiceList.map((invoice) {
          return DataRow(
            cells: [
              DataCell(Text(invoice['sno'].toString())),
              DataCell(Text(invoice['date'])),
              DataCell(Text(invoice['billNumber'])),
              DataCell(Text(invoice['partyName'])),
              DataCell(Text(invoice['amount'])),
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
      ),
    );
  }

  Widget _buildMobileInvoiceList(BuildContext context) {
    return Column(
      children: invoiceList.map((invoice) {
        return Card(
          margin: EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      invoice['billNumber'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      invoice['amount'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Party: ${invoice['partyName']}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  'Date: ${invoice['date']}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 32,
                      width: 32,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        color: Colors.blue,
                        icon: Icon(Iconsax.edit, size: 18),
                        onPressed: () {
                          // Handle edit action
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    SizedBox(
                      height: 32,
                      width: 32,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        color: Colors.red,
                        icon: Icon(Iconsax.trash, size: 18),
                        onPressed: () {
                          // Handle delete action
                        },
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
}