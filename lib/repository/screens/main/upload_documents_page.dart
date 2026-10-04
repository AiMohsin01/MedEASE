import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

// Local dashed rounded-rect painter to avoid dependency/API mismatch with dotted_border package
class DashedRRect extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double radius;
  final List<double> dashPattern;

  const DashedRRect({
    super.key,
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
    this.radius = 12.0,
    this.dashPattern = const [6, 3],
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRRectPainter(
        color: color,
        strokeWidth: strokeWidth,
        radius: radius,
        dashPattern: dashPattern,
      ),
      child: child,
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final List<double> dashPattern;

  _DashedRRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.radius,
    required this.dashPattern,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()..addRRect(rrect);
    final dashPath = _createDashedPath(path, dashPattern);
    canvas.drawPath(dashPath, paint);
  }

  Path _createDashedPath(Path source, List<double> dashArray) {
    final metrics = source.computeMetrics();
    final dashed = Path();
    for (final metric in metrics) {
      double distance = 0.0;
      int index = 0;
      while (distance < metric.length) {
        final len = dashArray[index % dashArray.length];
        final next = (distance + len).clamp(0.0, metric.length);
        if (index % 2 == 0) {
          dashed.addPath(metric.extractPath(distance, next), Offset.zero);
        }
        distance = next;
        index++;
      }
    }
    return dashed;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class UploadDocumentsPage extends StatefulWidget {
  const UploadDocumentsPage({super.key});

  @override
  State<UploadDocumentsPage> createState() => _UploadDocumentsPageState();
}

class _UploadDocumentsPageState extends State<UploadDocumentsPage> {
  String? _fileName;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F5),
      // The AppBar is now managed by BottomNavScreen
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("My Health Records", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 20),
            const Text("Recent Documents", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 15),
            _buildRecentDocuments(context),
            const SizedBox(height: 30),
            const Text("Upload New Document", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 15),
            _buildUploadArea(context),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Supported formats: PDF, JPEG, PNG. Max size: 10MB",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      // The bottom navigation is now managed by BottomNavScreen
    );
  }

  Widget _buildRecentDocuments(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildDocumentCard(context, "Lab_Results_03.2024.pdf", Icons.description_outlined),
        const SizedBox(width: 15),
        _buildDocumentCard(context, "Prescription_Dr.Lee.jpg", Icons.camera_alt_outlined),
      ],
    );
  }

  Widget _buildDocumentCard(BuildContext context, String fileName, IconData icon) {
    return Expanded(
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.grey.shade700, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      fileName,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF28A79F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.download_for_offline_outlined, color: Colors.white, size: 28),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadArea(BuildContext context) {
    return InkWell(
      onTap: _pickFile,
      child: DashedRRect(
        color: const Color(0xFF28A79F),
        strokeWidth: 2,
        dashPattern: const [8, 4],
        radius: 15,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40),
          decoration: BoxDecoration(
            color: const Color(0xFF28A79F).withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_outlined, color: const Color(0xFF28A79F), size: 50),
              const SizedBox(height: 15),
              Text(
                _fileName ?? "Tap to Upload Files", // Show file name or default text
                style: const TextStyle(color: Color(0xFF28A79F), fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
