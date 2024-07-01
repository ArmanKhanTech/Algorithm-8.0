import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:algorithm/model/team_model.dart';
import 'package:algorithm/screen/web.dart';
import 'package:algorithm/utility/constants.dart';

class DetailsScreen extends StatefulWidget {
  final TeamModel team;

  const DetailsScreen({Key? key, required this.team}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<void> _launchUrl(url) async {
    // ignore: no_leading_underscores_for_local_identifiers
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<dynamic> openImagePopup(String name, String role) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(role,
              style: const TextStyle(color: Colors.white, fontSize: 25)),
          icon: const Icon(Icons.image, color: Constants.orange, size: 30),
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Constants.orange,
              width: .5,
            ),
          ),
          content: SizedBox(
            height: 300,
            width: 300,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    role == 'Team Lead'
                        ? widget.team.imageLead!
                        : role == 'Team Member 2'
                            ? widget.team.imageMember2!
                            : widget.team.imageMember3!,
                    fit: BoxFit.contain,
                    width: 250,
                    height: 250,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Constants.orange),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    color: Constants.orange,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close',
                  style: TextStyle(color: Colors.red, fontSize: 20)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Team Details",
            style: TextStyle(
              fontSize: 25,
              color: Color(0xFFEA580C),
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            iconSize: 30,
          ),
          surfaceTintColor: Colors.black,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 10,
          ),
          children: [
            Text(
              widget.team.teamName!,
              style: const TextStyle(
                color: Constants.orange,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Constants.orange, width: .5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                        child: Text('Member 1 (Lead)',
                            style:
                                TextStyle(fontSize: 20, color: Colors.white))),
                    const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                    ListTile(
                      title: const Text('Full Name',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      subtitle: Text(widget.team.nameLead!,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                      leading: const Icon(
                        Icons.person,
                        color: Constants.orange,
                      ),
                    ),
                    ListTile(
                      title: const Text('Email',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      subtitle: Text(widget.team.emailLead!,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                      leading: const Icon(
                        Icons.email,
                        color: Constants.orange,
                      ),
                      onTap: () => {
                        launchUrl(
                            Uri.parse('mailto:${widget.team.emailMember2}'))
                      },
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Constants.orange, size: 20),
                    ),
                    ListTile(
                      title: const Text('Contact No.',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      subtitle: Text(widget.team.contactLead!,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                      leading: const Icon(
                        Icons.phone,
                        color: Constants.orange,
                      ),
                      onTap: () => {
                        launchUrl(Uri.parse('tel:${widget.team.contactLead}'))
                      },
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Constants.orange, size: 20),
                    ),
                    ListTile(
                      title: const Text('Resume',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      subtitle: Text(widget.team.resumeLead!,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                      leading: const Icon(
                        Icons.file_copy,
                        color: Constants.orange,
                      ),
                      onTap: () => {_launchUrl(widget.team.resumeLead!)},
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Constants.orange, size: 20),
                    ),
                    ListTile(
                      title: const Text('Image',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      subtitle: Text(widget.team.imageLead!,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                      leading: const Icon(
                        Icons.image,
                        color: Constants.orange,
                      ),
                      onTap: () => {
                        if (mounted)
                          {
                            openImagePopup(
                              widget.team.nameLead!,
                              "Team Lead",
                            )
                          }
                      },
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Constants.orange, size: 20),
                    ),
                    ListTile(
                      title: const Text('GitHub Profile',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      subtitle: Text(widget.team.githubLead!,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                      leading: const Icon(
                        Icons.link,
                        color: Constants.orange,
                      ),
                      onTap: () => {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => WebScreen(
                              url: widget.team.githubLead!,
                            ),
                          ),
                        )
                      },
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Constants.orange, size: 20),
                    ),
                    ListTile(
                      title: const Text('LinkedIn Profile',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      subtitle: Text(widget.team.linkedinLead!,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white)),
                      leading: const Icon(
                        Icons.link,
                        color: Constants.orange,
                      ),
                      onTap: () => {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => WebScreen(
                              url: widget.team.linkedinLead!,
                            ),
                          ),
                        )
                      },
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Constants.orange, size: 20),
                    ),
                    ListTile(
                        title: const Text('College Name',
                            style:
                                TextStyle(fontSize: 18, color: Colors.white)),
                        subtitle: Text(widget.team.collegeLead!,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white)),
                        leading: const Icon(
                          Icons.school,
                          color: Constants.orange,
                        )),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            widget.team.nameMember2 != null
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.orange, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                              child: Text('Member 2',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))),
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Full Name',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.nameMember2!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.person,
                              color: Constants.orange,
                            ),
                          ),
                          ListTile(
                            title: const Text('Email',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.emailMember2!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.email,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              launchUrl(Uri.parse(
                                  'mailto:${widget.team.emailMember2}'))
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                            title: const Text('Contact No.',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.contactMember2!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.phone,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              launchUrl(
                                  Uri.parse('tel:${widget.team.contactLead}'))
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                            title: const Text('Resume',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.resumeMember2!,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.file_copy,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WebScreen(
                                    url: widget.team.resumeMember2!,
                                  ),
                                ),
                              )
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                            title: const Text('Image',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.imageMember2!,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.image,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              if (mounted)
                                {
                                  openImagePopup(
                                    widget.team.nameMember2!,
                                    "Team Member 2",
                                  )
                                }
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                            title: const Text('GitHub Profile',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.githubMember2!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.link,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WebScreen(
                                    url: widget.team.githubMember2!,
                                  ),
                                ),
                              )
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                            title: const Text('LinkedIn Profile',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.linkedinMember2!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.link,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WebScreen(
                                    url: widget.team.linkedinMember2!,
                                  ),
                                ),
                              )
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                              title: const Text('College Name',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              subtitle: Text(widget.team.collegeMember2!,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              leading: const Icon(
                                Icons.school,
                                color: Constants.orange,
                              ))
                        ]),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            ),
            widget.team.nameMember3 != null
                ? Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Constants.orange, width: .5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                              child: Text('Member 3',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))),
                          const Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                          ListTile(
                            title: const Text('Full Name',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.nameMember3!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.person,
                              color: Constants.orange,
                            ),
                          ),
                          ListTile(
                            title: const Text('Email',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.emailMember3!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.email,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              launchUrl(Uri.parse(
                                  'mailto:${widget.team.emailMember2}'))
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                              title: const Text('Contact No.',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              subtitle: Text(widget.team.contactMember3!,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              leading: const Icon(
                                Icons.phone,
                                color: Constants.orange,
                              ),
                              onTap: () => {
                                    launchUrl(Uri.parse(
                                        'tel:${widget.team.contactLead}'))
                                  },
                              trailing: const Icon(Icons.arrow_forward_ios,
                                  color: Constants.orange, size: 20)),
                          ListTile(
                            title: const Text('Resume',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.resumeMember3!,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.file_copy,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WebScreen(
                                    url: widget.team.resumeMember3!,
                                  ),
                                ),
                              )
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                            title: const Text('Image',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.imageMember3!,
                                maxLines: 2,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.image,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              if (mounted)
                                {
                                  openImagePopup(
                                    widget.team.nameMember3!,
                                    "Team Member 3",
                                  )
                                }
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                            title: const Text('GitHub Profile',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.githubMember3!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.link,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WebScreen(
                                    url: widget.team.githubMember3!,
                                  ),
                                ),
                              )
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                            title: const Text('LinkedIn Profile',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            subtitle: Text(widget.team.linkedinMember3!,
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white)),
                            leading: const Icon(
                              Icons.link,
                              color: Constants.orange,
                            ),
                            onTap: () => {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => WebScreen(
                                    url: widget.team.linkedinMember3!,
                                  ),
                                ),
                              )
                            },
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Constants.orange, size: 20),
                          ),
                          ListTile(
                              title: const Text('College Name',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              subtitle: Text(widget.team.collegeMember3!,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white)),
                              leading: const Icon(
                                Icons.school,
                                color: Constants.orange,
                              ))
                        ]),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}
