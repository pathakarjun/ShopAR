
import 'dart:math' as math;
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class ARModel extends StatefulWidget {
  @override
  _ARModel createState() => _ARModel();
}

class _ARModel extends State<ARModel> {
  late ARKitController arkitController;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('TEST AR'),
      ),
      body: Container(
        child: ARKitSceneView(
          onARKitViewCreated: onARKitViewCreated,
          environmentTexturing:
          ARWorldTrackingConfigurationEnvironmentTexturing.automatic,
        ),
      ));

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    this.arkitController.add(_createSphere());
    this.arkitController.add(_createSphere1());
    this.arkitController.add(_createPlane());
    this.arkitController.add(_createText());
    this.arkitController.add(_createCylinder());
    this.arkitController.add(_createCone());
  }

  ARKitNode _createSphere() => ARKitNode(
    geometry:
    ARKitSphere(materials: _createRandomColorMaterial(), radius: 0.04),
    position: vector.Vector3(0.1, -0.1, -0.5),
  );

  ARKitNode _createSphere1() => ARKitNode(
    geometry:
    ARKitSphere(materials: _createRandomColorMaterial(), radius: 0.04),
    position: vector.Vector3(-1.05, -0.1, -0.5),
  );

  ARKitNode _createPlane() {
    final plane = ARKitPlane(
      width: 1,
      height: 1,
      materials: [
        ARKitMaterial(
          transparency: 0.5,
          diffuse: ARKitMaterialProperty.color(Colors.white),
        )
      ],
    );
    return ARKitNode(
      geometry: plane,
      position: vector.Vector3(0, 0, -1.5),
    );
  }

  ARKitNode _createText() {
    final text = ARKitText(
      text: 'ShopAR\nTest AR',
      extrusionDepth: 1,
      materials: [
        ARKitMaterial(
          diffuse: ARKitMaterialProperty.color(Colors.blue),
        )
      ],
    );
    return ARKitNode(
      geometry: text,
      position: vector.Vector3(-0.3, 0.3, -1.4),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );
  }

  ARKitNode _createCylinder() => ARKitNode(
    geometry: ARKitCylinder(
        radius: 0.03,
        height: 0.2,
        materials: _createRandomColorMaterial()),
    position: vector.Vector3(-0.01, 0.0, -0.5),
  );

  ARKitNode _createCone() => ARKitNode(
    geometry: ARKitCone(
        topRadius: 0,
        bottomRadius: 0.05,
        height: 0.09,
        materials: _createRandomColorMaterial()),
    position: vector.Vector3(-0.055, 0.13, -0.5),
  );

  final _rnd = math.Random();
  List<ARKitMaterial> _createRandomColorMaterial() {
    return [
      ARKitMaterial(
        lightingModelName: ARKitLightingModel.physicallyBased,
        metalness: ARKitMaterialProperty.value(_rnd.nextDouble()),
        roughness: ARKitMaterialProperty.value(_rnd.nextDouble()),
        diffuse: ARKitMaterialProperty.color(
          Color((_rnd.nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0),
        ),
      )
    ];
  }
}
