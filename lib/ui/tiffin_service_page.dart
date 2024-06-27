import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

class TiffinServicePage extends StatefulWidget {
  const TiffinServicePage({super.key});

  @override
  State<TiffinServicePage> createState() => _TiffinServicePageState();
}

class _TiffinServicePageState extends State<TiffinServicePage> {

  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  void initState() {
    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  controller: sideMenu,
                  style: SideMenuStyle(
                    // compactSideMenuWidth: MediaQuery.of(context).size.width * .20,

                    showTooltip: true,
                    displayMode: SideMenuDisplayMode.compact,
                    showHamburger: true,
                    hoverColor: Colors.deepOrange,
                    selectedHoverColor: Colors.deepOrange,
                    selectedColor: Colors.deepOrange,
                    selectedTitleTextStyle: const TextStyle(color: Colors.black),
                    selectedIconColor: Colors.white,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    // ),
                    // backgroundColor: Colors.grey[200]
                  ),
                  title: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 150,
                        ),
                        child: Image.asset(
                          'assets/images/img.jpg',
                        ),
                      ),
                      const Divider(
                        indent: 8.0,
                        endIndent: 8.0,
                      ),
                    ],
                  ),
                  // footer: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.lightBlue[50],
                  //         borderRadius: BorderRadius.circular(12)),
                  //     child: Padding(
                  //       padding:
                  //       const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  //       child: Text(
                  //         'mohada',
                  //         style: TextStyle(fontSize: 100, color: Colors.grey[800]),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  items: [
                    SideMenuItem(
                      // trailing: Image.asset("assets/images/imgg.jpg"),
                      title: 'Breakfast',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.free_breakfast),
                      // badgeContent: const Text(
                      //   '3',
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      tooltipContent: "Breakfast",
                    ),
                    SideMenuItem(
                      title: 'Lunch',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.lunch_dining),
                    ),
                    // SideMenuExpansionItem(
                    //   title: "Expansion Item",
                    //   icon: const Icon(Icons.kitchen),
                    //   children: [
                    //     SideMenuItem(
                    //       title: 'Expansion Item 1',
                    //       onTap: (index, _) {
                    //         sideMenu.changePage(index);
                    //       },
                    //       icon: const Icon(Icons.home),
                    //       badgeContent: const Text(
                    //         '3',
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //       tooltipContent: "Expansion Item 1",
                    //     ),
                    //     SideMenuItem(
                    //       title: 'Expansion Item 2',
                    //       onTap: (index, _) {
                    //         sideMenu.changePage(index);
                    //       },
                    //       icon: const Icon(Icons.supervisor_account),
                    //     )
                    //   ],
                    // ),
                    SideMenuItem(
                      title: 'Files',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.dinner_dining),
                      trailing: Container(
                          decoration: const BoxDecoration(
                            // image: Image(image: AssetImage("assets/images/img.jpg")),
                              color: Colors.amber,
                              borderRadius: BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 3),
                            child: Text(
                              'New',
                              style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                            ),
                          )),
                    ),
                    SideMenuItem(
                      title: 'Download',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.download),
                    ),
                    SideMenuItem(
                      builder: (context, displayMode) {
                        return const Divider(
                          endIndent: 8,
                          indent: 8,
                        );
                      },
                    ),
                    SideMenuItem(
                      title: 'Settings',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                    // SideMenuItem(
                    //   onTap:(index, _){
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(Icons.image_rounded),
                    // ),
                    // SideMenuItem(
                    //   title: 'Only Title',
                    //   onTap:(index, _){
                    //     sideMenu.changePage(index);
                    //   },
                    // ),
                    const SideMenuItem(
                      title: 'Exit',
                      icon: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
                const VerticalDivider(width: 0,),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: [
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Trial Meal',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Weekly Meals',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Monthly Meal Plans',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Weekly Mini Meals',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Monthly Mini Meals',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      // this is for SideMenuItem with builder (divider)
                      const SizedBox.shrink(),

                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Settings',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
        );
  }
}