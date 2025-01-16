import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_place_plus/google_place_plus.dart';
import 'package:wasly/controllers/routing/rout_observer.dart';
import 'package:wasly/screens/auth/signup_screen.dart';
import 'package:wasly/screens/home_screen.dart';
import 'package:wasly/screens/location/add_new_location_screen.dart';
import 'package:wasly_template/constants/data_constants.dart';
import 'package:wasly_template/core/styles/custom_color_styles.dart';
import 'package:wasly_template/core/styles/custom_responsive_text_styles.dart';
import 'package:wasly_template/helpers/app_constants.dart';
import 'package:wasly_template/wasly_template.dart';

class LocationPickerScreen extends StatefulWidget {
  final LatLng? initialLocation;
  const LocationPickerScreen({
    Key? key,
    this.initialLocation,
  }) : super(key: key);
  @override
  _LocationPickerScreenState createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late Future<LatLng?> _locationFuture;
  late BitmapDescriptor customIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController _mapController;
  final TextEditingController _searchController = TextEditingController();
  List<AutocompletePrediction> _searchResults = [];
  late GooglePlace googlePlace;
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _locationFuture = _initializeLocation();
    customMarker();
    googlePlace = GooglePlace("AIzaSyAUiTJnq3Tme_Op3bVWyVyAf8VwANRC4QY");
  }

  Future<LatLng?> _initializeLocation() async {
    // If initial location is provided, use it
    if (widget.initialLocation != null) {
      _selectedLocation = widget.initialLocation;
      return widget.initialLocation;
    }

    // Otherwise, get current location
    return _getCurrentLocation();
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

  Future<LatLng?> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      // _currentLocation = LatLng(position.latitude, position.longitude);
      _selectedLocation = LatLng(position.latitude, position.longitude);
      return _selectedLocation;
    } catch (e) {
      print("Error getting location: $e");
      return null;
    }
  }

  void _resetToCurrentLocation() async {
    LatLng? location = await _getCurrentLocation();
    if (location != null) {
      setState(() {
        _selectedLocation = location;
      });
      _mapController.animateCamera(CameraUpdate.newLatLng(_selectedLocation!));
    }
  }

  void _onSearchChanged() async {
    if (_searchController.text.isNotEmpty) {
      var result = await googlePlace.autocomplete.get(_searchController.text);
      if (result != null && result.predictions != null) {
        setState(() {
          _searchResults = result.predictions!;
        });
      }
    } else {
      setState(() {
        _searchResults = [];
      });
    }
  }

  void _selectSearchResult(AutocompletePrediction prediction) async {
    final details = await googlePlace.details.get(prediction.placeId!);
    if (details != null && details.result != null) {
      final lat = details.result!.geometry!.location!.lat;
      final lng = details.result!.geometry!.location!.lng;
      final newPosition = LatLng(lat!, lng!);

      setState(() {
        _selectedLocation = newPosition;
        _searchResults = [];
        _searchController.text = prediction.description!;
      });

      _mapController.animateCamera(CameraUpdate.newLatLng(newPosition));
    }
  }

  Set<Marker> _buildMarkers() {
    if (_selectedLocation == null) return {};

    return {
      Marker(
        draggable: true,
        onDragEnd: (newPosition) {
          setState(() {
            _selectedLocation = newPosition;
          });
        },
        markerId: MarkerId('selected_location'),
        position: _selectedLocation!,
        infoWindow: const InfoWindow(
          title: "Selected location",
          snippet: "Move to edit location",
        ),
        icon: customIcon,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<LatLng?>(
        future: _locationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text('Error retrieving location or location unavailable'),
            );
          }

          return Stack(
            children: [
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _mapController = controller;
                  controller.setMapStyle(DataConstants.mapStyle);
                },
                initialCameraPosition: CameraPosition(
                  target: _selectedLocation ?? LatLng(37.7749, -122.4194),
                  zoom: 15,
                ),
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                markers: _buildMarkers(),
                onLongPress: (LatLng position) {
                  setState(() {
                    _selectedLocation = position;
                  });
                },
              ),
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: CustomSearchField(
                        controller: _searchController,
                        hintText: 'Search your location',
                        suffix: const Icon(Icons.search),
                        onChanged: (value) => _onSearchChanged(),
                      ),
                    ),
                    if (_searchResults.isNotEmpty)
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(10),
                        color: Colors.white,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(_searchResults[index].description!),
                              onTap: () =>
                                  _selectSearchResult(_searchResults[index]),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
              Positioned(
                right: 20,
                bottom: 100,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.my_location, color: Colors.black),
                  onPressed: _resetToCurrentLocation,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: CustomTextButtonActive(
                  text: "Select Location",
                  onClick: () {
                    if (_selectedLocation == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please select a location')),
                      );

                      // Get.back(result: _selectedLocation);
                    }
                    if (Get.previousRoute == "AddNewAddressScreen") {
                      Get.back(result: _selectedLocation);
                    } else {
                      Get.to(AddNewAddressScreen(
                        selectedLocation: _selectedLocation!,
                      ));
                    }
                  },
                  radius: 30,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
