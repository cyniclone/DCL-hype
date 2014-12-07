/* Nicolas Aguirre
 Design/Code/Loop Fall 2014 final
 */
 import processing.pdf.*;

 //Output config
 boolean vectorOutput = false;
 int pngScale = 1;
 boolean dev = true; // If set to true will create file with timestamp

void setup(){
	size(737,1000); //Size of mask image
	H.init(this).background(0).autoClear(true);
	smooth();

//HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);
//Sea Urchin (Analogous)
HColorPool urchin = new HColorPool(#6B5A43,#64573E,#77674D,#786B4E,#7E6C4A,#6E614C,#62633E,#645D46,#6A6444,#605B3F,#776D56,#8B7762,#856A4C,#97805D,#AA916E,#9B8F64,#91885B,#7D794E);

//Moth High-contrast
HColorPool moth = new HColorPool(#222222,#232D21,#6F1A15,#5D3537,#53505A,#914033,#B41804,#466C30,#B5381F,#A24E47,#9D585A,#9D6362,#86759D,#AB7378,#9995A6,#C6C6C6);

//Moth dark/muted
HColorPool moth2 = new HColorPool(#433442,#4D3F49,#5B3034,#52514D,#2E4132,#1C241B,#3C4938,#677B63,#3F4035,#463A47,#2B2D28,#545B58,#696770);

//Caterpillar
HColorPool caterp = new HColorPool(#D6CED6,#333333,#A5A1A1,#D7CCC4,#E39F6B,#C18B55,#F0B273,#D8AC7D,#F1AA5D,#D8AA68,#D8BB90,#ECC588,#C4A87C,#EFD09D,#E9DDC8,#A69A83,#C7A254,#FDEBBF,#98813D,#F8F7F3,#C4B881,#B3B2AB,#94916E,#808468,#BCC3A6,#8F96A6,#808794,#9FA7B4,#C8CDDA,#D5DCE8,#939388,#CAD6C7,#BBC9C5,#EDF7EC,#CACAC3,#F7FEFF,#D9DBDA);

//Circus (Triad)
HColorPool circus = new HColorPool(#350925,#470821,#5B071D,#730517,#920410,#AC020A,#C20105,#D30001,#B5140B,#CF1D07,#E52404,#FB2E01,#CF4F15,#A76B27,#F88B03,#EB8A09,#DF890E,#D38813,#C78719,#BA861F,#AB8425,#9D832B,#928130,#878035,#0A766D,#177767,#257860,#377A58,#7C803A,#707F3F,#607D46,#4C7C4F);

//Complementary
HColorPool comp = new HColorPool(#EEBAA0,#E1A788,#E3AA8B,#F5D5C3,#DF9C76,#F3CAB2,#D9956B,#F6D9BE,#4C2DC7,#4D2FCA,#5538CC,#5C38C5,#6443D5,#6A48CB,#6B4BCD,#7851DE,#6B4BC9,#7C58DF,#825DE3,#8764E9,#8361C4,#A489E7,#9B7BC6,#9E7BC2);

//Birdy Nam Nam
HColorPool bnam = new HColorPool(#6D5B42,#68684D,#64774C,#3A462D,#547843,#47753C,#1D3A1B,#356636,#152919,#221434,#492563,#3A1D4E,#58276A,#761F63,#AE206E,#771A4B,#B4266D,#7A1E4B,#A9316A,#AF1957,#85435E,#432D35,#592937,#720726,#88505D,#563C3D);

HColorPool c = bnam;

	// Populate with jellfish
	for (int i = 0; i < 300; i++) {
		// HShape d = new HShape("tenta.svg");
		HShape d = new HShape("eye.svg");
		H.add(d)
		.strokeWeight(0.15)
		// .stroke(255)
		.noFill()
		.anchorAt(H.CENTER)
		.loc(random(width), random(height))
		.rotation(random(360))
		// .scale(random(2,2.5));
		.scale(1.5);
		d.randomColors(c.fillAndStroke());

	}

	// Apply image mask
	HImage img = new HImage(loadImage("mask2.png"));
	H.add(img)
		.loc(0,0)
	;

	// Output config
	if (vectorOutput == true) {
        saveVector();
    } else {
    	saveHiRes(pngScale);
    }
       
}
 
void draw(){
	H.drawStage();

	// saveFrame("frames/#########.tif"); if (frameCount == 900) exit();
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
