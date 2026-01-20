import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auralive/ui/live_user_send_gift_bottom_sheet_ui.dart';
import 'package:auralive/pages/chat_page/model/fetch_user_chat_model.dart';
import 'package:auralive/utils/api.dart';
import 'package:auralive/utils/database.dart';
import 'package:auralive/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

io.Socket? socket;

class SocketServices {
  io.Socket? getSocket() => socket;

  // This is use to When the live user exits the streaming page, the viewing user exits automatically...
  static bool isLiveRunning = false;

  // This is use to how many users see the live user...
  static RxInt userWatchCount = 0.obs;

  // This is use to live user send comment...
  static RxList mainLiveComments = [].obs;

  // This is use to if get new message/comment then auto scroll down list...
  static ScrollController scrollController = ScrollController();

  // This is use to chat between two user...

  static List<Chat> userChats = [];
  static RxBool onChangeChats = false.obs; // This variable is used for Update only (true/false not matter)
  static String? lastVisitChatUserId;

  static Future<void> socketConnect() async {
    try {
      socket = io.io(
        Api.baseUrl,
        io.OptionBuilder().setTransports(['websocket']).setQuery({"globalRoom": "globalRoom:${Database.loginUserId}"}).build(),
      );

      socket!.connect();
      userWatchCount.value = 0;

      socket!.onConnect((data) {
        Utils.showLog("Socket Listen => Socket Connected : ${socket?.id}");
      });

      socket!.once(
        "connect",
        (data) {
          // >>>>> >>>>> >>>>> >>>>> Socket Listen Method <<<<< <<<<< <<<<< <<<<<

          socket!.on("liveRoomConnect", (liveRoomConnectData) {
            Utils.showLog("Socket Listen => Live Room Connect : $liveRoomConnectData");
          });

          socket!.on(
            "endLive",
            (endLive) {
              userWatchCount.value = 0;
              Utils.showLog("Socket Listen => Live Room Disconnect : $endLive");
              if (isLiveRunning) {
                isLiveRunning = false;
                Get.back();
              }
            },
          );

          socket!.on("addView", (addView) {
            userWatchCount.value = addView;
            Utils.showLog("Socket Listen => Add View : $addView");
          });

          socket!.on("lessView", (lessView) {
            userWatchCount.value = lessView;
            Utils.showLog("Socket Listen => Less View : $lessView");
          });

          socket!.on(
            "gift",
            (gift) async {
              Utils.showLog("Socket Listen => Add New Gift : $gift");
              Utils.showLog("Socket Listen => Add New Gift 222222  : ${gift["giftData"]}");

              onGetNewGift(gift: gift);
            },
          );

          socket!.on(
            "liveChat",
            (liveChat) async {
              Utils.showLog("Socket Listen => Add New Comment : $liveChat");
              final Map response = jsonDecode(liveChat);
              onGetNewComment(message: response);
            },
          );

          socket!.on("messageRequest", (messageRequest) {
            Utils.showLog("Socket Listen => Get New Message Request : ${messageRequest}");

            if (messageRequest["messageId"] != null) {
              Utils.showLog("Socket Listen => Get New Message Id : ${messageRequest["messageId"]}");
            }

            final Map response = jsonDecode(messageRequest["data"]);

            // If User Send Message(Text) Then Get Message Id In Outside Of message["data"] else Send Image/Audio Then Get Message Id In message["data"]

            // if ((response["messageType"] == 2 || response["messageType"] == 3) && response["messageId"] != null) {
            //   onReadMessage(senderUserId: response["senderUserId"], messageId: response["messageId"]);
            // } else if (messageRequest["messageId"] != null) {
            //   onReadMessage(senderUserId: response["senderUserId"], messageId: messageRequest["messageId"]);
            // }

            onGetNewMessage(message: response);
          });

          socket!.on("message", (message) {
            Utils.showLog("Socket Listen => Get New Message : ${message}");

            if (message["messageId"] != null) {
              Utils.showLog("Socket Listen => Get New Message Id : ${message["messageId"]}");
            }

            final Map response = jsonDecode(message["data"]);

            // If User Send Message(Text) Then Get Message Id In Outside Of message["data"] else Send Image/Audio Then Get Message Id In message["data"]

            if ((response["messageType"] == 2 || response["messageType"] == 3) && response["messageId"] != null) {
              onReadMessage(senderUserId: response["senderUserId"], messageId: response["messageId"]);
            } else if (message["messageId"] != null) {
              onReadMessage(senderUserId: response["senderUserId"], messageId: message["messageId"]);
            }

            onGetNewMessage(message: response);
            // try {
            //   final bottomBarController = Get.find<BottomBarController>();
            //   if (bottomBarController.selectedTabIndex == 3) {
            //     // Call Only User Current On Message Page..
            //     if (Get.isRegistered<MessageController>()) {
            //       final messageController = Get.find<MessageController>();
            //       messageController.init();
            //     } else {
            //       final messageController = Get.put(MessageController());
            //       messageController.init();
            //     }
            //   }
            // } catch (e) {
            //   Utils.showLog("Get New Message Listen Error => $e");
            // }
          });

          socket!.on(
            "messageRead",
            (messageRead) async {
              Utils.showLog("Socket Listen => New Message Read : $messageRead");
            },
          );
        },
      );

      socket!.on("error", (error) {
        Utils.showLog("Socket Listen => Socket Error : $error");
      });

      socket!.on("connect_error", (error) {
        Utils.showLog("Socket Listen => Socket Connection Error : $error");
      });

      socket!.on("connect_timeout", (timeout) {
        Utils.showLog("Socket Listen => Socket Connection Timeout : $timeout");
      });

      socket!.on("disconnect", (reason) {
        Utils.showLog("Socket Listen => Socket Disconnected : $reason");
      });

      Utils.showLog("Socket Listen => Socket Connected : ${socket?.connected}");
    } catch (e) {
      Utils.showLog("Socket Listen => Socket Connection Error: $e");
    }
  }

  // >>>>> >>>>> >>>>> >>>>> Socket Emit Method <<<<< <<<<< <<<<< <<<<<

  static Future<void> onLiveRoomConnect({required String loginUserId, required String liveHistoryId}) async {
    final sellerData = jsonEncode({"userId": loginUserId, "liveHistoryId": liveHistoryId});

    if (socket != null && socket!.connected) {
      socket?.emit("liveRoomConnect", sellerData);
      Utils.showLog("Socket Emit => Live Room Connected.");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLiveRoomExit({required String liveHistoryId, required bool isHost}) async {
    if (isHost) {
      final endLive = jsonEncode({"liveHistoryId": liveHistoryId});
      if (socket != null && socket!.connected) {
        socket?.emit("endLive", endLive);
        Utils.showLog("Socket Emit => Live Room Disconnected.");
      } else {
        Utils.showLog("Socket Not Connected !!");
      }
    }
  }

  static Future<void> onAddView({required String loginUserId, required String liveHistoryId}) async {
    isLiveRunning = true;

    final userData = jsonEncode({"userId": loginUserId, "liveHistoryId": liveHistoryId});

    if (socket != null && socket!.connected) {
      socket?.emit("addView", userData);
      Utils.showLog("Socket Emit => New User Join Live Room");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLessView({required String loginUserId, required String liveHistoryId}) async {
    final userData = jsonEncode({"userId": loginUserId, "liveHistoryId": liveHistoryId});

    if (socket != null && socket!.connected) {
      socket?.emit("lessView", userData);
      Utils.showLog("Socket Emit => User Exit Live Room");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLiveChat({
    required String loginUserId,
    required String liveHistoryId,
    required String userName,
    required String userImage,
    required String commentText,
  }) async {
    final liveChat = jsonEncode(
      {
        "userName": userName,
        "userImage": userImage,
        "commentText": commentText,
        "userId": loginUserId,
        "liveHistoryId": liveHistoryId,
      },
    );

    if (socket != null && socket!.connected) {
      socket!.emit("liveChat", liveChat);
      Utils.showLog("Socket Emit => User Add New Comment");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onLiveSendGift({
    required int coin,
    required int giftType,
    required String giftUrl,
    required String giftId,
    required String senderUserId,
    required String receiverUserId,
    required String liveHistoryId,
  }) async {
    final gift = jsonEncode(
      {
        "giftUrl": giftUrl,
        "giftType": giftType,
        "coin": coin,
        "giftId": giftId,
        "senderUserId": senderUserId,
        "receiverUserId": receiverUserId,
        "liveHistoryId": liveHistoryId,
      },
    );

    if (socket != null && socket!.connected) {
      socket!.emit("gift", gift);
      Utils.showLog("Socket Emit => User Send Gift");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onSendMessage({
    required String senderUserId,
    required String receiverUserId,
    required String chatTopicId,
    required int messageType,
    required String messageText,
    required String image,
    required String audio,
    required bool isChatMediaBanned,
    String? messageId,
  }) async {
    final message = jsonEncode(
      {
        "chatTopicId": chatTopicId,
        "senderUserId": senderUserId,
        "receiverUserId": receiverUserId,
        "messageType": messageType,
        "message": messageText,
        "image": image,
        "audio": audio,
        "createdAt": DateTime.now().toString(),
        "messageId": messageId,
        "isChatMediaBanned": isChatMediaBanned,
      },
    );

    if (socket != null && socket!.connected) {
      socket?.emit("message", message);
      Utils.showLog("Socket Emit => User Send Message");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onReadMessage({
    required String senderUserId,
    required String messageId,
  }) async {
    Utils.showLog("On Read Message Method Calling...");

    final messageRead = jsonEncode({"messageId": messageId});

    if (socket != null && socket!.connected) {
      Utils.showLog("Login User Id => ${Database.loginUserId} >>> Last Chat UserId => $lastVisitChatUserId >>> Message Sender User Id $senderUserId");

      if (lastVisitChatUserId != null && Database.loginUserId != senderUserId && lastVisitChatUserId == senderUserId) {
        socket?.emit("messageRead", messageRead);

        Utils.showLog("New Message Read => True");

        Utils.showLog("Socket Emit => User Read Message");
      } else {
        Utils.showLog("New Message Read => False");
      }
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  static Future<void> onReadMessageRequest({required String messageId}) async {
    Utils.showLog("On Read Message Request Method Calling...");

    final messageRead = jsonEncode({"messageId": messageId});

    if (socket != null && socket!.connected) {
      socket?.emit("messageRequestRead", messageRead);

      Utils.showLog("New Message Read => True");

      Utils.showLog("Socket Emit => Read Message Request");
    } else {
      Utils.showLog("Socket Not Connected !!");
    }
  }

  // >>>>> >>>>> >>>>> >>>>> Socket Listen Data Set Method <<<<< <<<<< <<<<< <<<<<

  static Future<void> onGetNewGift({required Map gift}) async {
    LiveUserSendGiftBottomSheetUi.giftUrl.value = gift["giftData"]["giftUrl"];
    LiveUserSendGiftBottomSheetUi.giftType.value = gift["giftData"]["giftType"];

    LiveUserSendGiftBottomSheetUi.isShowGift.value = true;
    LiveUserSendGiftBottomSheetUi.giftType.value == 3 ? await 5000.milliseconds.delay() : await 1000.milliseconds.delay();
    LiveUserSendGiftBottomSheetUi.isShowGift.value = false;
  }

  static Future<void> onGetNewComment({required Map message}) async {
    mainLiveComments.add(message);
    await onScrollDown();
  }

  static Future<void> onGetNewMessage({required Map message}) async {
    try {
      userChats.add(
        Chat(
          image: message["image"],
          audio: message["audio"],
          message: message["message"],
          createdAt: message["createdAt"],
          messageType: message["messageType"],
          senderUserId: message["senderUserId"],
          isChatMediaBanned: message["isChatMediaBanned"],
        ),
      );

      onUpdateChat();

      await onScrollDown();
    } catch (e) {
      Utils.showLog("New Message Get Filed => $e");
    }
  }

  static Future<void> onScrollDown() async {
    try {
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
      await 10.milliseconds.delay();
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (e) {
      Utils.showLog("Scroll Down Failed => $e");
    }
  }

  static Future<void> onUpdateChat() async {
    onChangeChats.value = !onChangeChats.value;
  }
}
