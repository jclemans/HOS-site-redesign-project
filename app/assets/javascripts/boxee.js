boxee.setCanPause(true);
boxee.setMode(boxee.KEYBOARD_MODE);
boxee.enableLog(true);

boxee.onPause = function() {
   browser.execute("pause();");
}
 
boxee.onPlay = function() {
  browser.execute("play();");
}