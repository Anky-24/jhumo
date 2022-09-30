import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class AdBaner extends StatelessWidget {
  const AdBaner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListResult>(
      future: FirebaseStorage.instance.ref('/advertisements/').listAll(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "An error occured",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        } else if (snapshot.hasData) {
          final List<Reference> ads = snapshot.data!.items;
          return ads.isNotEmpty
              ? CarouselSlider.builder(
                  itemCount: ads.length,
                  itemBuilder: (context, idx, _) => FutureBuilder<String>(
                      future: FirebaseStorage.instance
                          .ref(ads[idx].fullPath)
                          .getDownloadURL(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Text("An error Occured");
                        } else if (snapshot.hasData) {
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  width: MediaQuery.of(context).size.width,
                                  height: 300,
                                  fit: BoxFit.fill,
                                  imageUrl: snapshot.data!,
                                  progressIndicatorBuilder: (context, _, __) =>
                                      const Center(
                                    child: CircularProgressIndicator(
                                      color: loaderL,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black12,
                                ),
                              )
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: loaderL,
                            ),
                          );
                        }
                      }),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.width / 5,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: ads.length == 1 ? false : true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                )
              : const Text("");
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: loaderL,
            ),
          );
        }
      },
    );
  }
}
