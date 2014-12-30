// External Libraries
import processing.pdf.*;

// Output configuration
boolean vectorOutput = false;
int pngScale = 2;
boolean dev = true;  // If set to true will create file with timestamp

HDrawablePool pool;

void setup() {
	size(640,640);
	H.init(this).background(#FFFFFF);
	smooth();

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
			.spacing(26,26)
			.cols(24)
		)

		.onCreate (
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.noStroke()
						.fill ((int)random(255),(int)random(255),(int)random(255))
						.anchorAt(H.CENTER)
						.size( 25 )
					;
                                        
				}
			}
		)

		.requestAll()
	;

	H.drawStage();
	noLoop();

if (vectorOutput == true) {
        saveVector();
    } else {
        saveHiRes(pngScale);
    }
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

