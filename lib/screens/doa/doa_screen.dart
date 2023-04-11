import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/models/list_doa.dart';

class DoaScreen extends StatelessWidget {
  const DoaScreen({super.key});

  Future<List<ListDoa>> _getDoa() async {
    String data = await rootBundle.loadString("assets/data/doa.json");

    return listDoaFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    final namaDoa = ModalRoute.of(context)!.settings.arguments;
    return FutureBuilder<List<ListDoa>>(
      future: _getDoa(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: backgroundDark,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: backgroundDark,
            body: const Center(
                child: Text(
              "Data Not Found",
              style: TextStyle(color: Colors.white),
            )),
          );
        }
        var doa = snapshot.data!.firstWhere(
          (element) => element.judul == namaDoa,
        );

        return Scaffold(
          backgroundColor: backgroundDark,
          appBar: AppBar(
            backgroundColor: backgroundDark,
            elevation: 0,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      doa.judul,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      doa.arab,
                      style: GoogleFonts.amiri(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Latin : ${doa.latin}",
                      style: GoogleFonts.poppins(
                          color: text,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Terjemahan : ${doa.arti}",
                      style: GoogleFonts.poppins(
                          color: text,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Catatan : ${doa.footnote}",
                      style: GoogleFonts.poppins(
                          color: text,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Tags : ${doa.tag}",
                      style: GoogleFonts.poppins(
                          color: text,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
