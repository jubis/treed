import javax.vecmath.Vector3f;
import bRigid.*;

class Adder {
  private BObject block;
  private PApplet app;
  private BPhysics physics;
  final Vector3f RED = new Vector3f(255, 0, 0);
  final Vector3f BLUE = new Vector3f(0, 0, 255);
  final Vector3f GREEN = new Vector3f(0, 255, 0);
  
  public Adder(PApplet app, BPhysics physics) {
    this.app = app;
    this.physics = physics;
    //this.block = new BBox(this.app, 1, 30, 60, 7);
  }
  
  public void add(Point posFlat, float y, float rotation, Vector3f c) {
    BObject b = new BBox(this.app, 1, 30, 60, 7);
    this.add(posFlat, y, b, rotation, c);
  }
  
  public void add(Point posFlat, float rotation, Vector3f c){
    this.add(posFlat, 220, rotation, c);
  }
  
  public void add(Point location, float y, BObject object, float rotation, Vector3f c){
    Vector3f pos = new Vector3f(location.x, y, location.y);
    BObject b = new BObject(this.app, 100, object, pos, true);
    b.setRotation(new Vector3f(0, 1, 0), rotation);
    b.display(c, new Vector3f(50,50,50));
    physics.addBody(b);
  }
  
}
