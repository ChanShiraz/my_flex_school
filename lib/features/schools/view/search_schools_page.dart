import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/home/controller/home_controller.dart';
import 'package:my_flex_school/features/schools/controller/schools_controller.dart';
import 'package:my_flex_school/features/schools/controller/search_controller.dart';
import 'package:my_flex_school/features/schools/view/schools_page.dart';
import 'package:my_flex_school/features/schools/widgets/check_box_widget.dart';
import 'package:my_flex_school/features/spa/controller/spa_controller.dart';

class SearchSchoolsPage extends StatefulWidget {
  const SearchSchoolsPage({super.key, required this.selectedFeature});
  final String selectedFeature;

  @override
  State<SearchSchoolsPage> createState() => _SearchSchoolsPageState();
}

class _SearchSchoolsPageState extends State<SearchSchoolsPage> {
  final SchoolSearchController searchController =
      Get.put(SchoolSearchController());
  final SchoolsController schoolsController = Get.put(SchoolsController());

  final SpaController spaController = Get.put(SpaController());
  @override
  void initState() {
    if (widget.selectedFeature.contains('Resources') &&
        searchController.resTypes.isEmpty) {
      searchController.getResTypes();
    }
    if (widget.selectedFeature.contains('Organizations') &&
        searchController.orgTypes.isEmpty) {
      searchController.getOrgTypes();
    }
    if (widget.selectedFeature.contains('Services') &&
        searchController.servTypes.isEmpty) {
      searchController.getServTypes();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //spaController.getSpa();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Find ${widget.selectedFeature}',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Search By Service Area',
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
              Obx(
                () => spaController.isLoadingSpa.value
                    ? const Center(child: CircularProgressIndicator())
                    : DropdownButton<String>(
                        isExpanded: true,
                        hint: Text(searchController.selectedSpa.value),
                        items: spaController.spa.map((value) {
                          return DropdownMenuItem<String>(
                            value: value.name,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (val) {
                          searchController.selectedSpa.value = val!;
                        },
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Search By ZIP Code',
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
              TextField(
                controller: searchController.zipController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45, width: 0.0),
                    ),
                    hintText: 'ZIP Code',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black54)),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Type',
                style: TextStyle(fontSize: 20, color: Colors.black45),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () {
                  if (widget.selectedFeature.contains('Resources')) {
                    return searchController.resTypeLoading.value
                        ? const Center(
                            child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: CircularProgressIndicator(),
                          ))
                        : Column(
                            children: [
                              CheckBoxWidget(
                                title: 'All',
                                value:
                                    searchController.selectedResTypes.length ==
                                        searchController.resTypes.length,
                                onChange: (value) {
                                  searchController.deselectResTypes();
                                },
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: searchController.resTypes.length,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => CheckBoxWidget(
                                      title:
                                          searchController.resTypes[index].name,
                                      value: searchController.selectedResTypes
                                          .contains(
                                              searchController.resTypes[index]),
                                      onChange: (value) {
                                        if (searchController.selectedResTypes
                                            .contains(searchController
                                                .resTypes[index])) {
                                          searchController.removeResType(
                                              searchController.resTypes[index]);
                                        } else {
                                          searchController.addResType(
                                              searchController.resTypes[index]);
                                        }
                                      },
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                  }
                  if (widget.selectedFeature.contains('Organizations')) {
                    return searchController.orgTypeLoading.value
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              CheckBoxWidget(
                                title: 'All',
                                value:
                                    searchController.selectedOrgTypes.length ==
                                        searchController.orgTypes.length,
                                onChange: (value) {
                                  searchController.deselectOrgTypes();
                                },
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: searchController.orgTypes.length,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => CheckBoxWidget(
                                      title:
                                          searchController.orgTypes[index].name,
                                      value: searchController.selectedOrgTypes
                                          .contains(
                                              searchController.orgTypes[index]),
                                      onChange: (value) {
                                        if (searchController.selectedOrgTypes
                                            .contains(searchController
                                                .orgTypes[index])) {
                                          searchController.removeOrgType(
                                              searchController.orgTypes[index]);
                                        } else {
                                          searchController.addOrgType(
                                              searchController.orgTypes[index]);
                                        }
                                      },
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                  }
                  if (widget.selectedFeature.contains('Services')) {
                    return searchController.servTypeLoading.value
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              CheckBoxWidget(
                                title: 'All',
                                value:
                                    searchController.selectedServTypes.length ==
                                        searchController.servTypes.length,
                                onChange: (value) {
                                  searchController.deselectServTypes();
                                },
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: searchController.servTypes.length,
                                itemBuilder: (context, index) {
                                  return Obx(
                                    () => CheckBoxWidget(
                                      title: searchController
                                          .servTypes[index].name,
                                      value: searchController.selectedServTypes
                                          .contains(searchController
                                              .servTypes[index]),
                                      onChange: (value) {
                                        if (searchController.selectedServTypes
                                            .contains(searchController
                                                .servTypes[index])) {
                                          searchController.removeServType(
                                              searchController
                                                  .servTypes[index]);
                                        } else {
                                          searchController.addServType(
                                              searchController
                                                  .servTypes[index]);
                                        }
                                      },
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    //searchController.searchSchools();
                    if (searchController.checkForValue()) {
                      Get.to(
                          SchoolsPage(selectedFeature: widget.selectedFeature));
                    } else {
                      Get.rawSnackbar(
                          message:
                              'Please select service area or enter ZIP code to search!');
                    }
                  },
                  child: Container(
                    height: 45,
                    width: width * 0.7,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Search',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: width * .3,
                    color: Colors.grey,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Text('OR'),
                  ),
                  Container(
                    height: 1,
                    width: width * .3,
                    color: Colors.grey,
                  ),
                ],
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    LocationPermission permission =
                        await Geolocator.checkPermission();

                    permission = await Geolocator.requestPermission();
                    if (permission == LocationPermission.whileInUse ||
                        permission == LocationPermission.always) {
                      Get.to(SchoolsPage(
                        selectedFeature: widget.selectedFeature,
                        nearBy: true,
                      ));
                    }
                    if (permission == LocationPermission.denied) {
                      Get.rawSnackbar(
                          message:
                              'Permission denied! we could find your location');
                    }
                    return;
                  },
                  child: Container(
                    height: 45,
                    width: width * 0.7,
                    decoration: BoxDecoration(
                      color: AppColors.mainColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Find near me',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
