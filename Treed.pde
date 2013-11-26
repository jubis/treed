import javax.vecmath.Vector3f;
import peasy.*;
import bRigid.*;

PeasyCam cam;
BPhysics physics;

public void setup() {
  size(1280, 720, P3D);
  frameRate(60);

  cam = new PeasyCam(this, 1000);
  cam.rotateY(-PI/2);
  cam.lookAt(0,0,500);
  //extends of physics world
  Vector3f min = new Vector3f(-2000, -1000, -2000);
  Vector3f max = new Vector3f(2000, 250, 20000); 
  //create a rigid physics engine with a bounding box
  physics = new BPhysics(min, max);
  //physics = new BPhysics();
  //set gravity
  physics.world.setGravity(new Vector3f(0, 500, 0));
}

public void draw() {
  background(255);
  lights();
  //cam.rotateY(frameCount*.01f);
  cam.lookAt(0,0,500+frameCount*2);
  
  if (frameCount % 5 == 0) {
    Vector3f pos = null;
    println(frameCount);
    if(frameCount != 500) {
       pos = new Vector3f(0, 220, (frameCount-100)*6);
    }
    else {
       pos = new Vector3f(0, 220, -1);
    }
    
    //reuse the rigidBody of the sphere for performance resons
    //BObject(PApplet p, float mass, BObject body, Vector3f center, boolean inertia)
    BObject r = new BObject(this, 100, new BBox(this, 1, 30, 60, 7), pos, true);
    r.display(new Vector3f(200,200,200));
    //add body to the physics engine
    physics.addBody(r);
  }
  //update physics engine every frame
  physics.update();
  // default display of every shape
  physics.display();
}
