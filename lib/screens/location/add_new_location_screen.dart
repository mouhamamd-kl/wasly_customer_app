import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:wasly/controllers/routing/rout_observer.dart';
import 'package:wasly/controllers/services/customerAddress/customer_address_service.dart';
import 'package:wasly/core/test_data/testData.dart';
import 'package:wasly/models/customer_address.dart';
import 'package:wasly/screens/auth/signup_screen.dart';
import 'package:wasly/screens/home_screen.dart';
import 'package:wasly/screens/location/location_picker_screen.dart';
import 'package:wasly/widgets/chip_list.dart';
import 'package:wasly/widgets/sort_list.dart';
import 'package:wasly_template/constants/data_constants.dart';
import 'package:wasly_template/wasly_template.dart';
import 'package:get/get.dart';

// ... other imports

class AddNewAddressScreen extends StatefulWidget {
  LatLng selectedLocation;

  AddNewAddressScreen({
    Key? key,
    required this.selectedLocation,
  }) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  late GoogleMapController _mapController;
  String? address = "Fetching address...";
  late BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  String selectedLabel = "Home";
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _currentLocation = widget.selectedLocation;
    customMarker();
    _reverseGeocodeAddress();
  }

  @override
  void dispose() {
    // Ensure you clean up any ongoing tasks
    _mapController.dispose(); // Dispose the GoogleMapController if needed
    super.dispose();
  }

  void customMarker() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(35, 35)),
      AppConstants.getIconPath("you_location.png"),
    ).then((icon) {
      setState(() {
        customIcon = icon;
      });
    });
  }

  void _reverseGeocodeAddress() async {
    // Simulate reverse geocoding for demonstration

    await getPlaceName(
        latitude: _currentLocation.latitude,
        longitude: _currentLocation.longitude); // Replace with API response
  }

  Set<Marker> _buildMarkers(LatLng position) {
    return {
      Marker(
        draggable: true,
        markerId: MarkerId('selected_location'),
        position: position,
        infoWindow: const InfoWindow(
          title: "Selected location",
        ),
        icon: customIcon,
      ),
    };
  }
  // ... existing methods ...

  void _onMapTapped() async {
    final result = await Get.to<LatLng>(
      () => LocationPickerScreen(initialLocation: _currentLocation),
    );

    if (result != null) {
      setState(() {
        _currentLocation = result;
        widget.selectedLocation = result;
      });

      // Move camera first
      _mapController.animateCamera(CameraUpdate.newLatLng(_currentLocation));

      // Then get the address
      await getPlaceName(
          latitude: _currentLocation.latitude,
          longitude: _currentLocation.longitude);
    }
  }

  Future<void> getPlaceName(
      {required double latitude, required double longitude}) async {
    try {
      if (mounted) {
        setState(() {
          address = "Fetching address..."; // Show loading state
        });
      }
      await Future.delayed(Duration(seconds: 3));
      Address add = await GeoCode()
          .reverseGeocoding(latitude: latitude, longitude: longitude);

      if (mounted) {
        setState(() {
          // Build a more complete address
          List<String> addressParts = [];
          if (add.streetAddress != null) addressParts.add(add.streetAddress!);
          if (add.city != null) addressParts.add(add.city!);
          if (add.countryName != null) addressParts.add(add.countryName!);

          address = addressParts.isNotEmpty
              ? addressParts.join(', ')
              : 'Address not found';
        });
      }
    } catch (e) {
      print('Error getting address: $e');
      if (mounted) {
        setState(() {
          address = 'Failed to get address';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Address",
          style: CustomResponsiveTextStyles.headingH10,
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _onMapTapped,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      GoogleMap(
                        style: DataConstants.mapStyle,
                        mapToolbarEnabled: false,
                        rotateGesturesEnabled: false,
                        tiltGesturesEnabled: false,
                        scrollGesturesEnabled: false,
                        zoomGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        onTap: (argument) async {
                          _onMapTapped();
                        },
                        onMapCreated: (controller) async {
                          _mapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                          target: _currentLocation,
                          zoom: 15,
                        ),
                        markers: _buildMarkers(_currentLocation),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _onMapTapped,
                            splashColor: Colors.black12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Address TextField
            CustomTextField(
              fillColor: AppColors.backgroundAccent,
              readOnly: true,
              defaultIcon: AppConstants.getTextFieldPath("location.svg"),
              focusedIcon: AppConstants.getTextFieldPath("location.svg"),
              border: BorderRadius.circular(20),
              controller: TextEditingController(text: address),
              hintText: "",
            ),
            const SizedBox(height: 16),
            // Label As Section
            Text(
              "Label As",
              style: CustomResponsiveTextStyles.headingH9.copyWith(
                color: AppColors.textPrimaryBase,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 50,
              child: SortList(
                list: locationLabelIcons,
                onCategorySelected: (label) {
                  setState(() {
                    selectedLabel = label;
                  });
                },
              ),
            ),
            const Spacer(),
            // Add Now Button
            Container(
              width: double.infinity,
              child: CustomTextButtonActive(
                text: "Add Now",
                onClick: () async {
                  print(RouteObserver2.routeHistory);
                  if (RouteObserver2.routeHistory.contains("/SignupScreen")) {
                    await CustomerAddressService().createAddress({
                      'label': selectedLabel,
                      'longitude': _currentLocation.longitude,
                      'latitude': _currentLocation.latitude,
                      'is_default': 1
                    });
                    // Get.offAll(HomeScreen());
                    // RouteObserver2.clearHistory();
                  } else {
                    await CustomerAddressService().createAddress({
                      'label': selectedLabel,
                      'longitude': _currentLocation.longitude,
                      'latitude': _currentLocation.latitude,
                      'is_default': 0
                    });
                    // Get.until((route) => Get.currentRoute == '/PaymentScreen');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
