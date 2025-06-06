import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'menu_view.dart';

class SideBarView extends StatefulWidget {
  const SideBarView({super.key});

  @override
  State<SideBarView> createState() => _SideBarViewState();
}

class _SideBarViewState extends State<SideBarView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Menu",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "Dashboard",
                      icon: Iconsax.home,
                      index: 0,
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "User & Access",
                      icon: Iconsax.user,
                      index: 1,
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "Company",
                      icon: Iconsax.buildings,
                      index: 2,
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "Parties",
                      icon: Iconsax.profile_2user,
                      subMenuModel: [
                        MenuModel(title: "Purchase Party", index: 3),
                        MenuModel(title: "Customer", index: 4),
                      ],
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "Items",
                      icon: Iconsax.bag,
                      subMenuModel: [
                        MenuModel(title: "Category", index: 5),
                        MenuModel(title: "Products", index: 6),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Accouning",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "Purchase Billing",
                      icon: Iconsax.calculator,
                      index: 7,
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "Sales Billing",
                      icon: Iconsax.bill,
                      index: 8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Report",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "Stock",
                      icon: Iconsax.money,
                      index: 9,
                    ),
                  ),
                  MenuView(
                    model: MenuModel(
                      title: "Sales",
                      icon: Iconsax.money,
                      index: 10,
                    ),
                  ),
                  // MenuView(
                  //   model: MenuModel(
                  //     title: "Purchase",
                  //     icon: Iconsax.money,
                  //     index: 11,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.transparent,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Center(
                          child: Icon(
                            Iconsax.logout,
                            color: Colors.grey.shade800,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 0),
                      Expanded(
                        child: Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
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
}
