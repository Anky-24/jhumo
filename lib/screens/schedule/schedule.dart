import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jhumo/models/show_model.dart';
import 'package:jhumo/screens/contact/contact_service.dart';
import 'package:jhumo/utils/constants/colors.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Show>>(
      stream: FirebaseFirestore.instance
          .collection("schedule")
          .orderBy('id')
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((doc) => Show.fromJson(doc.data())).toList(),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              "An error occured",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          );
        } else if (snapshot.hasData) {
          final List<Show> user = snapshot.data!;
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Schedule for the Week",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.length,
                    itemBuilder: (context, idx) => Container(
                          decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () => launchInBrowser(user[idx].rjUrl),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    'https://firebasestorage.googleapis.com/v0/b/jhumo-radio.appspot.com/o/rjs%2F${user[idx].rjName.toLowerCase()}.jpg?alt=media'),
                              ),
                              title: Text(
                                "${user[idx].name} with ${user[idx].type.toUpperCase()} ${user[idx].rjName}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              subtitle: Text(
                                "${user[idx].days} at ${user[idx].timing}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                        )),
              ),
            ],
          );
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