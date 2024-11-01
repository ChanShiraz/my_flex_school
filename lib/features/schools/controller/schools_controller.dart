import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_flex_school/features/home/controller/home_controller.dart';
import 'package:my_flex_school/features/home/controller/user_controller.dart';
import 'package:my_flex_school/features/schools/controller/search_controller.dart';
import 'package:my_flex_school/features/schools/model/events.dart';
import 'package:my_flex_school/features/organizations/models/organizations.dart';
import 'package:my_flex_school/features/schools/model/res_type.dart';
import 'package:my_flex_school/features/schools/model/resources.dart';
import 'package:my_flex_school/features/schools/model/school.dart';
import 'package:my_flex_school/features/schools/model/service.dart';
import 'package:my_flex_school/features/spa/controller/spa_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SchoolsController extends GetxController {
  final UserController userController = Get.put(UserController());
  final SchoolSearchController searchController =
      Get.put(SchoolSearchController());
  final SupabaseClient supabase = Supabase.instance.client;
  final SpaController spaController = Get.put(SpaController());
  final String selectedFeature = '';
  RxList<School> schools = <School>[].obs;
  RxList<Resource> resources = <Resource>[].obs;
  RxList<ServiceModel> services = <ServiceModel>[].obs;
  RxList<Organization> organizations = <Organization>[].obs;
  RxList<Event> events = <Event>[].obs;

  RxBool isLoading = false.obs;
  Position? userPosition;
  double radiusInKm = 50;
  //schools logic
  searchSchools() async {
    isLoading.value = true;
    schools.clear();
    try {
      var query = supabase.from('flexschools').select();
      if (!searchController.selectedSpa.value.contains('Select Service Area') &&
          !searchController.selectedSpa.value.contains('All')) {
        query = query.eq('spaid', getSpaId());
      }
      if (searchController.zipController.text.isNotEmpty) {
        query = query.eq('zip', searchController.zipController.text);
      }
      final List<dynamic> data = await query;
      final List<School> schoolsData =
          data.map((json) => School.fromMap(json)).toList();
      schools.addAll(schoolsData);
    } catch (e) {
      Get.rawSnackbar(message: 'Error Occurred: $e');
    }
    isLoading.value = false;
  }

  //resources logic
  searchResources() async {
    isLoading.value = true;
    resources.clear();
    try {
      var query = supabase.from('resources').select();
      if (!searchController.selectedSpa.value.contains('Select Service Area') &&
          !searchController.selectedSpa.value.contains('All')) {
        query = query.eq('spaid', getSpaId());
      }
      if (searchController.zipController.text.isNotEmpty) {
        query = query.eq('zip', searchController.zipController.text);
      }
      if (searchController.selectedResTypes.isNotEmpty &&
          searchController.selectedResTypes.length <
              searchController.resTypes.length) {
        query = query.inFilter('res_type',
            searchController.selectedResTypes.map((e) => e.id).toList());
      }
      final List<dynamic> data = await query;
      final List<Resource> resourcesData =
          data.map((json) => Resource.fromMap(json)).toList();
      resources.addAll(resourcesData);
    } catch (e) {
      Get.rawSnackbar(message: 'Error Occurred: $e');
    }
    isLoading.value = false;
  }

  //resources logic
  searchServices() async {
    isLoading.value = true;
    services.clear();
    try {
      var query = supabase.from('services').select();
      if (!searchController.selectedSpa.value.contains('Select Service Area') &&
          !searchController.selectedSpa.value.contains('All')) {
        query = query.eq('spaid', getSpaId());
      }
      if (searchController.zipController.text.isNotEmpty) {
        query = query.eq('zip', searchController.zipController.text);
      }

      if (searchController.selectedServTypes.isNotEmpty &&
          searchController.selectedServTypes.length <
              searchController.servTypes.length) {
        query = query.inFilter('serv_type',
            searchController.selectedServTypes.map((e) => e.id).toList());
      }

      final List<dynamic> data = await query;
      final List<ServiceModel> servicesData =
          data.map((json) => ServiceModel.fromMap(json)).toList();
      services.addAll(servicesData);
    } catch (e) {
      Get.rawSnackbar(message: 'Error Occurred: $e');
    }
    isLoading.value = false;
  }

  //organization logic
  searchOrganizations() async {
    isLoading.value = true;
    organizations.clear();
    try {
      var query = supabase.from('organizations').select();
      if (!searchController.selectedSpa.value.contains('Select Service Area') &&
          !searchController.selectedSpa.value.contains('All')) {
        query = query.eq('spaid', getSpaId());
      }
      if (searchController.zipController.text.isNotEmpty) {
        query = query.eq('zip', searchController.zipController.text);
      }
      if (searchController.selectedOrgTypes.isNotEmpty &&
          searchController.selectedOrgTypes.length <
              searchController.orgTypes.length) {
        query = query.inFilter('org_type',
            searchController.selectedOrgTypes.map((e) => e.id).toList());
      }
      final List<dynamic> data = await query;
      final List<Organization> orgData =
          data.map((json) => Organization.fromMap(json)).toList();
      organizations.addAll(orgData);
    } catch (e) {
      Get.rawSnackbar(message: 'Error Occurred: $e');
    }
    isLoading.value = false;
  }

  //events logic
  searchEvents() async {
    isLoading.value = true;
    events.clear();
    try {
      var query = supabase.from('events').select();
      if (!searchController.selectedSpa.value.contains('Select Service Area') &&
          !searchController.selectedSpa.value.contains('All')) {
        query = query.eq('spaid', getSpaId());
      }
      if (searchController.zipController.text.isNotEmpty) {
        query = query.eq('zip', searchController.zipController.text);
      }
      final List<dynamic> data = await query;
      final List<Event> eventData =
          data.map((json) => Event.fromMap(json)).toList();
      events.addAll(eventData);
    } catch (e) {
      Get.rawSnackbar(message: 'Error Occurred: $e');
    }
    isLoading.value = false;
  }

  searchSchoolsNearBy() async {
    schools.clear();
    isLoading.value = true;
    try {
      if (userPosition == null) {
        await determinePosition();
        if (userPosition == null) {
          Get.rawSnackbar(message: 'Unable to determine user location.');
          isLoading.value = false;
          return;
        }
      }

      var response = await supabase.from('flexschools').select();
      final List<School> allSchools =
          response.map((json) => School.fromMap(json)).toList();
      List<Map<String, dynamic>> schoolsWithDistance = [];
      for (var school in allSchools) {
        try {
          List<Location> schoolLocation =
              await locationFromAddress(school.address1.toString());
          if (schoolLocation.isNotEmpty) {
            double schoolLatitude = schoolLocation[0].latitude;
            double schoolLongitude = schoolLocation[0].longitude;
            double distanceInMeters = Geolocator.distanceBetween(
              userPosition!.latitude,
              userPosition!.longitude,
              schoolLatitude,
              schoolLongitude,
            );
            double distanceInKm = distanceInMeters / 1000;
            if (distanceInKm <= radiusInKm) {
              schoolsWithDistance.add({
                'school': school,
                'distance': distanceInKm,
              });
            }
          }
        } catch (e) {}
      }
      schoolsWithDistance
          .sort((a, b) => a['distance'].compareTo(b['distance']));
      for (var element in schoolsWithDistance) {
        print(element['distance']);
      }
      List<School> nearbySchools =
          schoolsWithDistance.map((item) => item['school'] as School).toList();

      schools.addAll(nearbySchools);
    } catch (e) {
      print("Failed to find nearby schools: $e");
    }
    isLoading.value = false;
  }

  searchResourcesNearBy() async {
    resources.clear();
    isLoading.value = true;
    try {
      if (userPosition == null) {
        await determinePosition();
        if (userPosition == null) {
          Get.rawSnackbar(message: 'Unable to determine user location.');
          isLoading.value = false;
          return;
        }
      }

      var response = await supabase.from('resources').select();
      final List<Resource> allResources =
          response.map((json) => Resource.fromMap(json)).toList();
      List<Map<String, dynamic>> resourceWithDistance = [];
      for (var resource in allResources) {
        try {
          List<Location> schoolLocation =
              await locationFromAddress(resource.address1.toString());
          if (schoolLocation.isNotEmpty) {
            double schoolLatitude = schoolLocation[0].latitude;
            double schoolLongitude = schoolLocation[0].longitude;
            double distanceInMeters = Geolocator.distanceBetween(
              userPosition!.latitude,
              userPosition!.longitude,
              schoolLatitude,
              schoolLongitude,
            );
            double distanceInKm = distanceInMeters / 1000;
            if (distanceInKm <= radiusInKm) {
              resourceWithDistance.add({
                'resource': resource,
                'distance': distanceInKm,
              });
            }
          }
        } catch (e) {}
      }
      resourceWithDistance
          .sort((a, b) => a['distance'].compareTo(b['distance']));
      for (var element in resourceWithDistance) {
        print(element['distance']);
      }
      List<Resource> nearbyResources = resourceWithDistance
          .map((item) => item['resource'] as Resource)
          .toList();

      resources.addAll(nearbyResources);
    } catch (e) {
      print("Failed to find nearby schools: $e");
    }
    isLoading.value = false;
  }

  searchServicesNearBy() async {
    services.clear();
    isLoading.value = true;
    try {
      if (userPosition == null) {
        await determinePosition();
        if (userPosition == null) {
          Get.rawSnackbar(message: 'Unable to determine user location.');
          isLoading.value = false;
          return;
        }
      }

      var response = await supabase.from('services').select();
      final List<ServiceModel> allResources =
          response.map((json) => ServiceModel.fromMap(json)).toList();
      List<Map<String, dynamic>> servicesWithDistance = [];
      for (var resource in allResources) {
        try {
          List<Location> schoolLocation =
              await locationFromAddress(resource.address1.toString());
          if (schoolLocation.isNotEmpty) {
            double schoolLatitude = schoolLocation[0].latitude;
            double schoolLongitude = schoolLocation[0].longitude;
            double distanceInMeters = Geolocator.distanceBetween(
              userPosition!.latitude,
              userPosition!.longitude,
              schoolLatitude,
              schoolLongitude,
            );
            double distanceInKm = distanceInMeters / 1000;
            if (distanceInKm <= radiusInKm) {
              servicesWithDistance.add({
                'services': resource,
                'distance': distanceInKm,
              });
            }
          }
        } catch (e) {}
      }
      servicesWithDistance
          .sort((a, b) => a['distance'].compareTo(b['distance']));
      for (var element in servicesWithDistance) {
        print(element['distance']);
      }
      List<ServiceModel> nearbyServices = servicesWithDistance
          .map((item) => item['services'] as ServiceModel)
          .toList();

      services.addAll(nearbyServices);
    } catch (e) {
      print("Failed to find nearby schools: $e");
    }
    isLoading.value = false;
  }

  searchOrganizationsNearBy() async {
    organizations.clear();
    isLoading.value = true;
    try {
      if (userPosition == null) {
        await determinePosition();
        if (userPosition == null) {
          Get.rawSnackbar(message: 'Unable to determine user location.');
          isLoading.value = false;
          return;
        }
      }
      var response = await supabase.from('organizations').select();
      final List<Organization> allOrganzations =
          response.map((json) => Organization.fromMap(json)).toList();
      List<Map<String, dynamic>> organizationsWithDistance = [];
      for (var organization in allOrganzations) {
        try {
          List<Location> schoolLocation =
              await locationFromAddress(organization.address1.toString());
          if (schoolLocation.isNotEmpty) {
            double schoolLatitude = schoolLocation[0].latitude;
            double schoolLongitude = schoolLocation[0].longitude;
            double distanceInMeters = Geolocator.distanceBetween(
              userPosition!.latitude,
              userPosition!.longitude,
              schoolLatitude,
              schoolLongitude,
            );
            double distanceInKm = distanceInMeters / 1000;
            if (distanceInKm <= radiusInKm) {
              organizationsWithDistance.add({
                'organization': organization,
                'distance': distanceInKm,
              });
            }
          }
        } catch (e) {}
      }
      organizationsWithDistance
          .sort((a, b) => a['distance'].compareTo(b['distance']));
      for (var element in organizationsWithDistance) {
        print(element['distance']);
      }
      List<Organization> nearbyOrganizations = organizationsWithDistance
          .map((item) => item['organization'] as Organization)
          .toList();

      organizations.addAll(nearbyOrganizations);
    } catch (e) {
      print("Failed to find nearby schools: $e");
    }
    isLoading.value = false;
  }

  searchEventsNearBy() async {
    events.clear();
    isLoading.value = true;
    try {
      if (userPosition == null) {
        await determinePosition();
        if (userPosition == null) {
          Get.rawSnackbar(message: 'Unable to determine user location.');
          isLoading.value = false;
          return;
        }
      }
      var response = await supabase.from('events').select();
      final List<Event> allEvents =
          response.map((json) => Event.fromMap(json)).toList();
      List<Map<String, dynamic>> eventsWithDistance = [];
      for (var organization in allEvents) {
        try {
          List<Location> schoolLocation =
              await locationFromAddress(organization.address1.toString());
          if (schoolLocation.isNotEmpty) {
            double schoolLatitude = schoolLocation[0].latitude;
            double schoolLongitude = schoolLocation[0].longitude;
            double distanceInMeters = Geolocator.distanceBetween(
              userPosition!.latitude,
              userPosition!.longitude,
              schoolLatitude,
              schoolLongitude,
            );
            double distanceInKm = distanceInMeters / 1000;
            if (distanceInKm <= radiusInKm) {
              eventsWithDistance.add({
                'events': organization,
                'distance': distanceInKm,
              });
            }
          }
        } catch (e) {}
      }
      eventsWithDistance.sort((a, b) => a['distance'].compareTo(b['distance']));
      for (var element in eventsWithDistance) {
        print(element['distance']);
      }
      List<Event> nearbyEvents =
          eventsWithDistance.map((item) => item['events'] as Event).toList();

      events.addAll(nearbyEvents);
    } catch (e) {
      print("Failed to find nearby schools: $e");
    }
    isLoading.value = false;
  }

  int getSpaId() {
    int index = spaController.spa
        .indexWhere((spa) => spa.name.contains(searchController.selectedSpa));
    if (index != -1) {
      return index + 1;
    } else {
      return 0;
    }
  }

  Future<Position?> determinePosition() async {
    try {
      bool serviceEnabled;
      //LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }
      // permission = await Geolocator.checkPermission();
      // if (permission == LocationPermission.denied) {
      //   permission = await Geolocator.requestPermission();
      //   if (permission == LocationPermission.denied) {
      //     Get.rawSnackbar(
      //         message: 'Permission denied! we could find your location');
      //   }
      //   return null;
      // }
      Position position = await Geolocator.getCurrentPosition();
      userPosition = position;
      return position;
    } catch (e) {
      if (e.toString().contains(
          'User denied permissions to access the device\'s location.')) {
        Get.rawSnackbar(
            message:
                'Location permissions are permanently denied, Please allow loaction permission in settings');
      } else {
        Get.rawSnackbar(message: e.toString());
      }
    }
    return null;
  }
}
