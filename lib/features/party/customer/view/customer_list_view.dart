import 'package:billing_web/features/config.dart';
import 'package:billing_web/features/party/customer/viewModel/customer_provider.dart';
import 'package:billing_web/features/utils/on_init.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import 'customer_about_view.dart';
import 'customer_creation_view.dart';
import 'customer_edit_view.dart';
import 'customer_transaction_view.dart';

class CustomerListView extends StatefulWidget {
  const CustomerListView({super.key});

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView>

    with SingleTickerProviderStateMixin, OnInit {
  late TabController controller;



  List<Widget> listPage = [CustomerAboutView(index: 0,), CustomerTransactionView()];

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 800;

    return Material(
      child: SafeArea(
        child: Consumer<CustomerProvider>(
          builder: (context, controller, child) {
            return Padding(
              padding: EdgeInsets.all(isMobile ? 8 : 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child:
                        isMobile
                            ? _buildMobileLayout()
                            : _buildDesktopLayout(screenSize),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Consumer<CustomerProvider>(
        builder: (context, provider, child) {

    if (provider.showDetailView && provider.selectedPartyIndex != null) {
      return _buildMobileDetailView();
    } else {
      return _buildCustomerListView(true);
    }
        },
    );
  }


  Widget _buildMobileDetailView() {

    return Consumer<CustomerProvider>(
        builder: (context, model, child) {
          final index = model.selectedPartyIndex;
          if (index == null || index >= model.listOfCustomer.length) {
            return SizedBox();
          }
          final selectedParty = model.listOfCustomer[index];

          return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with back button
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        model.setShowDetailView(false);
                      },
                    ),
                    Expanded(
                      child: Text(
                        selectedParty.partyName!,
                        style: Theme.of(context).textTheme.headlineSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildActionButton(
                      icon: Iconsax.edit,
                      label: "Edit",
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    _buildActionButton(
                      icon: Iconsax.trash,
                      label: "Delete",
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              TabBar(
                onTap: (value) {
                  model.setCurrentTab(value);
                },
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                controller: controller,
                tabs: [Tab(text: "About"), Tab(text: "Transaction")],
              ),
              Expanded(child: listPage[model.currentTab]),
            ],
          ),
        );
      }
    );
  }

  Widget _buildDesktopLayout(Size screenSize) {
    return Consumer<CustomerProvider>(
        builder: (context, model, child) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer List - adjustable width based on screen size
            SizedBox(
              width: screenSize.width * 0.3,
              child: _buildCustomerListView(false),
            ),
            SizedBox(width: 10),
            // Detail View
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:
                   model. selectedPartyIndex != null
                        ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with company name and action buttons
                            _buildDetailHeader(),
                            TabBar(
                              onTap: (value) {
                                model.setCurrentTab(value);
                              },
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              controller: controller,
                              tabs: [Tab(text: "About"), Tab(text: "Transaction")],
                            ),
                            Expanded(child: listPage[model.currentTab]),
                          ],
                        )
                        : Center(
                          child: Text(
                            "Select a customer to features details",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget _buildCustomerListView(bool isMobile) {
    return Consumer<CustomerProvider>(
      builder: (context, model, child) {
        return Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(isMobile ? 8.0 : 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Customer",
                            style: Theme.of(context).textTheme.headlineSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Manage and features registered Customer",
                            style: Theme.of(context).textTheme.labelMedium,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildAddButton(isMobile),
                  ],
                ),
              ),
              // Search bar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 8.0 : 10.0,
                  vertical: 4.0,
                ),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, size: 18),
                      filled: true,
                      fillColor: Color(0xffEEEEEE),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      hintText: "Search ...",
                    ),
                  ),
                ),
              ),
              // Customer list vertical layout - Improved formatting
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: [
                          // List header
                          Container(
                            color: Theme.of(
                              context,
                            ).primaryColor.withAlpha((0.1 * 255).toInt()),

                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            width: double.infinity,
                            child: Text(
                              'Customers',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          // List body
                          Expanded(
                            child: ListView.builder(
                              itemCount: model.listOfCustomer.length,
                              itemBuilder: (context, index) {
                                final party = model.listOfCustomer[index];
                                return Material(
                                  child: InkWell(
                                    onTap: () {
                                      model.setSelectedPartyIndex(index);
                                      if (isMobile) {
                                        model.setShowDetailView(true);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 4),
                                      color:
                                         model. selectedPartyIndex == index
                                              ? Theme.of(context).primaryColor
                                                  .withAlpha((0.1 * 255).toInt())
                                              : (index % 2 == 0
                                                  ? Colors.white
                                                  : Colors.grey.shade50),
                                      child: ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey.shade200,
                                          ),
                                          child: Text(
                                            '#${index + 1}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          party.partyName!,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                        trailing: GestureDetector(
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
                                              model.loadUserData(party);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => CustomerEditView()));
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
                                                await model.deleteCustomer(party.id!);
                                  
                                              }
                                            }
                                          },
                                          child: Icon(Icons.more_horiz),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildDetailHeader() {
    return Consumer<CustomerProvider>(
      builder: (context, model, child){
        if (model.selectedPartyIndex == null) return SizedBox();
        if (model.selectedPartyIndex != null && model.selectedPartyIndex! < model.listOfCustomer.length) {
          final selectedParty = model.listOfCustomer[model.selectedPartyIndex!];

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedParty.partyName!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Row(
                children: [
                  _buildActionButton(
                    icon: Iconsax.edit,
                    label: "Edit",
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 10),
                  _buildActionButton(
                    icon: Iconsax.trash,
                    label: "Delete",
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          ),
        );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildAddButton(bool isMobile) {
    return GestureDetector(
      onTap: () {
        // Set the creation page for reference
        creationPageConfig.changePage(CustomerCreateView());

        // Show customer creation form in a dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.all(8.0),
                child: CustomerCreateView(),
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 10 : 15,
          vertical: isMobile ? 6 : 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white, size: isMobile ? 16 : 20),
            if (!isMobile) ...[
              const SizedBox(width: 5),
              Text(
                "Add New",
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.copyWith(color: Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 15,
        vertical: isMobile ? 6 : 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: isMobile ? 16 : 18),
          if (!isMobile) ...[
            const SizedBox(width: 5),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelMedium!.copyWith(color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context, int index) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: [
        PopupMenuItem(
          child: Text('Edit'),
          onTap: () {
            // Handle edit
          },
        ),
        PopupMenuItem(
          child: Text('Delete'),
          onTap: () {
            // Handle delete
          },
        ),
        PopupMenuItem(
          child: Text('View Details'),
          onTap: () {
    Future.delayed(Duration.zero, () {
    final provider = Provider.of<CustomerProvider>(context, listen: false);
    provider.setSelectedPartyIndex(index);

    if (MediaQuery.of(context).size.width < 800) {
    provider.setShowDetailView(true);
    }
    });
    },
        ),
      ],
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    // TODO: implement afterFirstLayout
    Provider.of<CustomerProvider>(context,listen: false).initState();
  }
}
