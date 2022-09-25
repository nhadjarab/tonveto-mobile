import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tonveto/config/theme.dart';
import 'package:tonveto/models/medical_report_model.dart';

class MedicalRecordsScreen extends StatelessWidget {
  final List<MedicalReport> records;
  const MedicalRecordsScreen({Key? key, required this.records})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          "Les rapports médicaux",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: AppTheme.mainColor,
        foregroundColor: Colors.black,
      ),
      backgroundColor: AppTheme.secondaryColor,
      body: SafeArea(
        child: ListView.builder(
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4.0,
                )
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rapport médical #${index + 1}",
                    style: const TextStyle(
                        color: AppTheme.mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: AppTheme.divider),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Reason",
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: TextStyle(
                            color: AppTheme.mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(record.reason ?? "")
                    ],
                  ),
                  const SizedBox(height: AppTheme.divider),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Diagnosis",
                        style: TextStyle(
                            color: AppTheme.mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        record.diagnosis ?? "",
                      )
                    ],
                  ),
                  const SizedBox(height: AppTheme.divider),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Treatment",
                        style: TextStyle(
                            color: AppTheme.mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(record.treatment ?? ""),
                    ],
                  ),
                  const SizedBox(height: AppTheme.divider),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Notes",
                        style: TextStyle(
                            color: AppTheme.mainColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(record.notes ?? "")
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
