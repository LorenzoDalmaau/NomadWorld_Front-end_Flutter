import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
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
  late NomadProvider provider;
  late bool isLoading;
  late Country dropdownValue;

  TextEditingController nameRouteController = TextEditingController();
  List<LocationData> countryLocations = [];

  @override
  void initState() {
    super.initState();
    _loadCountries();
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
  }


  @override
  Widget build(BuildContext context) {
    provider = Provider.of<NomadProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
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
          : ListView(
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

                      const dropdown_menu_title(),

                      /// Dropdown Menu
                      DropdownButton<int>(
                        value: dropdownValue.id,
                        onChanged: (int? newDropdownValue) {
                          setState(() {
                            dropdownValue = provider.countries.firstWhere(
                                (country) => country.id == newDropdownValue);

                            getLocations();
                          });
                        },
                        items: provider.countries.map((Country country) {
                          return DropdownMenuItem<int>(
                            value: country.id,
                            child: Text(country.name),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 30),

                      /// SearchBar
                      const RouteSearchBar(),

                      /// Btn confirmation
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF195F47),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              textStyle: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              elevation: 20,
                            ),
                            child: const Text(
                              'Agregar localización',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
