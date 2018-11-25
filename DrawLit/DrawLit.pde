import controlP5.*;
import processing.video.*;

ControlP5 controlP5;
Capture cam;


//Variables
int saveno=0;
int x,y;
int theBrightPixel = 0;
float maxBri = 0;
float red,green,blue;
float r = 255,g = 255,b = 255;
boolean draw = false;
boolean cam_on = false;

void forecolor(){
      r= random(0,255);
      g = random(0,255);
      b = random(0,255);
}
void colors(){
      red=random(0,255);
      green = random(0,255);
      blue = random(0,255);
}

void setup() {
  noStroke();
  size(640, 480);
  smooth();
  frameRate(30);
  background(0);
  printArray(Capture.list());
  cam = new Capture(this, 640, 480,Capture.list()[0], 30);
  cam.start();
  //button code starts here
   controlP5 = new ControlP5(this);
  PFont p = createFont("SIL-Hei-Med-Jian-48",10); 
 ControlFont font = new ControlFont(p);

 controlP5.setFont(font);
 
 
 controlP5.addButton("Background")
 .setValue(1)
 .setPosition(0,height-30)
 .setSize(70,30)
   .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
           colors();
          background(red,green,blue);
          
        }
      }
    }
  );
  
   controlP5.addButton("Save")
 .setValue(1)
 .setPosition(0,5)
 .setSize(70,30)
   .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          save("LightPlot"+saveno+".png");
          saveno++;
          controlP5.getController("Save").setCaptionLabel("Saving...");
          delay(500);
controlP5.getController("Save").setCaptionLabel("Saved");
    
        }
      }
    }
  );
  
   controlP5.addButton("Foreground")
 .setValue(1)
 .setPosition(90,height-30)
 .setSize(70,30)
   .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          forecolor();
    
        }
      }
    }
  );

  controlP5.addToggle("Plot")
 .setValue(false)
 .setPosition(width-50,5)
 .setSize(20,20)
 .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          //change boolean variable
          draw = !draw;
          
        }
      }
    }
  );
  
   controlP5.addToggle("Cam")
 .setValue(false)
 .setPosition(width-100,5)
 .setSize(20,20)
 .addCallback(new CallbackListener() {
      public void controlEvent(CallbackEvent event) {
        if (event.getAction() == ControlP5.ACTION_RELEASED) {
          //change boolean variable
          cam_on = !cam_on;
          
        }
      }
    }
  );
  //button code ends here
}

// Air draw

void draw() {
  
  if(cam.available()) {
     cam.read();
     cam.loadPixels();
     loadPixels();
     maxBri = 230;
    for(int i=0; i<cam.pixels.length; i++) {
      if(brightness(cam.pixels[i]) > maxBri) {
        maxBri = brightness(cam.pixels[i]);
        theBrightPixel = i;
      }
    }
    x = width-theBrightPixel % width;
    y = theBrightPixel / width;
   if(!draw){ 
 background(red,green,blue);
  }
  if(cam_on){
    pushMatrix();
    scale(-1,1);
  image(cam,-width,0);
  popMatrix();
  
  }
  
    fill(r,g,b);
    ellipse(x,y,10,10);
  }
}
