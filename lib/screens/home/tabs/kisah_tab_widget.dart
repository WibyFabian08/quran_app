import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/models/kisah_nabi.dart';
import 'package:islamic_app/screens/nabi/nabi_screen.dart';

class KisahView extends StatelessWidget {
  const KisahView({super.key});

  Future<List<KisahNabi>> _getListKisah() async {
    String data = await rootBundle.loadString("assets/data/kisahNabi.json");
    return kisahNabiFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getListKisah(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(
              child: Text(
            "Data Not Found",
            style: TextStyle(color: Colors.white),
          ));
        }

        return ListView.separated(
            itemBuilder: (context, index) {
              return kisahItem(
                  kisah: snapshot.data!.elementAt(index), context: context);
            },
            separatorBuilder: (context, index) {
              return Divider(color: const Color(0xFF7B80AD).withOpacity(.35));
            },
            itemCount: snapshot.data!.length);
      },
    );
  }
}

Widget kisahItem({required KisahNabi kisah, required BuildContext context}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          settings: RouteSettings(
            arguments: kisah.name
          ),
          builder:(context) => const NabiScreen(),)
      );
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text("${kisah.name} - ${kisah.usia} Tahun ",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,)),
  );
}
