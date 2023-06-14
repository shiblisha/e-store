import 'package:e_store/Repository/modelclass/CategoryModel.dart';
import 'package:e_store/Ui/productpage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../Bloc/Category/category_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

late CategoryModel categorie;
String street = '';

class _HomePageState extends State<HomePage> {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location disabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission denied');
    }
    return await Geolocator.getCurrentPosition();
  }

  String locationMessage = '';
  Position? currentPosition;

  String long = '';
  String lat = '';

  Future<String> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];
      setState(() {
        street = place.street.toString() + "," + place.locality.toString();
      });

      print(
          "${place.street}, ${place.locality}, ${place.country},${place.subThoroughfare}");
      return "${place.street}, ${place.locality}";
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
    super.initState();
    getCurrentLocation().then((position) {
      setState(() {
        currentPosition = position;
        lat = currentPosition!.latitude.toString();
        long = currentPosition!.longitude.toString();
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    getAddressFromLatLng(currentPosition!);
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    final double itemHeight = mheight * 0.25;
    final double itemWidth = size.width / 2.5;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        actions: [
          Icon(
            Icons.location_on,
            color: Colors.white,
          )
        ],
        title: Text(
          street,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoryblocLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CategoryblocLoaded) {
                categorie =
                    BlocProvider.of<CategoryBloc>(context).categoryModel;

                return Expanded(
                  child: GridView.count(
                      childAspectRatio: (itemWidth / itemHeight),
                      padding: EdgeInsets.only(
                          top: mheight * 0.026,
                          left: mwidth * 0.02,
                          right: mwidth * 0.015),
                      crossAxisCount: 3,
                      mainAxisSpacing: mwidth * 0.05,
                      // Vertical spacing
                      crossAxisSpacing: mwidth * 0.05,
                      // Horizontal spacing

                      shrinkWrap: true,
                      children: List.generate(categorie.categories!.length,
                          growable: false, (index) {
                        return GestureDetector(
                          onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Product(categoryName: categorie.categories![index].characters.toString(),)));},
                          child: Card(
                            elevation: 2.2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              height: mheight * 0.2,
                              // Set the desired image height
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xff95BDC6).withOpacity(0.22),
                              ),
                              child: Center(child: Container(child: Text(categorie.categories![index].characters.toString())),)
                            ),
                          ),
                        );
                      })),
                );
              }

              if (state is CategoryblocError) {
                return Center(
                  child: Text("ERROR"),
                );
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    currentPosition = null;
    super.dispose();
  }
}
