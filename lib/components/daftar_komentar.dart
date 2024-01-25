import 'package:flutter/material.dart';
import 'package:lapor_workshop/components/styles.dart';
import 'package:lapor_workshop/models/komentars.dart';

class DaftarKomentar extends StatelessWidget {
  final List<Komentars> listComentar;
  const DaftarKomentar({
    super.key,
    required this.listComentar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "List Komentar",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        ...listComentar.map((e) => KomentarItem(komentar: e)).toList(),
        const SizedBox(
          height: 64,
        ),
      ],
    );
  }
}

class KomentarItem extends StatelessWidget {
  final Komentars komentar;
  const KomentarItem({
    super.key,
    required this.komentar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: successColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              komentar.user,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              komentar.text,
            ),
          ],
        ),
      ),
    );
  }
}
