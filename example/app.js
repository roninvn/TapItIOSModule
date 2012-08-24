// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor : 'white'
});

win.open();

// TODO: write your module tests here
var tapit = require('com.tapit');
var v = tapit.createView({
	adzone : '7527',
	top : 0,
	left : 0,
	width : 320,
	height : 50
});

v.loadBannerAd();

win.add(v);

var btnAlert = Ti.UI.createButton({
	title : 'Alert Ads',
	top : 70,
	left: 10,
	width : 100,
	height : 50
});

btnAlert.addEventListener('click', function(){
	
	var v2 = tapit.createView();
	
	v2.showAlertAd({
		adzone:'7527',
		showas:'Alert'
		
	});
});

win.add(btnAlert);

var btnAlert2 = Ti.UI.createButton({
	title : 'ActionSheet Alert Ads',
	top : 70,
	left: 140,
	width : 180,
	height : 50
});

btnAlert2.addEventListener('click', function(){
	var v2 = tapit.createView();
	
	v2.showAlertAd({
		adzone:'7527',
		showas:'ActionSheet'
		
	});
});

win.add(btnAlert2);


var btnAlert3 = Ti.UI.createButton({
	title : 'Interstitial',
	top : 160,
	width : 180,
	height : 50
});

btnAlert3.addEventListener('click', function(){
	var v2 = tapit.createView();
	v2.showInterstitialAd({
		adzone : '7527'
	});
});

win.add(btnAlert3);