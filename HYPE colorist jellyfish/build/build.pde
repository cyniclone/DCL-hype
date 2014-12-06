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

//Consider different orientations

HPixelColorist colors;
HColorPool colorPool;

void setup(){
	size(675, 900);
	H.init(this).background(#202020);
	smooth();

	// HImage img = new HImage("cmoth.jpg");
	H.add(new HImage("jellyfish.jpg"));

	colors = new HPixelColorist("jellyfish.jpg");

	for (int i = 0; i < 500; i++) {

		HShape d = new HShape("tenta.svg");
		d
			.loc( (int)random(width), (int)random(height) )
		;

		colorPool = new HColorPool(colors.getColor( d.x(), d.y() ));

		d			
			.noStroke()
			.scale(random(0.3,0.6))
			.noFill()
			.enableStyle(false) // Important
			// .size( (int)random(25,125) )
			// .rotate( (int)random(360) )
			.rotate(302)
			
			.anchorAt(H.CENTER)
		;
		
		H.add(d);
		d.randomColors(colorPool.fillAndStroke());
	}

	if (vectorOutput == true) {
        saveVector();
    } else {
        saveHiRes(pngScale);
    }

	H.drawStage();
}

// For saving to PNG
void saveHiRes(int scaleFactor) {
    PGraphics hiRes = createGraphics(width*scaleFactor, height*scaleFactor, JAVA2D);
    beginRecord(hiRes);
    hiRes.scale(scaleFactor);

    if (hiRes == null) {
        H.drawStage();
    } else {
        H.stage().paintAll(hiRes, false, 1); // PGraphics, uses3d, Alpha
    }

    String fileName;

    if (dev == true) {
        fileName = "render-"+ new java.util.Date() +".png";
    } else {
        fileName = "render.png";
    }

    hiRes.save(fileName);
}

// For saving to Vector Graphics
void saveVector() {
    PGraphics tmp = null;
    tmp = beginRecord(PDF, "render.pdf");

    if (tmp == null) {
        H.drawStage();
    } else {
        H.stage().paintAll(tmp, false, 1); // PGraphics, Uses 3d, alpha
    }

    endRecord();
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