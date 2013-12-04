import javax.vecmath.Vector3f;
import peasy.*;
import bRigid.*;

PeasyCam cam;
BPhysics physics;
Adder adder;

public void setup() {
  size(1280, 720, P3D);
  frameRate(60);

  cam = new PeasyCam(this, 1000);
  cam.rotateY(-PI/2);
  cam.lookAt(0, 0, 500);
  //extends of physics world
  Vector3f min = new Vector3f(-2000, -1000, -2000);
  Vector3f max = new Vector3f(2000, 250, 20000); 
  //create a rigid physics engine with a bounding box
  physics = new BPhysics(min, max);
  //physics = new BPhysics();
  //set gravity
  physics.world.setGravity(new Vector3f(0, 500, 0));
  
  adder = new Adder(this,physics);
  
  //a.add(new Point(0, 0), 0);
  
  new Circle(new Point(0, 0), 
             0,
             200,
             PI,
             adder);
  drawLine(new Point(10, 10), new Point(310, 310));   
  drawLine(new Point(310, 310), new Point(610, 310));
  drawLine(new Point(610, 310), new Point(800, 100)); 
  drawLine(new Point(800, 100), new Point(910, 100)); 
  /*println((new Point(10,10)).normal().unit().times(5));
  println((new Point(10,10)).normal());
  println((new Point(10,10)).unit().length());
  println((new Point(10,10)).times(5));*/
}

public void draw() {
  background(255);
  lights();



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
  //update physics engine every frame
  physics.update();
  // default display of every shape
  physics.display();
}

public void drawLine(Point begin, Point end){
  Point line = end.minus(begin);
  //30 on välin pituus
  int boxAmount = (int)line.length()/40;
  //times on kertolasku
  Point offset = line.times(1f/boxAmount);
  float angle = atan(line.y/line.x);
  println("Kulma "+angle);
  Point location = begin;
  for(int i=0; i<boxAmount; i++){
    //a = adder
    adder.add(location, PI/2-angle);
    location = location.plus(offset);
    println("for-looppi "+i+ " boxAmount "+ boxAmount);
  }
}
/*
public void drawSteps(){
 Point line = end.minus(begin);
  //30 on välin pituus
  int boxAmount = (int)line.length()/40;
  //times on kertolasku
  Point offset = line.times(1f/boxAmount);
  float angle = atan(line.y/line.x);
  println("Kulma "+angle);
  Point location = begin;
  for(int i=0; i<boxAmount; i++){
    //a = adder
    adder.add(location, PI/2-angle);
    location = location.plus(offset);
    println("for-looppi "+i+ " boxAmount "+ boxAmount);
  }
  
}
*/
