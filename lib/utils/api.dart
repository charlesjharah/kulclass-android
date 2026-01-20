abstract class Api {
  static const baseUrl = "https://admin.auraapp.site/"; // Ex :- http://182.168.19.35:5000/
  static const secretKey = "5TIvw5cpc0"; // Ex :- ssf45sd1fs5d1sdf1s56165s15sdf1s
  static const folderStructurePath = "auralive"; // Ex :- TestApp

  // >>>>> >>>>> File Upload Api <<<<< <<<<<

  static const uploadFile = "${baseUrl}client/file/upload-file";
  static const uploadMultipleFile = "${baseUrl}client/file/upload_multiple_files";

  // >>>>> >>>>> Folder Structure <<<<< <<<<<
  static const profileContent = "${folderStructurePath}/client/userImage";
  static const chatContent = "${folderStructurePath}/client/chatContent";
  static const postContent = "${folderStructurePath}/client/postImage";
  static const videoImageContent = "${folderStructurePath}/client/videoImage";
  static const videoUrlContent = "${folderStructurePath}/client/videoUrl";
  static const complaintContent = "${folderStructurePath}/client/complaintImage";
  static const verificationContent = "${folderStructurePath}/client/verificationContent";
  static const storyContent = "${folderStructurePath}/client/storyContent";

  // >>>>> >>>>> Admin Setting Api <<<<< <<<<<

  static const adminSetting = "${baseUrl}client/setting/getSetting";

  static const googleAdSetting = "${baseUrl}client/setting/fetchAdSetting"; // *** >>> Google Ad Code <<< ***

  // >>>>> >>>>> Login Page Api <<<<< <<<<<

  static const checkUserExit = "${baseUrl}client/user/checkUser";
  static const checkUserNameExit = "${baseUrl}client/user/validateUsername";
  static const login = "${baseUrl}client/user/loginOrSignUp";

  // >>>>> >>>>> Login User Profile Api <<<<< <<<<<

  static const loginUserProfile = "${baseUrl}client/user/getProfile";

  // >>>>> >>>>> Upload Reels Page Api <<<<< <<<<<

  static const uploadReels = "${baseUrl}client/video/uploadvideo";
  static const editReels = "${baseUrl}client/video/updateVideoByUser";

  // >>>>> >>>>> Hash Tag Page Api <<<<< <<<<<

  static const hashTagBottomSheet = "${baseUrl}client/hashTag/hashtagDrop";
  static const fetchHashTagVideo = "${baseUrl}client/hashTag/videosOfHashTag";
  static const fetchHashTagPost = "${baseUrl}client/hashTag/postsOfHashTag";
  static const createHashTag = "${baseUrl}client/hashTag/createHashTag";

  // >>>>> >>>>> Profile Page Api <<<<< <<<<<

  static const profile = "${baseUrl}client/user/getUserProfile";
  static const profileVideo = "${baseUrl}client/video/videosOfUser";
  static const profilePost = "${baseUrl}client/post/postsOfUser";
  static const profileCollection = "${baseUrl}client/user/receviedGiftByUser";

  static const editProfile = "${baseUrl}client/user/update";

  static const audioWiseVideos = "${baseUrl}client/video/fetchVideosOfParticularSong";

  // >>>>> >>>>> Reels Page Api <<<<< <<<<<

  static const fetchReels = "${baseUrl}client/video/getAllVideos";
  static const reelsLikeDislike = "${baseUrl}client/video/likeOrDislikeOfVideo";
  static const videoShare = "${baseUrl}client/video/shareCountOfVideo";
  static const fetchAllSound = "${baseUrl}client/song/getSongsByUser";
  static const fetchFavoriteSound = "${baseUrl}client/song/getFavoriteSongs";
  static const favoriteUnFavorite = "${baseUrl}client/song/favoriteSongByUser";
  static const searchSound = "${baseUrl}client/song/searchSongs";

  // >>>>> >>>>> Post Page Api <<<<< <<<<<

  static const post = "${baseUrl}client/post/getAllPosts";
  static const postLikeDislike = "${baseUrl}client/post/likeOrDislikeOfPost";
  static const postShare = "${baseUrl}client/post/shareCountOfPost";

  // >>>>> >>>>> Upload Post Page Api <<<<< <<<<<

  static const uploadPost = "${baseUrl}client/post/uploadPost";
  static const editPost = "${baseUrl}client/post/updatePostByUser";

  // >>>>> >>>>> Connection Page Api <<<<< <<<<<


  static const followUnfollowOld = "${baseUrl}client/followerFollowing/followUnfollowUser";
  static const followUnfollow = "${baseUrl}client/followerFollowing/follow";

  static const connection = "${baseUrl}client/followerFollowing/followerFollowingList";

  // >>>>> >>>>> Search Page Api <<<<< <<<<<

  static const searchUser = "${baseUrl}client/searchHistory/searchUsers";
  static const searchHashTag = "${baseUrl}client/searchHistory/searchHashTag";

  // >>>>> >>>>> Comment Api <<<<< <<<<<

  static const createComment = "${baseUrl}client/postOrvideoComment/commentOfPostOrVideo";
  static const fetchComment = "${baseUrl}client/postOrvideoComment/getpostOrvideoComments";

  // >>>>> >>>>> Report Api <<<<< <<<<<

  static const fetchReport = "${baseUrl}client/report/getReportReason";
  static const createReport = "${baseUrl}client/report/reportByUser";

  // >>>>> >>>>> Gift Api <<<<< <<<<<

  static const fetchGift = "${baseUrl}client/gift/getGiftsForUser";
  static const sendGift = "${baseUrl}client/gift/sendGiftByUser";
  static const sendGiftToLive = "${baseUrl}client/gift/sendGiftTolive";

  // >>>>> >>>>> Live Api <<<<< <<<<<

  static const createLiveUser = "${baseUrl}client/liveUser/live";
  static const fetchLiveUser = "${baseUrl}client/liveUser/getliveUserList";
  static const fetchLiveUserListForPk = "${baseUrl}client/liveUser/fetchPkInvitations";

  // >>>>> >>>>> Message Page Api <<<<< <<<<<

  static const messageUser = "${baseUrl}client/chatTopic/getChatList";
  static const searchMessageUser = "${baseUrl}client/chatTopic/chatWithUserSearch";

  // >>>>> >>>>> Message Request Page Api <<<<< <<<<<

  static const fetchMessageRequest = "${baseUrl}client/chatRequest/getMessageRequestThumb";
  static const fetchRequestUserChat = "${baseUrl}client/chatRequest/getOldMessageRequest";
  static const messageRequestAction = "${baseUrl}client/chatRequest/handleMessageRequest";
  static const deleteAllMessageRequest = "${baseUrl}client/chatRequest/deleteMessageRequest";

  // >>>>> >>>>> Chat Page Api <<<<< <<<<<

  static const fetchUserChat = "${baseUrl}client/chat/getOldChat";
  static const sendFile = "${baseUrl}client/chat/createChat";

  // >>>>> >>>>> Help Page Api <<<<< <<<<<

  static const help = "${baseUrl}client/complaint/complaintByUser";

  // >>>>> >>>>> Verification Request Page Api <<<<< <<<<<

  static const createVerificationRequest = "${baseUrl}client/verificationRequest/verificationRequestByUser";

  // >>>>> >>>>> Coin Related Api <<<<< <<<<<

  static const fetchCoinPlan = "${baseUrl}client/coinplan/getCoinplan";
  static const fetchBanner = "${baseUrl}client/banner/getBanner";
  static const fetchWithdrawMethod = "${baseUrl}client/withdraw/get";
  static const createWithdrawRequest = "${baseUrl}client/withdrawRequest/createWithdrawRequest";
  static const fetchCoinHistory = "${baseUrl}client/history/historyOfUser";
  static const createCoinPlanHistory = "${baseUrl}client/coinplan/createHistory";

  // >>>>> >>>>> Fetch Coin Api <<<<< <<<<<

  static const fetchUserCoin = "${baseUrl}client/user/getUserCoin";

  // >>>>> >>>>> Delete User Api <<<<< <<<<<

  static const deleteUser = "${baseUrl}client/user/deleteUserAccount";
  static const deletePost = "${baseUrl}client/post/deleteParticularPost";
  static const deleteReels = "${baseUrl}client/video/deleteParticularVideo";

  static const deleteContent = "${baseUrl}client/file/deleteContent";

// >>>>> >>>>> STORY API <<<<< <<<<<

  static const fetchOwnStory = "${baseUrl}client/story/getOwnStories";

  static const fetchReaction = "${baseUrl}client/reaction/retrieveReaction";

  static const viewStory = "${baseUrl}client/story/viewStory";
  static const deleteStory = "${baseUrl}client/story/deleteStory";
  static const fetchStories = "${baseUrl}client/story/getFollowedUserStories";
  static const uploadStory = "${baseUrl}client/story/uploadStory";
  static const reactionToStory = "${baseUrl}client/story/reactToStory";
  static const replyToStory = "${baseUrl}client/story/replyToStory";
  static const fetchStoryViewers = "${baseUrl}client/storyView/getStoryViewers";

  // >>>>> >>>>> AI CAPTION API <<<<< <<<<<
  static const generateAiCaption = "${baseUrl}client/user/generateMediaTags";

  static const fetchImages = "${baseUrl}client/setting/listProfilePhotos";
}
