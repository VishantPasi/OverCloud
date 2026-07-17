import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_arc_speed_dial/flutter_speed_dial_menu_button.dart';
import 'package:flutter_arc_speed_dial/main_menu_floating_action_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';
import 'package:overcloud/firebase/firestore_create_operations.dart';
import 'package:overcloud/services/download_file_service.dart';
import 'package:overcloud/utils/create_folder_bottomsheet.dart';
import 'package:overcloud/utils/format_date_time.dart';
import 'package:overcloud/utils/pick_one_file.dart';
import 'package:overcloud/utils/show_pop_over.dart';

class FoldersPage extends StatefulWidget {
  final String folderName;
  final String folderId;
  final String parentId;
  final String currentPath;

  const FoldersPage({
    super.key,
    required this.folderName,
    required this.folderId,
    required this.parentId,
    required this.currentPath
  });

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid = _auth.currentUser!.uid;

  final ValueNotifier<int> _fileCount = ValueNotifier<int>(0);

  // final ValueNotifier<bool> _isShowDial = ValueNotifier(false);
  bool _isShowDial = false;
  bool _showFab = false;

  final PickOneFile _pickOneFile = PickOneFile();
  final ShowPopOver _popOver = ShowPopOver();
  final FirestoreCreateOperations _create = FirestoreCreateOperations();
  // @override
  // void initState() {

  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await Future.delayed(const Duration(milliseconds: 250));

  //     if (!mounted) return;

  //     setState(() {
  //       _showFab = true;
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 15, 15, 1),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.folderName,
                style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2),

              ValueListenableBuilder<int>(
                valueListenable: _fileCount,
                builder: (context, itemCount, child) {
                  return Text(
                    "$itemCount items",
                    style: GoogleFonts.urbanist(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 14,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ],
        foregroundColor: Colors.white.withValues(alpha: 0.6),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "ALL FILES",
                      style: GoogleFonts.urbanist(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3,
                      ),
                    ),
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
                  ],
                ),

                SizedBox(height: 20),

                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: _firestore.getFilesMetaDataList(
                    uid,
                    widget.folderId,
                    widget.parentId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
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
                            "No Files Found",
                            style: GoogleFonts.urbanist(
                              color: Colors.white38,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }

                    final files = snapshot.data!.docs;

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _fileCount.value = files.length;
                    });

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final Map<String, String> fileIcons = {
                          "pdf": "pdf.svg",
                          "xls": "xlsx.svg",
                          "xlsx": "xlsx.svg",
                          "doc": "docx.svg",
                          "docx": "docx.svg",
                          "ppt": "pptx.svg",
                          "pptx": "pptx.svg",
                          "txt": "txt.svg",
                          "csv": "csv.svg",
                          "zip": "zip.svg",
                          "rar": "zip.svg",
                          "7z": "zip.svg",
                          "mp3": "audio.svg",
                          "wav": "audio.svg",
                          "mp4": "video.svg",
                          "mkv": "video.svg",
                          "jpg": "img.svg",
                          "jpeg": "img.svg",
                          "png": "img.svg",
                          "gif": "img.svg",
                          "webp": "img.svg",
                        };

                        String fileType = files[index]
                            .data()['type']
                            .toString()
                            .toLowerCase();
                        String icon = fileIcons[fileType] ?? "unknown.svg";

                        return fileStructure(
                          context,
                          files[index].data()["id"],
                          files[index].data()['parentId'],
                          icon,
                          files[index]['name'],
                          files[index].data()['type'],

                          files[index].data()['type'] != "folder"
                              ? files[index].data()['size']
                              : 0,
                          files[index].data()['isStarred'],
                          // files[index].data()['isTrashed'],
                          formatDateTime(files[index].data()['modifiedOn']),
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
      floatingActionButton: _getFloatingActionButton(widget.folderId)
          
    );
  }

  Widget _getFloatingActionButton(String folderId) {
    return SpeedDialMenuButton(
      mainFABPosX: 5,
      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial,
      updateSpeedDialStatus: (isShow) {
        setState(() {
          _isShowDial = isShow;
        });
      },
      isEnableAnimation: true,

      //general init
      isMainFABMini: false,
      mainMenuFloatingActionButton: MainMenuFloatingActionButton(
        mini: false,
        child: FaIcon(FontAwesomeIcons.plus, size: 18, color: Colors.white),
        backgroundColor: Colors.deepOrange,
        heroTag: "main_fab",
        onPressed: () {},
        shape: CircleBorder(),
        closeMenuChild: Icon(Icons.close),
        closeMenuForegroundColor: Colors.deepOrange,
        closeMenuBackgroundColor: Colors.white,
      ),
      floatingActionButtonWidgetChildren: <FloatingActionButton>[
        FloatingActionButton(
          shape: CircleBorder(),
          mini: false,
          heroTag: "file_upload",
          onPressed: () async {
            PlatformFile? file = await _pickOneFile.pickFile(folderId);

            String path = "this is path ${widget.parentId!}/$folderId";

            print(path);

            if (file != null) {
              _create.createFile(
                uid,
                widget.parentId,
                file.name,
                file.extension!,
                file.size,
                context,
              );

              // _firestore.createFileMetaData(
              //   uid,
              //   widget.folderId,
              //   file.name,
              //   file.extension,
              //   file.size,
              //   path,
              //   file,
              //   false,
              // );
            }

            setState(() {
              _isShowDial = false;
            });
          },
          backgroundColor: Colors.deepOrange,
          child: FaIcon(FontAwesomeIcons.fileArrowUp, color: Colors.white),
        ),
        FloatingActionButton(
          shape: CircleBorder(),
          mini: false,
          heroTag: "camera",
          onPressed: () {},
          backgroundColor: Colors.deepOrange,
          child: FaIcon(FontAwesomeIcons.cameraRetro, color: Colors.white),
        ),
        FloatingActionButton(
          heroTag: "newFolder",
          onPressed: () async {
            // PlatformFile? file = await _pickOneFile.pickFile("photos");

            // if (file != null) {
            //   _firestore.createFileMetaData(
            //     uid,
            //     widget.folderId,
            //     file.name,
            //     file.extension,
            //     file.size,
            //     "path",
            //     file,
            //     false,
            //   );
            // }
            createFolderBottomSheet(context, uid, widget.parentId, widget.currentPath);
            setState(() {
              _isShowDial = false;
            });
          },
          backgroundColor: Colors.deepOrange,
          shape: CircleBorder(),
          child: const FaIcon(FontAwesomeIcons.folderPlus, color: Colors.white),
        ),
      ],
      isSpeedDialFABsMini: false,
      paddingBtwSpeedDialButton: 20.0,
    );
  }

  Widget fileStructure(
    BuildContext context,
    String id,
    String parentId,
    String icon,
    String name,
    String type,
    int size,
    bool isStarred,
    String modifiedOn,
  ) {
    // if (filetype == "Folder" ){

    // }
    return GestureDetector(
      onTap: () async {
        if (type == "folder") {
          setState(() {
            _isShowDial = false;
          });

          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  FoldersPage(folderName: name, folderId: id, parentId: id, currentPath: "${widget.currentPath}/$name",),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );

          print("fdsfds ${widget.currentPath}/$name");
        } else {
          await DownloadService.downloadFile(
            uid: uid,
            folderId: widget.folderId,
            fileId: "$id.$type",
            fileName: name,
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    type != "folder"
                        ? SvgPicture.asset("assets/icons/$icon", height: 40)
                        : FaIcon(
                            FontAwesomeIcons.solidFolder,
                            color: const Color.fromRGBO(255, 196, 87, 1),
                            size: 30,
                          ),
                    SizedBox(width: 15),
                    SizedBox(
                      width: 215,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            modifiedOn,
                            style: GoogleFonts.urbanist(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
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
                            _popOver.popOverFoldersPage2(
                              buttonContext,
                              context,
                              uid,
                              id,
                              type,
                              // name,
                              // type,
                              // size,
                              // "path",
                              // widget.folderId,
                              // false,
                              isStarred,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.white.withValues(alpha: 0.1),
              height: 2,
              thickness: 2,
            ),
          ],
        ),
      ),
    );
  }
}
