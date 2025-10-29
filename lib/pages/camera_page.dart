import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraPage extends StatefulWidget {
  final Function updatePhoto;

  const CameraPage({
    super.key,
    required this.updatePhoto,
  });

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras!.first, ResolutionPreset.medium);
    await _controller!.initialize();
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    if (!_controller!.value.isInitialized) return;
    final image = await _controller!.takePicture();
    widget.updatePhoto(image.path);
    Navigator.pop(context);
    print('📸 Foto salva em: ${image.path}');
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          // Fundo preto para preencher a tela
          Container(color: Colors.black),

          // Centraliza a câmera verticalmente
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9, // 90% da largura
              height: MediaQuery.of(context).size.height * 0.6, // 60% da altura
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CameraPreview(_controller!),
              ),
            ),
          ),

          // Botão fixo no rodapé centralizado
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 25,
                children: [
                  FloatingActionButton(
                    onPressed: () => {
                      Navigator.pop(context)
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                  FloatingActionButton(
                    onPressed: _takePicture,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.camera_alt, color: Colors.black, size: 30),
                  ),
                  FloatingActionButton(
                    onPressed: _takePicture,
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.photo, color: Colors.black),
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
