import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overcloud/firebase/firebase_firestore_service.dart';
import 'package:overcloud/utils/format_date_time.dart';
import 'package:overcloud/utils/show_pop_over.dart';

class RecentFilesPage extends StatefulWidget {
  const RecentFilesPage({super.key});

  @override
  State<RecentFilesPage> createState() => _RecentFilesPageState();
}

class _RecentFilesPageState extends State<RecentFilesPage> {
  final FirebaseFirestoreService _firestore = FirebaseFirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String uid = _auth.currentUser!.uid;

  final ValueNotifier<int> _fileCount = ValueNotifier<int>(0);

  final ShowPopOver _popOver = ShowPopOver();

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
                "Today's Recent Files",
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
                  stream: _firestore.getRecentFilesMetaDataList(uid),
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
                            .data()['fileType']
                            .toString()
                            .toLowerCase();
                        String fileTypeLogo =
                            fileIcons[fileType] ?? "unknown.svg";

                        print(files[index].reference.path);
                        return fileStructure(
                          context,
                          files[index]['folderId'],
                          files[index]['fileId'],
                          files[index]['fileName'],
                          formatDateTime(files[index].data()['modifiedOn']),
                          files[index].data()['fileType'],
                          files[index].data()['fileSize'],
                          files[index].data()['path'],
                          fileTypeLogo,
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

  Widget fileStructure(
    BuildContext context,
    String folderId,
    String fileId,
    String fileName,
    String date,
    String filetype,
    int fileSize,
    String path,
    String fileTypeLogo,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icons/$fileTypeLogo", height: 40),
                  SizedBox(width: 15),
                  SizedBox(
                    width: 230,
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
                        SizedBox(height: 2),
                        Text(
                          date,
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
              Builder(
                builder: (buttonContext) {
                  return IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.ellipsisVertical,
                      color: Colors.white70,
                      size: 18,
                    ),

                    onPressed: () {
                      _popOver.popOverRecentFilesPage(
                        buttonContext,
                        context,

                        uid!,
                        folderId,
                        fileId,
                        fileName,
                        filetype,
                        fileSize,
                        path,
                        "homeContent",
                        false,
                      );
                    },
                  );
                },
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
    );
  }
}
