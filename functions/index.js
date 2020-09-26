const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

const fcm = admin.messaging();


var msgData;


exports.adminOrderTrigger = functions.firestore.document('confirmedOrders/{id}').onCreate(async (snapshot, context) => {
    var tokens = [];
    const _snap = await admin.firestore().collection('userInfo').where('isAdmin', '==', true).get();
    _snap.forEach((k) => {
        tokens.push(k.data().token.toString());
    })
    return fcm.sendToDevice(tokens, {
        notification: {
            title: 'New Order',
            body: 'New order has been placed', 
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        } 
    })
});


exports.adminBookingTrigger = functions.firestore.document('BookingDetails/{id}').onCreate(async (snapshot, context) => {
    var tokens = [];
    const _snap = await admin.firestore().collection('userInfo').where('isAdmin', '==', true).get();
    _snap.forEach((k) => {
        tokens.push(k.data().token.toString());
    })
    return fcm.sendToDevice(tokens, {
        notification: {
            title: 'New Booking',
            body: 'New booking request sent', 
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        } 
    })
});

exports.confirmNotification = functions.firestore.document('confirmedOrders/{id}').onUpdate((snapshot, context) => {
    var token = snapshot.after.data().token;
    return fcm.sendToDevice(token, {
        notification: {
            title: 'Order Confirmation',
            body: 'Your order has been confirmed',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    })
});


exports.BookingNotification = functions.firestore.document('BookingDetails/{id}').onUpdate((snapshot, context) => {
    var token = snapshot.after.data().token;
    return fcm.sendToDevice(token, {
        notification: {
            title: 'Booking Confirmation',
            body: 'Your Booking has been confirmed',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        }
    })
});
