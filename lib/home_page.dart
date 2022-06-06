import 'package:app/profile_card.dart';
import 'package:app/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final profileController = Get.put(ProfileController());
  final textController = TextEditingController();
  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (profileController.status.value == 0) {
        profileController.fetchNextMovies();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'JumpIn',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        onChanged: (str) {
                          profileController.searchUsers(str);
                        },
                        controller: textController,
                        decoration: const InputDecoration(
                          hintText: 'Search User',
                          prefixIcon:  Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        Get.dialog(
                          Obx(
                            () => SizedBox(
                              height: 120,
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: const Icon(Icons.arrow_back_ios)),
                                    const Text('Select from a wide range of filters'),
                                  ],
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('Age (in years)'),
                                    RangeSlider(
                                      labels: const RangeLabels("16", "80"),
                                      values: RangeValues(
                                          profileController.start.value
                                              .toDouble(),
                                          profileController.end.value
                                              .toDouble()),
                                      onChanged: (val) {
                                        profileController.start.value =
                                            val.start.toInt();
                                        profileController.end.value =
                                            val.end.toInt();
                                      },
                                      min: 16,
                                      max: 80,
                                    )
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text('Reset')),
                                  ElevatedButton(
                                      onPressed: () {
                                        profileController.filterUsers();
                                        Get.back();
                                      },
                                      child: const Text('Done')),
                                ],
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
            Obx(() {
              if (profileController.showIndicator.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (profileController.status.value == 0) {
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: profileController.profiles.length,
                      // shrinkWrap: true,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return ProfileCard(
                          data: profileController.profiles
                              .elementAt(index)
                              .data() as Map,
                        );
                      },
                    ),
                  ),
                );
              } else if (profileController.status.value == 1) {
                if (profileController.searchProfiles.isEmpty) {
                  return Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'No Users Found',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  );
                }
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: profileController.searchProfiles.length,
                      shrinkWrap: true,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return ProfileCard(
                          data: profileController.searchProfiles
                              .elementAt(index)
                              .data() as Map,
                        );
                      },
                    ),
                  ),
                );
              } else {
                return Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: profileController.filterProfiles.length,
                      shrinkWrap: true,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return ProfileCard(
                          data: profileController.filterProfiles
                              .elementAt(index)
                              .data() as Map,
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
