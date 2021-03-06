import javax.vecmath.Vector3f;
import peasy.*;
import bRigid.*;
import java.util.ArrayList;

PeasyCam cam;
BPhysics physics;
Adder adder;

public void setup() {
  size(1280, 720, P3D);
  frameRate(60);

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
  drawSteps(new Point(0, 200), new Point(-300, 0));
   
  /*println((new Point(10,10)).normal().unit().times(5));
  println((new Point(10,10)).normal());
  println((new Point(10,10)).unit().length());
  println((new Point(10,10)).times(5));*/
  //println(new Point(PI).toString() + "################");
          
  drawLine(new Point(0, 200), new Point(1050, 100));
  
  new Circle(new Point(970, 100), 
             0,
             250,
             PI,
             adder,
             true);
     
   new Circle(new Point(970, 350), 
             -PI,
             220,
             PI,
             adder,
             false);
          
   new Circle(new Point(970, 570), 
             0,
             1000,
             PI,
             adder,
             false);
      
   new Circle(new Point(1000, -430), 
             PI,
             1000,
             PI,
             adder,
             true);
             
    drawSteps(new Point(1000, -1430), new Point(1300, -1430));
    
    new Circle(new Point(1310, -1430), 
             0,
             1000,
             PI,
             adder,
             true);
            
   //adder.add(new Point(0, 200), 0);
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
  
 // Calculator.valueOfFunction(2);
 //Calculator.derivativeOfFunction(2,0.000000001);
}

public void drawLine(Point begin, Point end){
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
    adder.add(location, PI/2-angle);
    location = location.plus(offset);
    //println("for-looppi "+i+ " boxAmount "+ boxAmount);
  }
}

public void drawSteps(Point begin, Point end){
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
    adder.add(location, y-40, PI/2-angle);
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

