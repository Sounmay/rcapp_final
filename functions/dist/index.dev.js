"use strict";

var functions = require('firebase-functions');

var admin = require('firebase-admin');

admin.initializeApp();
var fcm = admin.messaging();
var msgData;
exports.adminOrderTrigger = functions.firestore.document('confirmedOrders/{id}').onCreate(function _callee(snapshot, context) {
  var tokens, _snap;

  return regeneratorRuntime.async(function _callee$(_context) {
    while (1) {
      switch (_context.prev = _context.next) {
        case 0:
          tokens = [];
          _context.next = 3;
          return regeneratorRuntime.awrap(admin.firestore().collection('userInfo').where('isAdmin', '==', true).get());

        case 3:
          _snap = _context.sent;

          _snap.forEach(function (k) {
            tokens.push(k.data().token.toString());
          });

          return _context.abrupt("return", fcm.sendToDevice(tokens, {
            notification: {
              title: 'New Order',
              body: 'New order has been placed',
              clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
          }));

        case 6:
        case "end":
          return _context.stop();
      }
    }
  });
});
exports.adminBookingTrigger = functions.firestore.document('BookingDetails/{id}').onCreate(function _callee2(snapshot, context) {
  var tokens, _snap;

  return regeneratorRuntime.async(function _callee2$(_context2) {
    while (1) {
      switch (_context2.prev = _context2.next) {
        case 0:
          tokens = [];
          _context2.next = 3;
          return regeneratorRuntime.awrap(admin.firestore().collection('userInfo').where('isAdmin', '==', true).get());

        case 3:
          _snap = _context2.sent;

          _snap.forEach(function (k) {
            tokens.push(k.data().token.toString());
          });

          return _context2.abrupt("return", fcm.sendToDevice(tokens, {
            notification: {
              title: 'New Booking',
              body: 'New booking request sent',
              clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
          }));

        case 6:
        case "end":
          return _context2.stop();
      }
    }
  });
});
exports.confirmNotification = functions.firestore.document('confirmedOrders/{id}').onUpdate(function (snapshot, context) {
  var token = snapshot.after.data().token;
  return fcm.sendToDevice(token, {
    notification: {
      title: 'Order Confirmation',
      body: 'Your order has been confirmed',
      clickAction: 'FLUTTER_NOTIFICATION_CLICK'
    }
  });
});
exports.BookingNotification = functions.firestore.document('BookingDetails/{id}').onUpdate(function (snapshot, context) {
  var token = snapshot.after.data().token;
  return fcm.sendToDevice(token, {
    notification: {
      title: 'Booking Confirmation',
      body: 'Your Booking has been confirmed',
      clickAction: 'FLUTTER_NOTIFICATION_CLICK'
    }
  });
});