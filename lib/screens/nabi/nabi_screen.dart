import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/constants/globals.dart';
import 'package:islamic_app/models/kisah_nabi.dart';

class NabiScreen extends StatelessWidget {
  const NabiScreen({super.key});

  Future<List<KisahNabi>> _getKisahNabi() async {
    String data = await rootBundle.loadString("assets/data/kisahNabi.json");

    return kisahNabiFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    final namaNabi = ModalRoute.of(context)!.settings.arguments;
    return FutureBuilder<List<KisahNabi>>(
      future: _getKisahNabi(),
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
          (element) => element.name == namaNabi,
        );

        return Scaffold(
          backgroundColor: backgroundDark,
          appBar: AppBar(
            backgroundColor: backgroundDark,
            elevation: 0,
          ),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doa.name,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Image.network(doa.imageUrl, fit: BoxFit.cover,),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Lahir Tahun : ${doa.thnKelahiran}",
                      style: GoogleFonts.poppins(
                          color: text,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Tempat : ${doa.tmp}",
                      style: GoogleFonts.poppins(
                          color: text,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Terjemahan : ${doa.description}",
                      style: GoogleFonts.poppins(
                          color: text,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 16,
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
