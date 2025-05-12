import 'package:billing_web/features/invoice/viewModel/invoice_provider.dart';
import 'package:billing_web/features/utils/on_init.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'add_new_invoice.dart';
import 'edit_invoice.dart';

class InvoiceListView extends StatefulWidget {
  const InvoiceListView({super.key});

  @override
  State<InvoiceListView> createState() => _InvoiceListViewState();
}

class _InvoiceListViewState extends State<InvoiceListView> with OnInit{
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

    final provider = Provider.of<InvoiceProvider>(context);
    final invoiceList = provider.invoiceList;

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
            rows:  List.generate(invoiceList.length, (index){
              final invoice = invoiceList[index];
              return DataRow(
                cells: [
                  DataCell(Text({index + 1}.toString())),
                  DataCell(Text(invoice.dueDate!)),
                  DataCell(Text(invoice.invoiceNumber!)),
                  DataCell(Text(invoice.purchaseParty!.partyName!)),
                  DataCell(Text(invoice.totalAmount!)),
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
    return Consumer<InvoiceProvider>(
      builder: (context, controller, child) {
        return Column(
          children: [
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.invoiceList.length,
          itemBuilder: (context, index){
            final invoice = controller.invoiceList[index];
            return  Card(
              color: Colors.white,
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
                          invoice.invoiceNumber!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          invoice.totalAmount!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Party: ${invoice.purchaseParty!.partyName!}',
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Date: ${invoice.invoiceDate!.split('T').first}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                              // Handle Edit
                              print('Edit Clicked');
                              controller.loadUserData(invoice);
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (context) => EditInvoice()));
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
                               //  print("user.id!===${invoice.id!}");
                                  await controller.deleteInvoice(invoice.id!);


                              }
                            }
                          },
                          child: Icon(Icons.more_horiz),
                        ),
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
    Provider.of<InvoiceProvider>(context,listen:false).initState();
  }
}