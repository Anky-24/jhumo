import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jhumo/screens/contact/contact_service.dart';
import 'package:jhumo/screens/contact/widgets/buttons.dart';
import 'package:jhumo/utils/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance
            .collection('base_info')
            .doc('contacts_info')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("An Error Occured"),
            );
          } else if (snapshot.hasData) {
            final Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "Need Help? Feel Free to Contact Us",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                IcnBtn(
                  icon: const FaIcon(FontAwesomeIcons.rectangleAd),
                  label: "Advertise with Us",
                  onTap: () => launchMail(data['mail']),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IcnBtn(
                        icon: const FaIcon(FontAwesomeIcons.instagram),
                        label: "Instagram",
                        onTap: () => launchInBrowser(data['instagram']),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: IcnBtn(
                        icon: const FaIcon(FontAwesomeIcons.facebook),
                        label: "Facebook",
                        onTap: () {
                          launchInBrowser(data['facebook']);
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IcnBtn(
                        icon: const FaIcon(FontAwesomeIcons.link),
                        label: "Website",
                        onTap: () {
                          launchInBrowser(data['website']);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: IcnBtn(
                        icon: const FaIcon(FontAwesomeIcons.phone),
                        label: "Call Us",
                        onTap: () => makePhoneCall(data['phone']),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: IcnBtn(
                        icon: const FaIcon(FontAwesomeIcons.twitter),
                        label: "Twitter",
                        onTap: () {
                          launchInBrowser(data['twitter']);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: IcnBtn(
                        icon: const FaIcon(FontAwesomeIcons.linkedin),
                        label: "LinkedIn",
                        onTap: () => launchInBrowser(data['linkedin']),
                      ),
                    )
                  ],
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
        });
  }
}
