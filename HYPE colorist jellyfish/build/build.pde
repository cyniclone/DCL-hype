// External Libraries
import processing.pdf.*;

// Output configuration
boolean vectorOutput = false;
int pngScale = 2;
boolean dev = true;  // If set to true will create file with timestamp

// Cell stuff 
// HDrawablePool pool;
// int cellSize = 25;

// Image Credit
// http://ow.ly/EDPlK

HRect d;
HPixelColorist colors;

void setup(){
	size(675, 900);
	H.init(this).background(#202020);
	smooth();

	// HImage img = new HImage("cmoth.jpg");
	H.add(new HImage("jellyfish.jpg"));

	colors = new HPixelColorist("jellyfish.jpg").fillOnly();

	for (int i = 0; i < 100; i++) {
		d = new HRect();
		d
			.strokeWeight(1)
			.stroke(#000000)
			.size( (int)random(25,125) )
			.rotate( (int)random(360) )
			.loc( (int)random(width), (int)random(height) )
			.anchorAt(H.CENTER)
		;
		colors.applyColor(d);
		H.add(d);
	}

	H.drawStage();
}
 
void draw(){

	// saveFrame("frames/#########.tif"); if (frameCount == 900) exit();
}

/*
void setup(){
	size(675, 900);
	H.init(this).background(#202020);
	smooth();

	// HImage img = new HImage("cmoth.jpg");
	HImage img = new HImage("jellyfish.jpg");

	final HPixelColorist colors = new HPixelColorist(img)
		.fillOnly();

	pool = new HDrawablePool(576);
	pool.autoAddToStage()
		.add (
			new HRect()
			.rounding(4)
		)

		.layout (
			new HGridLayout()
			.startX(21)
			.startY(21)
			.spacing(cellSize+1,cellSize+1)
			.cols(24)
		)

		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.anchorAt(H.CENTER)
						.size(cellSize)
					;

					colors.applyColor(d);
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
	noLoop();
}
*/