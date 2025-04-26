import 'package:billing_web/features/company/view/update_company_view.dart';
import 'package:billing_web/features/company/viewModels/companyProvider.dart';
import 'package:billing_web/features/config.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:billing_web/features/company/view/add_new_company.dart';
import 'package:provider/provider.dart';

import '../../utils/on_init.dart';

class CompanyListView extends StatefulWidget {
  const CompanyListView({super.key});

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView>with OnInit {


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
    return Consumer<CompanyProvider>(
      builder: (context, controller, child) {
        if (controller.isLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.orange));
        } else if (controller.listOfCompany.isEmpty) {
          return Center(child: Text('No companies found.'));
        }
         return Container(
          decoration: BoxDecoration(
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
                //  DataColumn(label: Text('Action', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: List<DataRow>.generate(
                  controller.listOfCompany.length,
                      (index) {
                    final user = controller.listOfCompany[index];
                    return DataRow(
                      cells: [
                       // DataCell(Text(user.['sno'].toString())),
                        DataCell(Text((index + 1).toString())),
                        DataCell(Text(user.companyName.toString())),
                        DataCell(Text(user.gstNumber.toString())),
                        DataCell(Text(user.mobileNumber.toString())),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                color: Colors.blue,
                                icon: Icon(Iconsax.edit, size: isTablet ? 18 : 24),
                                onPressed: () {

                                  // controller.loadUserData(company); // if you have this
                                   creationPageConfig.changePage(UpdateCompanyView());
                                   scaffoldKey.currentState!.openEndDrawer();
                                },
                              ),
                              IconButton(
                                color: Colors.red,
                                icon: Icon(Iconsax.trash, size: isTablet ? 18 : 24),
                                onPressed: () {
                                //  controller.deleteCompanyBySno(company['sno']); // if you have this method
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget _buildMobileList(BuildContext context) {
    return Consumer<CompanyProvider>(
        builder: (context, controller, child) {
          // if (controller.isLoading) {
          //   return Center(child: CircularProgressIndicator(color: Colors.orange));
          // } else if (controller.listOfCompany.isEmpty) {
          //   return Center(child: Text('No companies found.'));
          // }
        return Column(
          children:[
         // companyList.map((company) {
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:controller.listOfCompany.length,
          itemBuilder: (context, index) {
            final user = controller.listOfCompany[index];
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
                            user.companyName!,
                           // 'Company name',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          '#${index + 1}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildInfoRow('GST:', user.gstNumber!),
                    _buildInfoRow('Mobile:', user.mobileNumber!),
                    // _buildInfoRow('FSSAI:', user.fssaiNumber!),
                    // _buildInfoRow('Email:', user.email!),
                    // _buildInfoRow('Bill Prefix:', user.email!),
                    // _buildInfoRow('Address:', user.billingAddress!),
                    // _buildInfoRow('City:', user.city!),
                    // _buildInfoRow('state:', user.state!),
                    // _buildInfoRow('Bank Name:', user.bankName!),
                    // _buildInfoRow('Account no:', user.accountNumber!),
                    // _buildInfoRow('Ifsc Code:', user.ifscCode!),

                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        GestureDetector(
                          onTapDown: (TapDownDetails details) async {
                            final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

                            await showMenu(
                              context: context,
                              position: RelativeRect.fromRect(
                                details.globalPosition & const Size(40, 40), // position where the menu will appear
                                Offset.zero & overlay.size,
                              ),
                              color: Colors.white, // Background color
                              //elevation: 0,
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
                                      Icon(Icons.delete,),
                                      SizedBox(width: 8),
                                      Text('Delete'),
                                    ],
                                  ),
                                ),

                              ],
                            //  color: Colors.transparent,
                            ).then((value) {
                              if (value == 'edit') {
                                // Handle Edit
                                print('Edit Clicked');
                              } else if (value == 'delete') {
                              }
                            });
                          },
                          child: Icon(Icons.more_horiz),
                        )

                      ],
                    ),
                  ],),),);
          })
          ]);
          }
          );}

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

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<CompanyProvider>(context,listen: false).initState();
  }
}