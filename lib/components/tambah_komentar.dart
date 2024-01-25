import 'package:flutter/material.dart';
import 'package:lapor_workshop/pages/utils.dart';
import 'package:lapor_workshop/components/styles.dart';
import 'package:lapor_workshop/models/laporan.dart';

class TambahKomentar extends StatefulWidget {
  final Laporan laporan;
  final void Function()? onTambahSelesai;
  const TambahKomentar({
    super.key,
    required this.laporan,
    this.onTambahSelesai,
  });

  @override
  State<TambahKomentar> createState() => _TambahKomentarState();
}

class _TambahKomentarState extends State<TambahKomentar> {
  final controller = TextEditingController();
  bool loading = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> post() async {
    setState(() {
      loading = true;
    });

    try {
      await Utils.post(
        laporanId: widget.laporan.docId,
        komentar: controller.text,
      );
    } catch (e) {
      //
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext) {
              return AlertDialog(
                title: Text(widget.laporan.judul),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await post();

                        controller.text = '';
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        widget.onTambahSelesai?.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: warningColor,
                        foregroundColor: Colors.white,
                      ),
                      child: Center(
                        child: loading
                            ? const CircularProgressIndicator()
                            : const Text("Posting Komentar"),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      child: const Center(child: Text("Add Komentar")),
    );
  }
}
