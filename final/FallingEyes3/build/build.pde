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
	H.init(this).background(0).autoClear(false);
	smooth();

	// Setup Box2D world and gravity
	box2d = new Box2DProcessing(this);
	box2d.createWorld();
	box2d.setGravity(0, -35);

	eyes = new ArrayList<Eye>(); // Initialize ArrayList
	surface = new Surface(); // Initialize surface

	// // Initialize HColorField
	// colorField = new HColorField(width, height)
	// 	.addPoint(width/4, height/2, #FFAB25, 0.1f)
	// 	.addPoint(width/4*3, height/2, #3300FF, 0.1f)
	// 	.addPoint(width/2, height/2, #E80004, 0.1f)
	// 	.addPoint(width/2, height, #00FF10, 0.1f)
	// 	.strokeOnly()
	// ;

	// Initialize HColorField
	colorField = new HColorField(width, height).strokeOnly();
	// Iterate through rows and populate points
	for (int row = 0; row <= height; row += height/4) {
		for (int column = 0; column <= width; column += width/4) {
			color c = color((int)random(255), (int)random(255), (int)random(255));
			colorField.addPoint(row, column, c, 0.1f);
		}
	}
}
 
void draw(){
	background(0);
	// Spawn eye objects
	// Apply color

	// Make eyes when mouse is pressed
	if (mousePressed) {
		float sz = 75;
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
	if (key == ' ') {
		for (int i = 0; i < eyes.size(); i++) {
			Eye e = eyes.get(i);
			e.killBody();
			eyes.remove(i);
		}
	}
	if (key == 'a' || key == 'A') {
		while (eyes.size() > 0) {
			eyes.get(0).killBody();
			eyes.remove(0);
		}
		setup();
	}

}
