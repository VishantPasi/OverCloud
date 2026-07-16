import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';
import 'package:overcloud/screens/folders_page.dart';
import 'package:overcloud/utils/create_folder_bottomsheet.dart';
import 'package:overcloud/utils/format_date_time.dart';
import 'package:overcloud/utils/format_file_count.dart';
import 'package:overcloud/utils/show_pop_over.dart';

class FilesContent extends StatefulWidget {
  final NotchBottomBarController? controller;

  const FilesContent({super.key, this.controller});

  @override
  State<FilesContent> createState() => _FilesContentState();
}

class _FilesContentState extends State<FilesContent> {
  String? videosTotalCount;
  String? documentsTotalCount;
  String? musicTotalCount;
  String? photosTotalCount;
  final ValueNotifier<int> _tabIndexIconButton = ValueNotifier(0);

  final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid = _auth.currentUser!.uid;
  final FormatFileCount _fileCount = FormatFileCount();

  ShowPopOver popOver = ShowPopOver();

  @override
  void initState() {
    // _firestore.createFile(uid, "3cg4crwncLfUhcoDvn22", "TESTING", "Text", "3.5");
    // // _firestore.getFolderList(uid).asStream();
    // _firestore.createFolder(uid, "Custom Folder6");
    // _firestore.getOverallMetadata(uid,"video");
    // _firestore.updateOverallMetadata(uid, "video", 3, "45 gb");

    getTotalCount("videos");
    getTotalCount("music");
    getTotalCount("documents");
    getTotalCount("photos");

    super.initState();
  }

  Future<void> getTotalCount(String fileType) async {
    final totalCount = await _firestore.getOverallMetadata(uid, fileType);

    switch (fileType) {
      case "videos":
        videosTotalCount = _fileCount.fileCount(
          totalCount!.data()['totalCount'],
        );
        setState(() {});
        break;
      case "music":
        musicTotalCount = _fileCount.fileCount(
          totalCount!.data()['totalCount'],
        );
        setState(() {});
        break;
      case "documents":
        documentsTotalCount = _fileCount.fileCount(
          totalCount!.data()['totalCount'],
        );
        setState(() {});
        break;
      case "photos":
        photosTotalCount = _fileCount.fileCount(
          totalCount!.data()['totalCount'],
        );
        setState(() {});
        break;

      default:
        videosTotalCount = "0";
        musicTotalCount = "0";
        documentsTotalCount = "0";
        photosTotalCount = "0";
        setState(() {});
        break;
    }
  }

  List<DataTab> get _listIconTabToggle => [
    DataTab(icon: Icons.grid_view_rounded),
    DataTab(icon: Icons.menu_rounded),
  ];

  Widget _iconButton() => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ValueListenableBuilder(
        valueListenable: _tabIndexIconButton,
        builder: (context, currentIndex, _) => FlutterToggleTab(
          height: 32,
          width: 17,
          borderRadius: 8,

          selectedIndex: currentIndex,
          selectedTextStyle: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 8,
            fontWeight: FontWeight.w600,
          ),
          unSelectedTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          selectedBackgroundColors: [Colors.white.withValues(alpha: 0.1)],
          unSelectedBackgroundColors: [Colors.white.withValues(alpha: 0.05)],
          dataTabs: _listIconTabToggle,
          iconSize: 20,

          selectedLabelIndex: (index) {
            setState(() {
              _tabIndexIconButton.value = index;
            });
            return _tabIndexIconButton.value = index;
          },
        ),
      ),
    ],
  );

  Widget initialsAvatar() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 23,
          backgroundColor: Colors.deepOrange,
          child: Text(
            "VP",
            style: GoogleFonts.robotoMono(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            height: 12,
            width: 12,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromRGBO(15, 15, 15, 1),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: Color.fromRGBO(15, 15, 15, 1),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Cloud",
                      style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    initialsAvatar(),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(40, 40, 40, 1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 0.5,
                          ),
                        ),
                        child: TextField(
                          style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          decoration: InputDecoration(
                            isDense: true,

                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                            hintText: "Search your files, folders...",
                            hintStyle: GoogleFonts.urbanist(
                              color: Colors.white38,
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white38,
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,

                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(40, 40, 40, 1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                          width: 0.5,
                        ),
                      ),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color: Colors.white70,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "QUICK ACCESS",
                      style: GoogleFonts.urbanist(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3,
                      ),
                    ),
                    _iconButton(),
                  ],
                ),
                //1.5 for 2 and 3 for 1
                SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: _tabIndexIconButton.value == 0 ? 2 : 1,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: _tabIndexIconButton.value == 0 ? 1.5 : 4.75,
                  physics: NeverScrollableScrollPhysics(),
                  children: _tabIndexIconButton.value == 0
                      ? [
                          gridContainerForCountTwo(
                            FontAwesomeIcons.photoFilm,
                            "Photos",
                            "${photosTotalCount ?? 0} items",
                            "photos",
                          ),

                          gridContainerForCountTwo(
                            FontAwesomeIcons.solidFileLines,
                            "Documents",
                            "${documentsTotalCount ?? 0} items",
                            "documents",
                          ),
                          gridContainerForCountTwo(
                            FontAwesomeIcons.clapperboard,
                            "Videos",
                            "${videosTotalCount ?? 0} items",
                            "videos",
                          ),
                          gridContainerForCountTwo(
                            FontAwesomeIcons.music,
                            "Music",
                            "${musicTotalCount ?? 0} items",
                            "music",
                          ),
                        ]
                      : [
                          gridContainerForCountOne(
                            FontAwesomeIcons.photoFilm,
                            "Photos",
                            "${photosTotalCount ?? 0} items",
                            "photos",
                          ),

                          gridContainerForCountOne(
                            FontAwesomeIcons.solidFileLines,
                            "Documents",
                            "${documentsTotalCount ?? 0} items",
                            "documents",
                          ),
                          gridContainerForCountOne(
                            FontAwesomeIcons.clapperboard,
                            "Videos",
                            "${videosTotalCount ?? 0} items",
                            "videos",
                          ),
                          gridContainerForCountOne(
                            FontAwesomeIcons.music,
                            "Music",
                            "${musicTotalCount ?? 0} items",
                            "music",
                          ),
                        ],
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "FOLDERS",
                      style: GoogleFonts.urbanist(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,

                          decoration: BoxDecoration(
                            color: Colors.white10,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: FaIcon(
                              FontAwesomeIcons.sliders,
                              color: Colors.white70,
                              size: 18,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => createFolderBottomSheet(context, uid, ""),
                          child: Container(
                            width: 35,
                            height: 35,

                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 10),

                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _firestore.getFolderList(uid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }

                    if (!snapshot.hasData ||
                        snapshot.data!.docs.isEmpty ||
                        snapshot.data!.docs.length <= 6) {
                      return Container(
                        height: 150,
                        width: size.width,
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(25, 25, 25, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.05),
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "No Folders",
                            style: GoogleFonts.urbanist(
                              color: Colors.white38,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }

                    final excludedFolders = [
                      "photos",
                      "documents",
                      "videos",
                      "music",
                      "starred",
                      "private",
                    ];

                    final folders = snapshot.data!.docs.where((doc) {
                      return !excludedFolders.contains(doc.data()['name']);
                    }).toList();

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: folders.length,
                      itemBuilder: (context, index) {
                        return folderStructure(
                          folders[index].data()['id'],
                          

                          folders[index].data()['name'],
                          formatDateTime(
                            folders[index].data()['modifiedOn'],
                          ).toString(),

                          folders[index].data()['isStarred'],

                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget folderStructure(String id, String name, String date, bool isStarred) {
    return GestureDetector(
      onTap: () {

        // print("parentId: $parentId");
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FoldersPage(folderName: name, folderId: id, parentId: id),
        ),
      );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.solidFolder,
                        color: const Color.fromRGBO(255, 196, 87, 1),
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              name,
                              style: GoogleFonts.urbanist(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            date,
                            style: GoogleFonts.urbanist(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      isStarred
                          ? FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: const Color.fromRGBO(255, 170, 60, 1),
                              size: 15,
                            )
                          : SizedBox(),
                      Builder(
                        builder: (buttonContext) {
                          return IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.ellipsisVertical,
                              color: Colors.white70,
                              size: 18,
                            ),

                            onPressed: () {
                              popOver.popOverFilesContent(
                                buttonContext,
                                context,
                                uid,
                                id,
                                name,
                                "path",
                                "currentFolderId",
                                true,
                                isStarred,
                              );
                            },
                          );
                        },

                        // _firestore.deleteFileMetaData(uid, widget.folderId, fileId);
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 2,
            thickness: 2,
          ),
        ],
      ),
    );
  }

  Widget gridContainerForCountOne(
    FaIconData icon,
    String title,
    String subTitle,
    String folderId,
 
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FoldersPage(folderName: title, folderId: folderId, parentId: "",),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(45, 45, 45, 0.95),
              Color.fromRGBO(25, 25, 25, 0.95),
            ],
          ),
        ),
        child: Padding(
          padding: title == "Documents"
              ? const EdgeInsets.only(left: 20, top: 15, bottom: 15, right: 15)
              : const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(icon, color: Colors.deepOrange, size: 30),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.urbanist(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        subTitle,
                        style: GoogleFonts.urbanist(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              FaIcon(
                FontAwesomeIcons.chevronRight,
                color: Colors.white30,
                size: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget gridContainerForCountTwo(
    FaIconData icon,
    String title,
    String subTitle,
    String folderId,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FoldersPage(folderName: title, folderId: folderId, parentId: "",),
          ),
        );
      },

      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(45, 45, 45, 0.95),
              Color.fromRGBO(25, 25, 25, 0.95),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FaIcon(icon, color: Colors.deepOrange, size: 23),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.white30,
                    size: 14,
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                title,
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3),
              Text(
                subTitle,
                style: GoogleFonts.urbanist(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
