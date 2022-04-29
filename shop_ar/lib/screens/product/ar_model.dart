
import 'dart:io';

import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_archive/flutter_archive.dart';

class ARModel extends StatefulWidget {
  @override
  _ARModel createState() => _ARModel();
}

class _ARModel extends State<ARModel> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  //String localObjectReference;
  ARNode? localObjectNode;
  //String webObjectReference;
  ARNode? webObjectNode;
  ARNode? fileSystemNode;
  HttpClient? httpClient;

  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  @override
  void dispose() {
    super.dispose();
    arSessionManager?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ShopAR'),
        ),
        body: Container(
            child: Stack(children: [
              ARView(
                onARViewCreated: onARViewCreated,
                planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
              ),
            ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager?.onInitialize(
      showFeaturePoints: false,
      showPlanes: false,
      customPlaneTexturePath: "Images/triangle.png",
      showWorldOrigin: false,
      handleTaps: false,
      handlePans: true,
      handleRotation: true,
    );
    this.arObjectManager?.onInitialize();

    this.arSessionManager?.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager?.onNodeTap = onNodeTapped;
    this.arObjectManager?.onPanStart = onPanStarted;
    this.arObjectManager?.onPanChange = onPanChanged;
    this.arObjectManager?.onPanEnd = onPanEnded;
    this.arObjectManager?.onRotationStart = onRotationStarted;
    this.arObjectManager?.onRotationChange = onRotationChanged;
    this.arObjectManager?.onRotationEnd = onRotationEnded;

    //Download model to file system
    httpClient = new HttpClient();
    _downloadFile(
        "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/glTF-Binary/SheenChair.glb",
        "uploads-files-2727732-Japanese+Floor+Lamp.glb");
    onWebObjectAtOriginButtonPressed();
    // Alternative to use type fileSystemAppFolderGLTF2:
    //_downloadAndUnpack(
    //    "https://drive.google.com/uc?export=download&id=1fng7yiK0DIR0uem7XkV2nlPSGH9PysUs",
    //    "Chicken_01.zip");
  }

  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient?.getUrl(Uri.parse(url));
    var response = await request?.close();
    var bytes = await consolidateHttpClientResponseBytes(response!);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    print("Downloading finished, path: " + '$dir/$filename');
    return file;
  }

  Future<void> _downloadAndUnpack(String url, String filename) async {
    var request = await httpClient?.getUrl(Uri.parse(url));
    var response = await request?.close();
    var bytes = await consolidateHttpClientResponseBytes(response!);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    print("Downloading finished, path: " + '$dir/$filename');

    // To print all files in the directory: print(Directory(dir).listSync());
    try {
      await ZipFile.extractToDirectory(
          zipFile: File('$dir/$filename'), destinationDir: Directory(dir));
      print("Unzipping successful");
    } catch (e) {
      print("Unzipping failed: ");
    }
  }

  Future<void> onWebObjectAtOriginButtonPressed() async {
    if (this.webObjectNode != null) {
      this.arObjectManager?.removeNode(this.webObjectNode!);
      this.webObjectNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
          "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/glTF-Binary/SheenChair.glb",
          position: Vector3(0.0, -1.0, -1.0),
          scale: Vector3(50.2, 50.2, 100.2));
      bool? didAddWebNode = await this.arObjectManager?.addNode(newNode);
      this.webObjectNode = (didAddWebNode!) ? newNode : null;
    }
  }

  Future<void> onNodeTapped(List<String> nodes) async {
    var number = nodes.length;
    this.arSessionManager?.onError("Tapped $number node(s)");
  }

  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
            (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null) {
      var newAnchor =
      ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await this.arAnchorManager?.addAnchor(newAnchor);
      if (didAddAnchor != null) {
        this.anchors.add(newAnchor);
        // Add note to anchor
        var newNode = ARNode(
            type: NodeType.webGLB,
            uri:
            "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/SheenChair/glTF-Binary/SheenChair.glb",
            scale: Vector3(50.2, 50.2, 50.2),
            position: Vector3(0.0, 0.0, 0.0),
            rotation: Vector4(1.0, 0.0, 0.0, 0.0));
        bool? didAddNodeToAnchor =
        await this.arObjectManager?.addNode(newNode, planeAnchor: newAnchor);
        if (didAddNodeToAnchor != null) {
          this.nodes.add(newNode);
        } else {
          this.arSessionManager?.onError("Adding Node to Anchor failed");
        }
      } else {
        this.arSessionManager?.onError("Adding Anchor failed");
      }
/*
      // To add a node to the tapped position without creating an anchor, use the following code (Please mind: the function onRemoveEverything has to be adapted accordingly!):
      var newNode = ARNode(
          type: NodeType.localGLTF2,
          uri: "Models/Chicken_01/Chicken_01.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          transformation: singleHitTestResult.worldTransform);
      bool? didAddWebNode = await this.arObjectManager?.addNode(newNode);
      if (didAddWebNode != null) {
        this.nodes.add(newNode);
      }*/
    }
  }

  onPanStarted(String nodeName) {
    print("Started panning node " + nodeName);
  }

  onPanChanged(String nodeName) {
    print("Continued panning node " + nodeName);
  }

  onPanEnded(String nodeName, Matrix4 newTransform) {
    print("Ended panning node " + nodeName);
    final pannedNode =
    this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //pannedNode.transform = newTransform;
  }

  onRotationStarted(String nodeName) {
    print("Started rotating node " + nodeName);
  }

  onRotationChanged(String nodeName) {
    print("Continued rotating node " + nodeName);
  }

  onRotationEnded(String nodeName, Matrix4 newTransform) {
    print("Ended rotating node " + nodeName);
    final rotatedNode =
    this.nodes.firstWhere((element) => element.name == nodeName);

    /*
    * Uncomment the following command if you want to keep the transformations of the Flutter representations of the nodes up to date
    * (e.g. if you intend to share the nodes through the cloud)
    */
    //rotatedNode.transform = newTransform;
  }
}
