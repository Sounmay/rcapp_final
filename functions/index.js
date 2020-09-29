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
            body: 'New order has been placed.', 
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
            body: 'New booking request sent.', 
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'
        } 
    })
});

exports.confirmNotification = functions.firestore.document('confirmedOrders/{id}').onUpdate(async(snapshot, context) => {
    var token = snapshot.after.data().token;
    var rejected = snapshot.after.data().isRejected;
    var confirmed = snapshot.after.data().isConfirmed;

    if(confirmed === true) {
        return fcm.sendToDevice(token, {
            notification: {
                title: 'Order Confirmation',
                body: 'Your order has been confirmed and will reach you in 30 minutes.',
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        });
    } else if(rejected === true) {
        return fcm.sendToDevice(token, {
            notification: {
                title: 'Order rejected',
                body: 'Your order could not be confirmed at this time. Please contact Rourkela Club for details.',
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        });
    }
    
});


exports.BookingNotification = functions.firestore.document('BookingDetails/{id}').onUpdate(async(snapshot, context) => {
    var token = snapshot.after.data().token;
    var isConfirmed = snapshot.after.data().isConfirmed;
    var isRejected = snapshot.after.data().isRejected;
    if(isConfirmed === true) {
        return fcm.sendToDevice(token, {
            notification: {
                title: 'Booking Confirmation',
                body: 'Your Booking has been confirmed.',
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        });
    } else if(isRejected === true) {
        return fcm.sendToDevice(token, {
            notification: {
                title: 'Booking Rejection',
                body: 'Your Booking could not be confirmed at this time. Please contact Rourkela Club for details.',
                clickAction: 'FLUTTER_NOTIFICATION_CLICK'
            }
        });
    }
});

