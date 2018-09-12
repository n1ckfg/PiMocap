import oscP5.*;
import netP5.*;

String ipNumber = "127.0.0.1";
int sendPort = 9998;
int receivePort = 7110;
OscP5 oscP5;
NetAddress myRemoteLocation;

String hostName1 = "RPi_180219175326360";
String hostName2 = "RPi_180219180801264";

void oscSetup() {
  oscP5 = new OscP5(this, receivePort);
  myRemoteLocation = new NetAddress(ipNumber, sendPort);
}

// Receive message example
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/blob") && msg.checkTypetag("siff")) {
    
    String hostname = msg.get(0).stringValue();
    int index = msg.get(1).intValue();
    float x = msg.get(2).floatValue();
    float y =  msg.get(3).floatValue();
    
    println(hostname + " " + index + " " + x + " " + y);
    
    if (msg.get(0).stringValue().equals(hostName1)) {
      dot1[index] = new PVector(msg.get(2).floatValue() * (width/2), msg.get(3).floatValue() * height);
    } else if (msg.get(0).stringValue().equals(hostName2)) {
      dot2[index] = new PVector(msg.get(2).floatValue() * (width/2), msg.get(3).floatValue() * height);
    }
  }
}
