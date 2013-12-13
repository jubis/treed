import javax.vecmath.Vector3f;
import peasy.*;
import bRigid.*;
import java.util.ArrayList;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
AudioPlayer musicPlayer;

PeasyCam cam;
BPhysics physics;
Adder adder;
PImage woodenFloor;
PImage woodenWall;
PImage window;
PImage door;
PImage startImg;

boolean running = false;
int frameCountOnStart = 0;

public void setup() {
  frameRate(20);
  woodenFloor = loadImage("parketti.png");
  woodenWall = loadImage("seinä.png"); 
  window = loadImage("ikkuna.png");
  door= loadImage("ovi.png");
  startImg = loadImage("startimage.png");
  
  size(1280, 720, P3D);
  frameRate(60);
  
  this.minim = new Minim(this) ;
  this.musicPlayer = minim.loadFile("ameno.wav");

  cam = new PeasyCam(this, 1000);
  cam.rotateY(0);
  cam.lookAt(970, 0, 570);
  cam.setDistance(500);
  
  cam.setLeftDragHandler(null);
  cam.setCenterDragHandler(null);
  cam.setRightDragHandler(null);
  cam.setWheelHandler(null);
  
  Vector3f min = new Vector3f(-5000, -1000, -5000);
  Vector3f max = new Vector3f(5000, 250, 20000); 
  physics = new BPhysics(min, max);

  physics.world.setGravity(new Vector3f(0, 500, 0));
  
  adder = new Adder(this, physics);   

  initAnimation();
}

public void initAnimation() {
  drawSteps(new Point(0, 100), new Point(-500, 100), adder.GREEN);
          
  drawLine(new Point(0, 100), new Point(1050, 100), adder.RED);
  
  new Circle(new Point(970, 100), 
             PI,
             250,
             PI,
             adder,
             false,
             adder.BLUE);
     
   new Circle(new Point(970, 350), 
             0,
             220,
             PI,
             adder,
             true,
             adder.BLUE);
          
   new Circle(new Point(970, 570), 
             PI,
             1000,
             PI,
             adder,
             true,
             adder.BLUE);

          
      
   new Circle(new Point(1010, -430), 
             0,
             1000,
             PI,
             adder,
             false,
             adder.GREEN);
             
    drawSteps(new Point(1000, -1430), new Point(1290, -1430), adder.GREEN);
    
    new Circle(new Point(1310, -1430), 
             0,
             1000,
             PI/2,
             adder,
             true,
             adder.BLUE);
     
     drawLine(new Point(1810, -950), new Point(1810, 460), adder.RED);
     
     new Circle(new Point(1810, 420), 
             -PI/2,
             1000,
             PI/2,
             adder,
             false,
             adder.BLUE);
     
     drawLine(new Point(1330, 920), new Point(810, 920), adder.GREEN);
     
     new Circle(new Point(810, 920), 
             0,
             1000,
             PI,
             adder,
             true,
             adder.BLUE);
     
     new Circle(new Point(780, 1920), 
             PI,
             1000,
             PI,
             adder,
             false,
             adder.BLUE);
             
     drawSteps(new Point(780, 2920), new Point(280, 2920), adder.GREEN);
     
     drawLine(new Point(260, 2920), new Point(-400, 2920), adder.GREEN);
     
     new Circle(new Point(-360, 2920), 
             0,
             1000,
             PI,
             adder,
             false,
             adder.BLUE);
}

public void keyPressed(){
  if(!running) {
    running = true;
    frameCountOnStart = frameCount;
    this.musicPlayer.play();
  }
}

public void draw() {
  background(255);
  ambientLight(110,110,110);
  directionalLight(200, 200, 200, 1, 1, 1);
  
  drawFloor();
  drawWalls();
  drawRoof();
  
  if(!running) {
    cam.beginHUD();
    noLights();
    image(startImg,0,0);
    cam.endHUD();
  } else {
    physics.update();
    physics.update();
    physics.update();
    physics.update();
    
    physics.display();
    
    println(frameCount-frameCountOnStart);
    switch(frameCount-frameCountOnStart) {
      case 70: 
        cam.lookAt(970, 0, 500, 1000, 3000); 
        break;
      case 150: 
        cam.rotateY(-PI/2);
        cam.lookAt(1200, 0, -800, 1300, 6000); 
        break;
      case 290: 
        cam.lookAt(1200, 0, -800, 400, 10000); 
        break;
      case 450: 
        cam.rotateY(-PI/2);
        cam.lookAt(970, 0, 200, 300, 10500); 
        break;
      case 600:
        cam.rotateY(PI/2); 
        cam.lookAt(700, 0, 1500, 1000, 5000); 
        break;
      case 720:
        cam.lookAt(700, 0, 2500, 1200, 5000); 
        break;
      case 930:
        cam.rotateY(PI); 
        cam.lookAt(-200, 0, 2500, 600, 5000); 
        break;
      case 1130:
        cam.rotateY(-PI/3.6  );
        cam.rotateX(PI/5.5);
        cam.lookAt(1300, 0, 1500, 2500, 8000); 
        this.musicPlayer.shiftGain(0, -40, 9000);
        break;
      case 1400:
        this.musicPlayer.pause();
        break;
    }
  }
  
}

/**
 * Piirtää haluttujen pisteiden väriin suoran jonon tietyn värisiä dominopalikoita.
 */
public void drawLine(Point begin, Point end, Vector3f blockColor){
  Point line = end.minus(begin);

  int boxAmount = (int)line.length()/45;

  Point offset = line.times(1f/boxAmount);
  float angle = atan(line.y/line.x);

  Point location = begin;
  for(int i=0; i<boxAmount; i++){
    adder.add(location, PI/2-angle, blockColor);
    location = location.plus(offset);
  }
}

/**
 * Piirtää palikat kuten drawLine, mutta niiden alle tulee portaat, jotka nousevat pala palalta.
 */
public void drawSteps(Point begin, Point end, Vector3f blockColor){
 Point line = end.minus(begin);
  //30 on välin pituus
  int boxAmount = (int)line.length()/40;
  //times on kertolasku
  Point offset = line.times(1f/boxAmount);
  float angle = atan(line.y/line.x);
  println("Kulma "+angle);
  Point location = begin;
  float y = 240;
  int boxHeight = 20;
  
  for(int i=0; i<boxAmount; i++){
     location = location.plus(offset);
     adder.add(location, y-40, PI/2-angle, blockColor);
    
     for(int j=0; j<=i; j++){
       BBox box = new BBox(this, 50, new Vector3f(location.x, y+j*boxHeight, location.y), new Vector3f(40, boxHeight, 40), false);
       box.setRotation(new Vector3f(0,1,0), PI/2-angle);
       physics.addBody(box);
     } 
     y = y - boxHeight;
  }
  
}

/****************
 * Metodeja mökin osien piirtämiseen
 ****************/

public void drawFloor(){
  beginShape();
  texture(woodenFloor);
  vertex(-4000, 250, -4000, 0, 0);
  vertex(4000, 250, -4000, 1024, 0);
  vertex(4000, 250, 4000, 1024, 1024);
  vertex(-4000, 250, 4000, 0, 1024);
  endShape();
}

public void drawWalls(){
  drawXWall(-4000, 4000, 250, -3000, -4000);
  drawZWall(-4000, 4000, 250, -3000, -4000);
  drawZWall(-4000, 4000, 250, -3000, 4000);
  drawXWall(-4000, 4000, 250, -3000, 4000);
  drawZWindow(-500, 500, -1000, -2000, -3999); 
  drawZWindow(-500, 500, -1000, -2000, 3999);
  drawZWindow(-2500, -1500, -1000, -2000, -3999); 
  drawZWindow(-2500, -1500, -1000, -2000, 3999);
  drawZWindow(1500, 2500, -1000, -2000, -3999); 
  drawZWindow(1500, 2500, -1000, -2000, 3999);
  drawXWindow(-500, 500, -1000, -2000, -3999);
  drawXWindow(-500, 500, -1000, -2000, 3999);
  drawXDoor(-3000, -2000, -2250, 250, 3999);

}

public void drawXWall(int x1, int x2, int y1, int y2, int z){
  beginShape();
  texture(woodenWall);
  vertex(x1, y1, z, 0, 0);
  vertex(x2, y1, z, 0, 634);
  vertex(x2, y2, z, 800, 634);
  vertex(x1, y2, z, 800, 0);
  endShape();
}

public void drawZWall(int z1, int z2, int y1, int y2, int x){
  beginShape();
  texture(woodenWall);
  vertex(x, y1, z1, 0, 0);
  vertex(x, y1, z2, 0, 634);
  vertex(x, y2, z2, 800, 634);
  vertex(x, y2, z1, 800, 0);
  endShape();
}

public void drawRoof(){
  beginShape();
  vertex(-4000, -3000, -4000);
  vertex(4000, -3000, -4000);
  vertex(4000, -3000, 4000);
  vertex(-4000, -3000, 4000);
  endShape();
}


public void drawZWindow(int z1, int z2, int y1, int y2, int x){
   beginShape();
  texture(window);
  vertex(x, y1, z1, 0, 0);
  vertex(x, y1, z2, 0, 1000);
  vertex(x, y2, z2, 1000, 1000);
  vertex(x, y2, z1, 1000, 0);
  endShape();
}

public void drawXWindow(int x1, int x2, int y1, int y2, int z){
  beginShape();
  texture(window);
  vertex(x1, y1, z, 0, 0);
  vertex(x2, y1, z, 0, 1000);
  vertex(x2, y2, z, 1000, 1000);
  vertex(x1, y2, z, 1000, 0);
  endShape();
}

public void drawXDoor(int x1, int x2, int y1, int y2, int z){
  beginShape();
  texture(door);
  vertex(x1, y1, z, 0, 0);
  vertex(x2, y1, z, 0, 1000);
  vertex(x2, y2, z, 2000, 1000);
  vertex(x1, y2, z, 2000, 0);
  endShape();
}



