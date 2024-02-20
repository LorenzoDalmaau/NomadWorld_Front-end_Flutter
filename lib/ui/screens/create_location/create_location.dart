import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:nomadworld/models/Country.dart';
import 'package:nomadworld/ui/widgets/images_loader.dart';
import 'package:nomadworld/ui/widgets/map_box.dart';
import 'package:nomadworld/utils/api/api_service.dart';
import 'package:provider/provider.dart';
import '../../../domain/provider/provider.dart';
import '../../widgets/create_il/create_il_dropdown_title.dart';
import '../../widgets/create_il/create_il_location_title.dart';
import '../../widgets/create_il/create_il_name.dart';
import '../../widgets/create_il/create_il_name_description.dart';
import '../../widgets/create_il/create_il_subtitle.dart';
import '../../widgets/create_il/create_il_title.dart';

class CreateLocation extends StatefulWidget {
  const CreateLocation({super.key});

  @override
  State<CreateLocation> createState() => _CreateLocationState();
}

class _CreateLocationState extends State<CreateLocation> {
  TextEditingController nameLocationController = TextEditingController();
  TextEditingController descriptionLocationController = TextEditingController();
  final ApiService apiService = ApiService();
  late NomadProvider provider;
  late Country dropdownValue;
  LatLng? location;
  late bool isLoading;

  /// Functions
  @override
  void initState() {
    super.initState();
    _loadCountries();
    _getCurrentLocation();
  }

  Future<void> _loadCountries() async {
    try {
      // Mostrar indicador de carga
      setState(() {
        isLoading = true;
      });

      List<Country> countries = await apiService.getCountryList();
      provider.setAPIContries(countries);
      setState(() {
        dropdownValue = countries[0];
        isLoading = false;
      });
    } catch (error) {
      print('Error al cargar la lista de países: $error');
      setState(() {
        isLoading = false; // Ocultar indicador de carga en caso de error
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        location = LatLng(position.latitude, position.longitude);
        print('---- Current Location: $location ---- ');
      });
    } catch (e) {
      print('---- Error obtaining current location: $e ----');
    }
  }

  /// Validate the input fields
  bool validateFields() {
    if (nameLocationController.text.isEmpty ||
        descriptionLocationController.text.isEmpty ||
        location == null) {
      // Show a snackbar or any other UI feedback for validation error
      Get.snackbar('Por favor', 'Introduzca todos los campos',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (provider.images.isEmpty) {
      // Show a snackbar or any other UI feedback for missing images
      Get.snackbar('Por favor', 'Suba al menos una foto',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    return true;
  }


  /// Create Location Screen

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<NomadProvider>(context);

    return Scaffold(
      // APPBAR
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              List<String> base64Images = provider.convertImagesToBase64();
              if (validateFields()) {

                ApiService().createLocation(
                  nameLocationController.text.toString(),
                  descriptionLocationController.text.toString(),
                  location!,
                  base64Images,
                  dropdownValue
                );

                // Eliminar lista de imagenes
                provider.images.clear();
              }
            },
            child: const Text(
              'Crear ubicación',
              style: TextStyle(
                color: Color(0xff195f47),
                fontWeight: FontWeight.bold,
                fontSize: 17,
                letterSpacing: 0.5,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      CreateILTitle(title: 'Mi ubicación'),

                      /// Subtitle
                      CreateILSubtitle(subtitle: 'Añade la ubicación, tus fotos y\nrecomendaciones'),

                      const SizedBox(height: 50),

                      /// Location Name
                      CreateILName(ilName: 'Pon un título a tu recuerdo'),

                      const SizedBox(height: 10),

                      /// FormField
                      TextFormField(
                        controller: nameLocationController,
                        maxLines: 1,
                        maxLength: 25,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Por ejemplo: La Sagrada Familia',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const create_il_name_description(),

                      const SizedBox(height: 10),

                      // Textfiel descripción
                      TextFormField(
                        controller: descriptionLocationController,
                        maxLength: 180,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: 'Añadir descripción',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      const dropdown_menu_title(),

                      /// Dropdown Menu
                      DropdownButton<int>(
                        value: dropdownValue.id,
                        onChanged: (int? newDropdownValue) {
                          setState(() {
                            dropdownValue = provider.countries.firstWhere(
                                (country) => country.id == newDropdownValue);
                          });
                        },
                        items: provider.countries.map((Country country) {
                          return DropdownMenuItem<int>(
                            value: country.id,
                            child: Text(country.name),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),

                      /// Title Location
                      const create_il_location_title(),

                      const SizedBox(height: 10),

                      Container(
                        height: 250,
                        color: const Color.fromARGB(192, 25, 95, 71),
                        child: MapBox(
                          onLocationChanged: (LatLng newLocation) {
                            setState(() {
                              location = newLocation;
                              print('Selected Location: $location');
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 5),

                      /// Advertation
                      const Text(
                        'Por favor, en caso de que no le deje continuar, seleccione un marcador de nuevo.',
                        style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),

                      const SizedBox(height: 20),

                      /// Images
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          'Tus fotografías',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// Load Images from camera | gallery
                      const ImagesLoader(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}










