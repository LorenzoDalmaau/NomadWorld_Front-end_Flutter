import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:nomadworld/models/Location.dart';
import 'package:nomadworld/ui/widgets/create_il/create_il_dropdown_title.dart';
import 'package:nomadworld/ui/widgets/create_il/create_il_name.dart';
import 'package:nomadworld/ui/widgets/create_il/create_il_title.dart';
import 'package:provider/provider.dart';
import '../../../domain/provider/provider.dart';
import '../../../models/Country.dart';
import '../../../utils/api/api_service.dart';
import '../../widgets/create_il/create_il_subtitle.dart';
import '../../widgets/search_bars/route_searchbar.dart';

class CreateRoute extends StatefulWidget {
  const CreateRoute({super.key});

  @override
  State<CreateRoute> createState() => _CreateRouteState();
}

class _CreateRouteState extends State<CreateRoute> {
  final ApiService apiService = ApiService();
  late List<int> selectedLocations;
  late NomadProvider provider;
  late bool isLoading;
  late Country dropdownValue;
  late int dropdownValueDistance;
  late int dropdownValueDuration;

  TextEditingController nameRouteController = TextEditingController();
  TextEditingController descriptionRouteController = TextEditingController();
  List<LocationData> countryLocations = [];
  int? selectedCountryId; // Cambio aquí para controlar el estado inicial


  @override
  void initState() {
    super.initState();
    _loadCountries();
    selectedLocations = [];
  }

  /// Cargar paies dropdown
  Future<void> _loadCountries() async {
    try {
      // Mostrar indicador de carga
      setState(() {
        isLoading = true;
      });

      List<Country> countries = await apiService.getCountryList();
      provider.setAPIContries(countries);
      setState(() {
        dropdownValueDistance = 1;
        dropdownValueDuration = 1;
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
    /// Peticion de localizaciones de un país
  getLocations() async {
    List<LocationData> apiResponse =
        await ApiService().getCountryLocations(dropdownValue.name);
    countryLocations = apiResponse;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<NomadProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              apiService.createRoute(
                  dropdownValue,
                  nameRouteController.text.toString(),
                  descriptionRouteController.text.toString(),
                  selectedLocations,
                  dropdownValueDistance,
                  dropdownValueDuration
                  );
            },
            child: const Text(
              'Crear ruta',
              style: TextStyle(
                color: Colors.green,
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title
                        CreateILTitle(title: 'Crear nueva ruta'),

                        /// Subtitle
                        CreateILSubtitle(
                            subtitle: 'Pensar una frase\nacorde a su objetivo'),

                        const SizedBox(height: 50),

                        /// Route Name Title
                        CreateILName(ilName: 'Pon un título a tu ruta'),

                        const SizedBox(height: 10),

                        /// Route Name
                        TextFormField(
                          controller: nameRouteController,
                          maxLines: 1,
                          maxLength: 25,
                          minLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Por ejemplo: Visita a Pie Picasso',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        CreateILName(
                            ilName: 'Añade una descripción a tu nueva ruta'),

                        const SizedBox(height: 10),

                        /// Route Description
                        TextFormField(
                          controller: descriptionRouteController,
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

                        /// Distance
                        CreateILName(
                            ilName: 'Selecciona la distancia de tu ruta'),


                        const SizedBox(height: 10),

                        /// Dropdown Menu
                        // Este dropdown menu muestra una lista de enteros del 1 a +500 donde el usuario puede seleccionar la distancia de la ruta
                        DropdownButton<int>(
                          value: dropdownValueDistance,
                          // Valor inicial del dropdown menu
                          // Actualizar el valor del dropdown menu por el valor seleccionado
                          onChanged: (int? newDropdownValue) {
                            setState(() {
                              dropdownValueDistance = newDropdownValue!;
                            });
                          },
                          // Lista de items del dropdown menu
                          items: <DropdownMenuItem<int>>[
                            for (int i = 1; i <= 500; i++)
                              DropdownMenuItem<int>(
                                value: i,
                                child: Text('$i km'),
                              ),
                            // Mostrar la opción de más de 500 km
                            const DropdownMenuItem<int>(
                              value: 501,
                              child: Text('Más de 500 km'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        ///Duration
                        CreateILName(
                            ilName: 'Selecciona la duración de tu ruta'),

                        DropdownButton<int>(
                          value: dropdownValueDuration,
                          // Valor inicial del dropdown menu
                          // Actualizar el valor del dropdown menu por el valor seleccionado
                          onChanged: (int? newDropdownValue) {
                            setState(() {
                              dropdownValueDuration = newDropdownValue!;
                            });
                          },
                          // Lista de items del dropdown menu
                          items: <DropdownMenuItem<int>>[
                            for (int i = 1; i <= 31; i++)
                              DropdownMenuItem<int>(
                                value: i,
                                child: Text('$i dias'),
                              ),
                            // Mostrar la opción de más de 500 km
                            const DropdownMenuItem<int>(
                              value: 32,
                              child: Text('Más de 31 dias'),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),


                        const dropdown_menu_title(),

                        /// Dropdown Menu
                        /// Este dropdown menu muestra una lista de países donde el usuario puede seleccionar el país de la ruta
                        /// Si no hay ningún país seleccionado, por defecto, se selecciona el primer país de la lista
                        DropdownButton<int?>(
                          value: selectedCountryId,
                          hint: const Text('Seleccionar un país'), // Texto por defecto
                          onChanged: (int? newDropdownValue) {
                            setState(() {
                              selectedCountryId = newDropdownValue;
                              if (newDropdownValue != null) { // Verificar si se seleccionó un país válido
                                dropdownValue = provider.countries.firstWhere(
                                      (country) => country.id == newDropdownValue,
                                  orElse: () => provider.countries.first, // Selección predeterminada si no encuentra ninguna coincidencia
                                );
                                getLocations();
                              } else {
                                // Si se selecciona 'Seleccionar un país', puedes limpiar la lista de localizaciones o manejarlo según tus necesidades
                                countryLocations.clear();
                              }
                            });
                          },
                          items: [
                            const DropdownMenuItem<int?>(
                              value: null,
                              child: Text('Seleccionar un país'), // Opción predeterminada
                            ),
                            ...provider.countries.map((Country country) {
                              return DropdownMenuItem<int>(
                                value: country.id,
                                child: Text(country.name),
                              );
                            }),
                          ],
                        ),


                        const SizedBox(height: 10),

                        /// SearchBar
                        /// Este searcBar muestra una lista de localizaciones del país seleccionado donde el usuario puede seleccionar las localizaciones de la ruta
                        /// Por defecto, muestra las localizaciones del primer país de la lista

                        RouteSearchBar(
                          locations: countryLocations,
                          selectedLocations: selectedLocations,
                          onSelectionChanged: (List<int> selectedLocations) {
                            setState(() {
                              this.selectedLocations = selectedLocations;
                            });
                            print(
                                'Selected Locations in CreateRoute: $selectedLocations');
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
