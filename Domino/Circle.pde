class Circle {
  private Point start;
  private float startDir;
  private float diameter;
  private float angle;
  private Point center;
  
  public Circle(Point start, float startDir, float diameter, float angle, Adder a) {
    this.start = start;
    this.startDir = startDir;
    this. diameter = diameter;
    this.angle = angle;
    this.center = start.plus(start.normal().unit().times(this.diameter/2));
    println("center: " + this.center.toString());
    println("start: " + this.start);
    
    createBlocks(a);
  }
  
  private void createBlocks(Adder a) {
    float perimeter = 2*PI*this.diameter/2;
    perimeter = perimeter * (this.angle/2*PI);
    
    int blocks = (int) perimeter / 30;
  
    float currentAngle = this.startDir;
    
    for(int i = 0; i < blocks; i++) {
      Point pos = this.center.plus(new Point(acos(currentAngle), asin(currentAngle)));
      println(pos);
      a.add(pos, currentAngle);
      currentAngle += this.angle/blocks;  
    }
    
  }
  
  
  
  
}
