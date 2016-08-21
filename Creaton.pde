import processing.serial.*;
PGraphics pg;
PImage img1;
Serial myPort;
int b1x;
int b1y;
int b2x;
int b2y;
int b3x;
int b3y;
int imgX;
int imgY;
int mX;
int mY;
int vDataX;
int vDataY;
float dataRad = 6;
color c1Color;
color w1Color;
color h1Color;
int diameter = 24;
int padding = 16;
float temp;
float ppm;
float perHum;
public enum Status
{
    CONTAMINATION, 
    WEATHER, 
    HUMIDITY,
    MAP
};

Status state;

void setup()
{
  String portName = "COM12";
   myPort = new Serial(this, portName, 9600);
   size (500, 350);
   pg = createGraphics(width, height);
   c1Color = color(255, 115,19);
   w1Color = color(19 ,197, 225);
   h1Color = color(197 , 19  , 225);
   img1 = loadImage("Mapa2.png");
   centerImage();
   centerData();
}

void draw()
{
  if(myPort.available()>0)
  {
  println(myPort.read());
  delay(3000);
  }
  else
  {
    
    
  }
  background(155);
  if(state == Status.MAP){
   imgX = mouseX-mX;
   imgY = mouseY-mY;
  }
  pg.beginDraw();
  image(img1, imgX, imgY);
  update(mouseX, mouseY);
  fill(c1Color);
  ellipse(padding, padding + 4, diameter, diameter);
  fill(w1Color);
  ellipse(padding, padding + diameter + 6, diameter, diameter);
  fill(h1Color);
  ellipse(padding, padding + diameter*2 + 10, diameter, diameter);
  pg.endDraw();
}

void update(int x, int y) {
  if(circleOver(padding,padding + 4,diameter)){
    state = Status.CONTAMINATION;
  }
  else if (circleOver (padding, padding + diameter + 6, diameter)) {
    state = Status.WEATHER;
  }
  else if(circleOver (padding, padding + diameter*2 + 10, diameter)){
    state = Status.HUMIDITY;
  }
  else{
    state = Status.MAP;
  }
}

void mousePressed() {
  if (state == Status.CONTAMINATION) {
    contour ();
  }
  else if (state == Status.WEATHER) {
     
  }
  else if(state == Status.HUMIDITY){
    
  }
  else{
    mX = mouseX-imgX;
    mY = mouseY-imgY;
  }
}

boolean circleOver(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void keyPressed()
{
centerImage();
}

void centerImage()
{
 imgX = (width-img1.width)/2;
 imgY = (height-img1.height)/2;
}

void contour (){
  for(int i = 1; i < 4; i ++){
    ellipse(vDataX, vDataY, dataRad * i, dataRad * i);
  }
}
/*
void wriData(float  ) */

void centerData()
{
   vDataX = (width-img1.width)/2;
    vDataY = (height-img1.height)/2;
}