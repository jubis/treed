class Point {
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public Point(float angle) {
    this.x = cos(angle);
    this.y = sin(angle);
  }
  
  public float x;
  public float y;
  
  public Point normal() {
    return new Point(-this.y, this.x);
  }
  
  public Point unit() {
    return new Point(this.x/this.length(), this.y/this.length());
  }
  
  public Point plus(Point p) {
    return new Point(this.x+p.x, this.y+p.y);
  }
  
  public Point minus(Point p) {
   return new Point(this.x-p.x, this.y-p.y);
  }
  
  public Point times(float t) {
    return new Point(this.x*t, this.y*t);
  }
  
  public float length() {
    return sqrt(x*x + y*y);
  }
  
  public String toString() {
    return "x:" + this.x + ", y: " + this.y;
  }
}
