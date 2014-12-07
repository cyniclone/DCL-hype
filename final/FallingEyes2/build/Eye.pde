/* Code adapted from Dan Shiffman's Nature of Code
// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
*/

class Eye {
  HShape shape; // SVG object

  Body body; // Box2D physical body
  float r; // Radius for ellipse boundary

  // ----- CONSTRUCTOR -----
  Eye(float x, float y, float r_) {
    shape = new HShape("eyeframe.svg").enableStyle(false);
    H.add(shape)
      
      .fill(127)
      .anchorAt(H.CENTER)
      .loc(x, y)
    ;

    r = r_;
    
    makeBody(x,y,r); // Put object in Box2D world
  }

  // ----- CHECK FOR DELETION ---------
  boolean done() {
    // Get screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Check if it's fallen off the bottom of the screen
    if (pos.y > height+r*2 || pos.x < -(height+r*2) || pos.x > (height+r*2)) {
      H.remove(this.shape); // This removes the HShape from the stage
      println("Removing " + this.shape);
      killBody();
      return true;
    }
    return false;
  }

  // ----- DESTROY BOX2D BODY ----------
  void killBody() {
    box2d.destroyBody(body);
  }

  // ----- DISPLAY ----------
  void display() {
    // Get the body's screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();

    /*pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    strokeWeight(1);
    ellipse(0,0,r*2,r*2);
    line(0,0,r,0);
    popMatrix();*/

    shape.loc(pos.x, pos.y).rotation(-degrees(a));
  }

  // ----- BOX2D CREATION ----------
  void makeBody(float x, float y, float r) {
    // Define a body and set position
    BodyDef bd = new BodyDef();
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    // Body is circular
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.75; //Making these super bouncy
    // fd.restitution = 0.3;
    
    // Attach fixture to body
    body.createFixture(fd);

    // Give it a random initial velocity (and angular velocity)
    body.setLinearVelocity(new Vec2(random(-10f,10f),random(5f,10f)));
    body.setAngularVelocity(random(-10,10));
  }
}