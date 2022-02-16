import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:wheretoeat/data.dart';

import '../controller.dart';

class DetailPage extends StatelessWidget {
  final Place place;
  final String heroName;
  const DetailPage({Key? key, required this.place, required this.heroName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoritController favoritController = Get.put(FavoritController());
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  decoration: const BoxDecoration(
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                )
              ],
              leading: IconButton(
                onPressed: () {
                  if (favoritController.favPlace.contains(place)) {
                    favoritController.favPlace.remove(place);
                  } else {
                    favoritController.favPlace.add(place);
                  }
                },
                icon: Obx(
                  () => Icon(
                    Icons.favorite,
                    size: 40,
                    color: favoritController.favPlace.contains(place)
                        ? Colors.red
                        : Colors.white,
                  ),
                ),
              ),
              leadingWidth: 80,
              backgroundColor: Colors.white,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [StretchMode.zoomBackground],
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Container(
                    color: Colors.black12,
                    child: Hero(
                      tag:
                          '$heroName${place.latitude.toString()}${place.longitude.toString()}',
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: place.image.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place.title.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.orange,
                        ),
                        Icon(
                          Icons.star,
                          size: 20,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      place.caption.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
