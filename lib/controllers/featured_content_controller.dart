import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeaturedContentController extends GetxController {
  RxString youtubeVideoUrl = "".obs;
  RxString youtubeVideoId = "".obs;
  RxString youtubeVideoTitle = "".obs;
  RxString youtubeVideoPostedOn = "".obs;

  Rxn<QuerySnapshot<Object?>> featuredContent = Rxn<QuerySnapshot<Object?>>();
  Rxn<YoutubePlayerController> youtubePlayerController =
      Rxn<YoutubePlayerController>();

  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedContent();
  }

  fetchFeaturedContent() async {
    String gymCode = authController.storedGymCode.value;

    CollectionReference featuredContentRef = FirebaseFirestore.instance
        .collection(gymCode)
        .doc('featured-content')
        .collection('featured-content');
    QuerySnapshot snapshot = await featuredContentRef.get();
    snapshot.docs.isNotEmpty
        ? print('Featured Content exists')
        : print('Does not exist');

    Map<String, dynamic> videoContent =
        snapshot.docs[0].data() as Map<String, dynamic>;

    youtubeVideoId.value = videoContent['uid'];
    youtubeVideoUrl.value = videoContent['url'];
    youtubeVideoTitle.value = videoContent['title'];
    youtubeVideoPostedOn.value = videoContent['PostedOn'];

    print(youtubeVideoId.value);
    print(youtubeVideoUrl.value);

    String? videoId = YoutubePlayer.convertUrlToId(youtubeVideoUrl.value);
    if (videoId != null) {
      youtubePlayerController.value = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          controlsVisibleAtStart: true,
          showLiveFullscreenButton: true,
          // hideControls: ,          
          startAt: 0,
        ),
      );
    }
  }
}
