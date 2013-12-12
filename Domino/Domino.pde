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

public void setup() {
  frameRate(20);
  woodenFloor = loadImage("parketti.png");
  woodenWall = loadImage("seinä.png"); 
  
  size(1280, 720, P3D);
  frameRate(60);
  
  this.minim = new Minim(this) ;
  this.musicPlayer = minim.loadFile("Everlasting.wav");
  this.musicPlayer.play();
  
  cam = new PeasyCam(this, 1000);
  cam.rotateY(-PI/2);
  cam.lookAt(500, 0, 100);
  //extends of physics world
  Vector3f min = new Vector3f(-5000, -1000, -5000);
  Vector3f max = new Vector3f(5000, 250, 20000); 
  //create a rigid physics engine with a bounding box
  physics = new BPhysics(min, max);
  //physics = new BPhysics();
  //set gravity
  physics.world.setGravity(new Vector3f(0, 500, 0));
  
  adder = new Adder(this,physics);
  
  //a.add(new Point(0, 0), 0);
  drawSteps(new Point(0, 100), new Point(-500, 100), adder.GREEN);
   
  /*println((new Point(10,10)).normal().unit().times(5));
  println((new Point(10,10)).normal());
  println((new Point(10,10)).unit().length());
  println((new Point(10,10)).times(5));*/
  //println(new Point(PI).toString() + "################");
          
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

            
   //adder.add(new Point(0, 200), 0);
   
}

public void draw() {
  background(255);
  
  //lights();
  ambientLight(110,110,110);
  directionalLight(200, 200, 200, 1, 1, 1);
  
  drawFloor();
  drawWalls();
  drawRoof();
  /*//cam.rotateY(frameCount*.01f);
   //cam.lookAt(0,0,500+frameCount*2);
   int mass = 100;
   
   if (frameCount % 5 == 0 && frameCount < 600) {
   Vector3f pos = null;
   //println(frameCount);
   float x = (frameCount/1.5f-200)*3;
   float y = x*x/100;
   println(x);
   if(x > -200 && x < 200) {
   pos = new Vector3f(x*2, 220, y);
   }
   else if(x < -200) {
   pos = new Vector3f(-200*2, 220, -400-x*4);
   }
   else {
   println("curve ready");
   pos = new Vector3f(-400, 220, 1200);
   }
   
   //reuse the rigidBody of the sphere for performance resons
   //BObject(PApplet p, float mass, BObject body, Vector3f center, boolean inertia)
   BObject r = new BObject(this, mass, new BBox(this, 1, 30, 60, 7), pos, true);
   if(x > -200 && x < 200) {
   float angle = PI/2-atan(2*x/50f);
   println("rotating: " + angle);
   r.setRotation(new Vector3f(0,1,0), angle);
   }
   r.display(new Vector3f(200,200,200));
   //add body to the physics engine
   physics.addBody(r);
   }*/
  //update physics engine every frame, nopeutetaan dominoiden kaatumista
  physics.update();
  physics.update();
  physics.update();
 physics.update();
  // default display of every shape
  physics.display();
  
  /*println(frameCount);
  if(frameCount == 260) {
    cam.rotateY(PI/2);
    cam.lookAt(1200, 0, -800, 350, 6000);
  }
  if(frameCount == 500) {
    cam.rotateY(-PI/2);
    cam.lookAt(1100, 0, -800, 500, 3000);
  }*/
}

public void drawLine(Point begin, Point end, Vector3f c){
  Point line = end.minus(begin);
  //30 on välin pituus
  int boxAmount = (int)line.length()/45;
  //times on kertolasku
  Point offset = line.times(1f/boxAmount);
  float angle = atan(line.y/line.x);
  //println("Kulma "+angle);
  Point location = begin;
  for(int i=0; i<boxAmount; i++){
    //a = adder
    adder.add(location, PI/2-angle, c);
    location = location.plus(offset);
    //println("for-looppi "+i+ " boxAmount "+ boxAmount);
  }
}

public void drawSteps(Point begin, Point end, Vector3f c){
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
    //a = adder
    
    location = location.plus(offset);
    adder.add(location, y-40, PI/2-angle, c);
    //location, y, BObject, rotation
    //adder.add(location, y, new BBox(this, 200, 40, 40, 40), 0);
    
   for(int j=0; j<=i; j++){
     //if(y<=220){
      //int j=i; 
       //adder.add(location, y+j*40, , PI/2-angle);
       BBox box = new BBox(this, 50, new Vector3f(location.x, y+j*boxHeight, location.y), new Vector3f(40, boxHeight, 40), false);
       box.setRotation(new Vector3f(0,1,0), PI/2-angle);
       physics.addBody(box);
       //box.setMass(0);
       //println(box.);
     //}
     
   } 
   y = y - boxHeight;
  }
  
}

public void drawFloor(){
  beginShape();
  //vertex(x, y, z, u, v)
  texture(woodenFloor);
  vertex(-5000, 250, -5000, 0, 0);
  vertex(5000, 250, -5000, 1024, 0);
  vertex(5000, 250, 20000, 1024, 1024);
  vertex(-5000, 250, 20000, 0, 1024);
  endShape();
}

public void drawWalls(){
  drawXWall(-4000, 4000, 250, -3000, -4000);
  drawZWall(-4000, 4000, 250, -3000, -4000);
  drawZWall(-4000, 4000, 250, -3000, 4000);
  drawXWall(-4000, 4000, 250, -3000, 4000); 
}

public void drawXWall(int x1, int x2, int y1, int y2, int z){
  beginShape();
  //vertex(x, y, z, u, v)
  texture(woodenWall);
  vertex(x1, y1, z, 0, 0);
  vertex(x2, y1, z, 0, 634);
  vertex(x2, y2, z, 800, 634);
  vertex(x1, y2, z, 800, 0);
  endShape();
}

public void drawZWall(int z1, int z2, int y1, int y2, int x){
  beginShape();
  //vertex(x, y, z, u, v)
  texture(woodenWall);
  vertex(x, y1, z1, 0, 0);
  vertex(x, y1, z2, 0, 634);
  vertex(x, y2, z2, 800, 634);
  vertex(x, y2, z1, 800, 0);
  endShape();
}

public void drawRoof(){
  beginShape();
  //vertex(x, y, z, u, v)
  //texture(woodenWall);
  vertex(-4000, -3000, -4000);
  vertex(4000, -3000, -4000);
  vertex(4000, -3000, 4000);
  vertex(-4000, -3000, 4000);
  endShape();
}

