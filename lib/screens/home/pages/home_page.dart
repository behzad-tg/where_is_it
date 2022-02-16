// ignore_for_file: must_call_super

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wheretoeat/animation/up_to_down_fade.dart';
import 'package:wheretoeat/const.dart';
import 'package:wheretoeat/data.dart';
import 'package:wheretoeat/screens/home/controller.dart';
import 'package:wheretoeat/screens/home/pages/detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    HomeMapController homeMapController = Get.put(HomeMapController());
    FavoritController favoritController = Get.put(FavoritController());
    return Stack(
      children: [
        Obx(
          () => homeMapController.isloading.value
              ? const Positioned.fill(
                  child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                ))
              : GoogleMap(
                  onMapCreated: (GoogleMapController ctrl) async {
                    homeMapController.controller = ctrl;
                    Location location = Location();
                    homeMapController.locationData =
                        await location.getLocation();
                    homeMapController.controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(
                            homeMapController.locationData.latitude as double,
                            homeMapController.locationData.longitude as double,
                          ),
                          zoom: 17,
                        ),
                      ),
                    );
                  },
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 0,
                  ),
                  // circles: homeMapController.circles,
                  markers: homeMapController.markers,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  onTap: (value) {
                    // print(value.latitude);
                    // print(value.longitude);
                  },
                ),
        ),
        Positioned(
          bottom: 120,
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Obx(() => homeMapController.isloading.value
                  ? Container()
                  : (homeMapController.markers.isNotEmpty
                      ? CarouselSlider(
                          items: places.map(
                            (obj) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                        place: obj,
                                        heroName: 'carouselSliderHero',
                                      ),
                                    ),
                                  );
                                },
                                child: UpToDownFade(
                                  delay: (0 +
                                      (int.parse(obj.id.toString()) * 0.1)),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        margin: const EdgeInsets.all(6),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 6,
                                            )
                                          ],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          child: Wrap(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    color: Colors.black12,
                                                    height: 150,
                                                    width: double.infinity,
                                                    child: Hero(
                                                      tag:
                                                          'carouselSliderHero${obj.latitude.toString()}${obj.longitude.toString()}',
                                                      child: FadeInImage
                                                          .memoryNetwork(
                                                        placeholder:
                                                            kTransparentImage,
                                                        image: obj.image
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 5,
                                                      horizontal: 20,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          obj.title.toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Row(
                                                          children: const [
                                                            Icon(
                                                              Icons.star,
                                                              size: 20,
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              size: 20,
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              size: 20,
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                            Icon(
                                                              Icons.star,
                                                              size: 20,
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Row(
                                                          children:
                                                              obj.category!
                                                                  .map(
                                                                    (e) =>
                                                                        Container(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      margin: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              5),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: primaryLightBlue
                                                                            .withOpacity(0.5),
                                                                        borderRadius:
                                                                            const BorderRadius.all(
                                                                          Radius.circular(
                                                                              50),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        e.title
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          color: Color.fromRGBO(
                                                                              80,
                                                                              120,
                                                                              200,
                                                                              1),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                  .toList(),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 5,
                                        right: 5,
                                        child: IconButton(
                                          onPressed: () {
                                            if (favoritController.favPlace
                                                .contains(obj)) {
                                              favoritController.favPlace
                                                  .remove(obj);
                                            } else {
                                              favoritController.favPlace
                                                  .add(obj);
                                            }
                                          },
                                          icon: Obx(
                                            () => Icon(
                                              Icons.favorite,
                                              size: 30,
                                              color: favoritController.favPlace
                                                      .contains(obj)
                                                  ? Colors.red
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                          options: CarouselOptions(
                            height: 260,
                            viewportFraction: 0.6,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.height,
                            scrollDirection: Axis.horizontal,
                          ),
                        )
                      : Container()))),
        ),
        Positioned.fill(
          top: 30,
          child: UpToDownFade(
            delay: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Obx(
                () => AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 200,
                  height: homeMapController.dropDownBtn.value ? 230 : 0,
                  padding:
                      const EdgeInsets.only(right: 20, top: 40, bottom: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [primaryLightBlue, primaryBlue],
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Wrap(
                    children: categorys
                        .map(
                          (e) => homeMapController.dropDownBtn.value
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: InkWell(
                                    onTap: () {
                                      homeMapController.dropDownSelected.value =
                                          e.title.toString();
                                      homeMapController.dropDownBtn.value =
                                          false;
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          e.title.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: 30,
          child: UpToDownFade(
            delay: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () {
                  homeMapController.dropDownBtn.value =
                      !homeMapController.dropDownBtn.value;
                },
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [primaryLightBlue, primaryBlue],
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 5),
                        blurRadius: 6,
                        color: Colors.black26,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => Text(
                          homeMapController.dropDownSelected.value,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
