import 'package:flutter/material.dart';

import 'config_sidebar.dart';

SideBarConfig sideBarconfig = SideBarConfig();

class MenuView extends StatefulWidget {
  final MenuModel model;

  const MenuView({super.key, required this.model});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  bool tmpOpen = false;
  bool getSelected() {
    bool result = false;

    MenuModel? element = widget.model;

    if (element.index != null && sideBarconfig.currentIndex == element.index) {
      result = true;
    } else if (element.subMenuModel != null &&
        element.subMenuModel!.isNotEmpty) {
      var index = element.subMenuModel!.indexWhere(
        (test) => test.index == sideBarconfig.currentIndex,
      );

      if (index > -1) {
        result = true;
      }
    }

    return result;
  }

  refreshPage() {
    if (mounted) {
      setState(() {
        tmpOpen = false;
      });
    }
  }

  @override
  void initState() {
    sideBarconfig.addListener(refreshPage);
    super.initState();
  }

  @override
  void dispose() {
    sideBarconfig.addListener(refreshPage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = getSelected();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (widget.model.index != null) {
              setState(() {
                sideBarconfig.changeIndex(
                  widget.model.index!,
                  widget.model.title?.toString() ?? "",
                );
              });
              Navigator.of(context).pop();
            } else {
              tmpOpen = !tmpOpen;
              setState(() {});
            }
          },
          child: Container(
            // margin: const EdgeInsets.symmetric(horizontal: 5),
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: isSelected ? Theme.of(context).primaryColor : null,
              // borderRadius: BorderRadius.circular(10),
            ),
            height: 55,
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Icon(
                      widget.model.icon,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                      size: 19,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.model.title?.toString() ?? "",
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                ),
                widget.model.subMenuModel != null &&
                        widget.model.subMenuModel!.isNotEmpty
                    ? Icon(
                      Icons.arrow_drop_down_outlined,
                      color: isSelected ? Colors.white : Colors.grey.shade600,
                    )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        if (widget.model.subMenuModel != null &&
                widget.model.subMenuModel!.isNotEmpty &&
                isSelected ||
            tmpOpen)
          SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var element in widget.model.subMenuModel!)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        sideBarconfig.changeIndex(
                          element.index!,
                          element.title?.toString() ?? "",
                        );
                      });
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 10),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: (0.3 * 255))
                                : null,
                      ),
                      height: 45,
                      width: double.infinity,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Icon(
                                element.icon,
                                color:
                                    sideBarconfig.currentIndex == element.index
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade600,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              element.title?.toString() ?? "",
                              style: Theme.of(
                                context,
                              ).textTheme.labelLarge!.copyWith(
                                color:
                                    sideBarconfig.currentIndex == element.index
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class MenuModel {
  String? title;
  IconData? icon;
  int? index;
  List<MenuModel>? subMenuModel;

  MenuModel({this.title, this.icon, this.index, this.subMenuModel});
}
