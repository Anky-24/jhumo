import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jhumo/utils/constants/colors.dart';

class Contest extends StatelessWidget {
  const Contest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ListResult>(
      future: FirebaseStorage.instance.ref('/contests/').listAll(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "An error occured",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        } else if (snapshot.hasData) {
          final List<Reference> contests = snapshot.data!.items;
          return Column(children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Active Contests",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            contests.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "No Active Contests for now",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: contests.length,
                      itemBuilder: (context, idx) => FutureBuilder<String>(
                          future: FirebaseStorage.instance
                              .ref(contests[idx].fullPath)
                              .getDownloadURL(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("An error Occured");
                            } else if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 300,
                                        fit: BoxFit.cover,
                                        imageUrl: snapshot.data!,
                                        progressIndicatorBuilder:
                                            (context, _, __) => const Center(
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
                                ),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: loaderL,
                                ),
                              );
                            }
                          }),
                    ),
                  ),
          ]);
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
