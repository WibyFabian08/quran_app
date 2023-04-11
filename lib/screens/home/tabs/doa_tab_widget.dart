import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamic_app/models/list_doa.dart';
import 'package:islamic_app/screens/doa/doa_screen.dart';

class DoaView extends StatelessWidget {
  const DoaView({super.key});

  Future<List<ListDoa>> _getListDoa() async {
    String data = await rootBundle.loadString("assets/data/doa.json");
    return listDoaFromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getListDoa(),
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
              return doaItem(
                  doa: snapshot.data!.elementAt(index), context: context);
            },
            separatorBuilder: (context, index) {
              return Divider(color: const Color(0xFF7B80AD).withOpacity(.35));
            },
            itemCount: snapshot.data!.length);
      },
    );
  }
}

Widget doaItem({required ListDoa doa, required BuildContext context}) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          settings: RouteSettings(
            arguments: doa.judul
          ),
          builder:(context) => const DoaScreen(),)
      );
    },
    child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(doa.judul,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,)),
  );
}
