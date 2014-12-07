/* Nicolas Aguirre
 Design/Code/Loop Fall 2014 final
 */

 //import Box2d stuff
import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

// Reference object to Box2D world
Box2DProcessing box2d;

// ArrayList of eye objects
ArrayList<Eye> eyes;

// Object storing info about surface
Surface surface;

// Colorfield Object
HColorField colorField;

void setup(){
	size(640,640);
	// frameRate(20);
	H.init(this).background(#202020).autoClear(false);
	smooth();

	// Setup Box2D world and gravity
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0, -20);

	eyes = new ArrayList<Eye>(); // Initialize ArrayList
	surface = new Surface(); // Initialize surface

	// Initialize HColorField
	colorField = new HColorField(width, height)
		.addPoint(width/4, height/2, #FFAB25, 0.2f)
		.addPoint(width/4*3, height/2, #3300FF, 0.2f)
		.addPoint(width/2, height/2, #E80004, 0.2f)
		.strokeOnly()
	;
	

}
 
void draw(){
	background(#202020);
	// Spawn eye objects
	// Apply color

	// Make eyes when mouse is pressed
	if (mousePressed) {
		float sz = 90;
		// Will have to change this later
		eyes.add(new Eye(mouseX, mouseY, sz));
	}

	// Step through Box2D time
	box2d.step();

	/*// Update eye positions
	for (Eye e: eyes) {
	}*/
	for (Eye e: eyes) {
		e.display(); // Draw all the eye objects	
		colorField.applyColor(e.shape); // Color eyes according to HColorfield	
	}

	H.drawStage();

	surface.display(); // Draw surface

	// Delete eyes that have fallen off the screen
	for (int i = eyes.size()-1; i >= 0; i--) {
		Eye e = eyes.get(i);
		if (e.done()) {
			eyes.remove(i);
			//TODO: Find a way to remove the HDrawable/HShape from the stage
		}
	}
	// saveFrame("frames/#########.tif"); if (frameCount == 900) exit();
}

void keyPressed() {
	for (int i = 0; i < eyes.size(); i++) {
		Eye e = eyes.get(i);
		e.killBody();
		eyes.remove(i);
	}

}
