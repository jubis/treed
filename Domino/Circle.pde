class Circle {
  private Point start;
  private float startDir;
  private float diameter;
  private float angle;
  private Point center;
  private Vector3f c;
  
  public Circle(Point start, float startDir, float diameter, float angle, Adder a, boolean right, Vector3f c) {
    this.start = start;
    this.startDir = startDir;
    this. diameter = diameter;
    this.angle = angle;
    this.c = c;
    Point fromStartToCenter = new Point(startDir).normal().times(this.diameter/2);
    if(!right) {
      fromStartToCenter = fromStartToCenter.times(-1);
    }
    this.center = start.plus(fromStartToCenter);

    //println("center: " + this.center.toString());
    //println("start: " + this.start);
    
    createBlocks(a);
  }
  
  private void createBlocks(Adder a) {
    float perimeter = 2*PI*this.diameter/2;
    perimeter = perimeter * (this.angle/(2*PI));
    //println("perimeter: " + perimeter);
    int blocks = (int) perimeter / 45;
  
    float currentAngle = this.startDir;
    for(int i = 0; i < blocks; i++) {
      float totalAngle = PI/2-currentAngle-this.angle;
      Point fromCenterToArc = new Point(cos(totalAngle), sin(totalAngle)).times(this.diameter/2);
      //println(fromCenterToArc.length());
      Point pos = this.center.plus(fromCenterToArc);
      //println(pos);
      a.add(pos, -totalAngle, c);
      currentAngle += this.angle/blocks;  
    }
    
  }
  
  
  
  
}
