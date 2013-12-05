import javax.vecmath.Vector3f;
import bRigid.*;

class Adder {
  private BObject block;
  private PApplet app;
  private BPhysics physics;
  
  public Adder(PApplet app, BPhysics physics) {
    this.app = app;
    this.physics = physics;
    //this.block = new BBox(this.app, 1, 30, 60, 7);
  }
  
  public void add(Point posFlat, float y, float rotation) {
    BObject b = new BBox(this.app, 1, 30, 60, 7);
    this.add(posFlat, y, b, rotation);
  }
  
  public void add(Point posFlat, float rotation){
    this.add(posFlat, 220, rotation);
  }
  
  public void add(Point location, float y, BObject object, float rotation){
    Vector3f pos = new Vector3f(location.x, y, location.y);
    BObject b = new BObject(this.app, 100, object, pos, true);
    b.setRotation(new Vector3f(0, 1, 0), rotation);
    physics.addBody(b);
  }
  
}
