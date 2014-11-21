// External Libraries
import processing.pdf.*;

// Output configuration
boolean vectorOutput = false;
int pngScale = 2;
boolean dev = true;  // If set to true will create file with timestamp

HDrawablePool pool;
int cellSize = 25;


void setup(){
	size(640, 640);
	H.init(this).background(#202020);
	smooth();

	HImage img = new HImage("cmoth.jpg");


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
 
void draw(){

	// saveFrame("frames/#########.tif"); if (frameCount == 900) exit();
}