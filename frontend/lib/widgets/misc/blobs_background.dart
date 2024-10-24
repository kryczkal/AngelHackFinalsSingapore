import 'package:flutter/material.dart';
import 'package:frontend/widgets/misc/blob.dart';

class BlobsBackground extends StatelessWidget {
  const BlobsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top-left blobs
        Positioned(
          top: 50,
          left: 20,
          child: Blob(
            width: 300,
            height: 300,
            color: Colors.blue.withOpacity(0.15),
          ),
        ),
        Positioned(
          top: 150,
          left: 100,
          child: Blob(
            width: 200,
            height: 200,
            color: Colors.green.withOpacity(0.1),
          ),
        ),
        Positioned(
          top: 250,
          left: 50,
          child: Blob(
            width: 250,
            height: 250,
            color: Colors.pink.withOpacity(0.2),
          ),
        ),

        // Top-right blobs
        Positioned(
          top: 50,
          right: 50,
          child: Blob(
            width: 180,
            height: 180,
            color: Colors.purple.withOpacity(0.15),
          ),
        ),
        Positioned(
          top: 200,
          right: 20,
          child: Blob(
            width: 250,
            height: 250,
            color: Colors.orange.withOpacity(0.12),
          ),
        ),
        Positioned(
          top: 300,
          right: 100,
          child: Blob(
            width: 220,
            height: 220,
            color: Colors.teal.withOpacity(0.2),
          ),
        ),

        // Center blobs
        Positioned(
          top: 400,
          left: 80,
          child: Blob(
            width: 400,
            height: 400,
            color: Colors.cyan.withOpacity(0.18),
          ),
        ),
        Positioned(
          top: 450,
          right: 150,
          child: Blob(
            width: 300,
            height: 300,
            color: Colors.red.withOpacity(0.1),
          ),
        ),
        Positioned(
          top: 600,
          left: 200,
          child: Blob(
            width: 350,
            height: 350,
            color: Colors.yellow.withOpacity(0.08),
          ),
        ),

        // Bottom-left blobs
        Positioned(
          bottom: 150,
          left: 20,
          child: Blob(
            width: 280,
            height: 280,
            color: Colors.lightBlue.withOpacity(0.1),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 150,
          child: Blob(
            width: 200,
            height: 200,
            color: Colors.lime.withOpacity(0.12),
          ),
        ),
        Positioned(
          bottom: 200,
          left: 100,
          child: Blob(
            width: 300,
            height: 300,
            color: Colors.indigo.withOpacity(0.18),
          ),
        ),

        // Bottom-right blobs
        Positioned(
          bottom: 100,
          right: 50,
          child: Blob(
            width: 250,
            height: 250,
            color: Colors.deepOrange.withOpacity(0.14),
          ),
        ),
        Positioned(
          bottom: 200,
          right: 150,
          child: Blob(
            width: 180,
            height: 180,
            color: Colors.amber.withOpacity(0.12),
          ),
        ),
        Positioned(
          bottom: 300,
          right: 80,
          child: Blob(
            width: 220,
            height: 220,
            color: Colors.deepPurple.withOpacity(0.15),
          ),
        ),

        // Center-left blobs
        Positioned(
          top: 500,
          left: 20,
          child: Blob(
            width: 350,
            height: 350,
            color: Colors.blueAccent.withOpacity(0.2),
          ),
        ),
        Positioned(
          top: 550,
          left: 100,
          child: Blob(
            width: 300,
            height: 300,
            color: Colors.pinkAccent.withOpacity(0.18),
          ),
        ),
        Positioned(
          top: 650,
          left: 50,
          child: Blob(
            width: 200,
            height: 200,
            color: Colors.greenAccent.withOpacity(0.1),
          ),
        ),

        // Center-right blobs
        Positioned(
          top: 450,
          right: 50,
          child: Blob(
            width: 250,
            height: 250,
            color: Colors.orangeAccent.withOpacity(0.12),
          ),
        ),
        Positioned(
          top: 600,
          right: 100,
          child: Blob(
            width: 300,
            height: 300,
            color: Colors.cyanAccent.withOpacity(0.1),
          ),
        ),
        Positioned(
          top: 700,
          right: 150,
          child: Blob(
            width: 180,
            height: 180,
            color: Colors.redAccent.withOpacity(0.15),
          ),
        ),

        // Scattered blobs
        Positioned(
          top: 100,
          left: 200,
          child: Blob(
            width: 150,
            height: 150,
            color: Colors.tealAccent.withOpacity(0.12),
          ),
        ),
        Positioned(
          top: 300,
          left: 250,
          child: Blob(
            width: 100,
            height: 100,
            color: Colors.blue.withOpacity(0.14),
          ),
        ),
        Positioned(
          bottom: 150,
          right: 250,
          child: Blob(
            width: 200,
            height: 200,
            color: Colors.purple.withOpacity(0.1),
          ),
        ),
        Positioned(
          bottom: 300,
          right: 300,
          child: Blob(
            width: 180,
            height: 180,
            color: Colors.pink.withOpacity(0.08),
          ),
        ),
        Positioned(
          bottom: 100,
          right: 20,
          child: Blob(
            width: 220,
            height: 220,
            color: Colors.green.withOpacity(0.1),
          ),
        ),
        Positioned(
          top: 50,
          left: 300,
          child: Blob(
            width: 250,
            height: 250,
            color: Colors.amberAccent.withOpacity(0.15),
          ),
        ),
      ],
    );
  }
}
