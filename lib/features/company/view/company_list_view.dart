import 'package:billing_web/features/company/view/update_company_view.dart';
import 'package:billing_web/features/config.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:billing_web/features/company/view/add_new_company.dart';

class CompanyListView extends StatefulWidget {
  const CompanyListView({super.key});

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  final List<Map<String, dynamic>> companyList = [
    {
      'sno': 1,
      'companyName': 'ABC Pvt Ltd',
      'gst': '29ABCDE1234F1Z5',
      'mobile': '9876543210',
    },
    {
      'sno': 2,
      'companyName': 'XYZ Corp',
      'gst': '27XYZDE5678G1Z3',
      'mobile': '9876543211',
    },
    {
      'sno': 3,
      'companyName': 'LMN Ltd',
      'gst': '30LMNDE9101H1Z7',
      'mobile': '9876543212',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if we're on a mobile device
        final isMobile = constraints.maxWidth < 600;
        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 900;
        
        return ListView(
          padding: EdgeInsets.all(isMobile ? 10 : 15),
          children: [
            // Header section
            _buildHeader(context, isMobile),
            
            SizedBox(height: isMobile ? 10 : 15),
            
            // Main content
            isMobile 
                ? _buildMobileList(context)
                : _buildDataTable(context, isTablet),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return SizedBox(
      width: double.infinity,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Company List",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  "Manage and features registered companies",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 10),
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
                      "Company List",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Manage and features registered companies",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                _buildAddButton(context),
              ],
            ),
    );
  }

 Widget _buildAddButton(BuildContext context) {
  return InkWell(
    onTap: () {
      creationPageConfig.changePage(
        const AddNewCompanyView(),
      );
      // Add null check to prevent null pointer exception
      if (scaffoldKey.currentState != null) {
        scaffoldKey.currentState!.openEndDrawer();
      } else {
        // Fallback navigation if scaffold key is null
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const AddNewCompanyView()),
        );
      }
    },
    child: Container(
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
            "Add New Company",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
          ),
        ],
      ),
    ),
  );
}
  Widget _buildDataTable(BuildContext context, bool isTablet) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 30,
          ),
          child: DataTable(
            columnSpacing: isTablet ? 15.0 : 20.0,
            horizontalMargin: isTablet ? 10.0 : 20.0,
            columns: [
              DataColumn(label: Text('S.NO', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Company Name', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('GST Number', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Mobile Number', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: companyList.map((company) {
              return DataRow(
                cells: [
                  DataCell(Text(company['sno'].toString())),
                  DataCell(Text(company['companyName'])),
                  DataCell(Text(company['gst'])),
                  DataCell(Text(company['mobile'])),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          color: Colors.blue,
                          icon: Icon(Iconsax.edit, size: isTablet ? 18 : 24),
                          onPressed: () {
                            creationPageConfig.changePage(
                              UpdateCompanyView(),
                            );
                            scaffoldKey.currentState!.openEndDrawer();
                          },
                        ),
                        IconButton(
                          color: Colors.red,
                          icon: Icon(Iconsax.trash, size: isTablet ? 18 : 24),
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
        ),
      ),
    );
  }

  Widget _buildMobileList(BuildContext context) {
    return Column(
      children: companyList.map((company) {
        return Card(
            color: Colors.white,
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        company['companyName'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '#${company['sno']}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildInfoRow('GST:', company['gst']),
                _buildInfoRow('Mobile:', company['mobile']),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      icon: const Icon(Iconsax.edit, size: 16),
                      label: const Text('Edit'),
                      onPressed: () {
                        creationPageConfig.changePage(
                          UpdateCompanyView(),
                        );
                        scaffoldKey.currentState!.openEndDrawer();
                      },
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      icon: const Icon(Iconsax.trash, size: 16),
                      label: const Text('Delete'),
                      onPressed: () {
                        // Handle delete action
                      },
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

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 55,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}