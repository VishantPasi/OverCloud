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
import 'package:overcloud/utils/convert_file_size.dart';
import 'package:overcloud/utils/format_date_time.dart';
import 'package:overcloud/utils/pick_one_file.dart';

class FoldersPage extends StatefulWidget {
  final String folderName;
  final String folderId;
  const FoldersPage({
    super.key,
    required this.folderName,
    required this.folderId,
  });

  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid = _auth.currentUser!.uid;

  int fileCount = 0;

  final ValueNotifier<bool> _isShowDial = ValueNotifier(false);

  PickOneFile pickOneFile = PickOneFile();
  ConvertFileSize convertFileSize = ConvertFileSize();

  

  @override
  Widget build(BuildContext context) {
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
              Text(
                "${fileCount.toString()} items",
                style: GoogleFonts.urbanist(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
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

      body: SafeArea(
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
                stream: _firestore.getFolderFiles(uid, widget.folderId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No Files Found"));
                  }

                  final files = snapshot.data!.docs;

                  String fileTypeLogo = "unknown_icon.svg";
                  

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: files.length,
                    itemBuilder: (context, index) {

                      if (files.isNotEmpty){
                    if (files[index].data()['fileType'] == "pdf"){
                      fileTypeLogo = "pdf.svg";
                    }
                    else if(files[index].data()['fileType'] == "xlsx"){
                      fileTypeLogo = "xlsx.svg";
                    }
                  }
                      return fileStructure(
                        files[index]['fileName'],

                        formatDateTime(files[index].data()['createdOn']),
                        files[index].data()['fileType'],
                        files[index].data()['fileSize'],
                        fileTypeLogo

                      );
                    },
                  );
                },
              ),
              // fileStructure("Work", "25 Oct 2022", "Excel", "2.4 MB"),
              // fileStructure("Work", "25 Oct 2022", "Excel", "2.4 MB"),
              // fileStructure("Work", "25 Oct 2022", "Excel", "2.4 MB"),
            ],
          ),
        ),
      ),
      floatingActionButton: _getFloatingActionButton(widget.folderId),
    );
  }

  Widget _getFloatingActionButton(String folderId) {
    return SpeedDialMenuButton(
      mainFABPosX: 5,
      //if needed to close the menu after clicking sub-FAB
      isShowSpeedDial: _isShowDial.value,
      updateSpeedDialStatus: (isShow) {
        //return any open or close change within the widget
        _isShowDial.value = isShow;
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
            PlatformFile? file = await pickOneFile.pickFile();

            if (file != null) {
              _firestore.createFileMetaData(
                uid,
                widget.folderId,
                file.name,
                file.extension,
                convertFileSize.fileSize(file.size),
              );
            }

            _isShowDial.value = false;
            setState(() {});
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
          shape: CircleBorder(),
          mini: false,
          heroTag: "create_folder",
          onPressed: () {
            //if no need to change the menu status
            _isShowDial.value = false;
          },
          backgroundColor: Colors.deepOrange,
          child: FaIcon(FontAwesomeIcons.folderPlus, color: Colors.white),
        ),
      ],
      isSpeedDialFABsMini: false,
      paddingBtwSpeedDialButton: 20.0,
    );
  }

  Widget fileStructure(
    String fileName,
    String date,
    String filetype,
    String size,
    String fileTypeLogo
  ) {
    // if (filetype == "Folder" ){

    // }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/icons_new/$fileTypeLogo",height: 50,),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "$date • $size",
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

              FaIcon(
                FontAwesomeIcons.ellipsisVertical,
                color: Colors.white70,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
