/* Nicolas Aguirre
 Design/Code/Loop Fall 2014 final
 */
 import processing.pdf.*;

 //Output config
 boolean vectorOutput = true;
 int pngScale = 1;
 boolean dev = true; // If set to true will create file with timestamp

void setup(){
	size(737,1000); //Size of mask image
	H.init(this).background(0).autoClear(true);
	smooth();

	//Birdy Nam Nam
	HColorPool bnam = new HColorPool(#6D5B42,#68684D,#64774C,#3A462D,#547843,#47753C,#1D3A1B,#356636,#152919,#221434,#492563,#3A1D4E,#58276A,#761F63,#AE206E,#771A4B,#B4266D,#7A1E4B,#A9316A,#AF1957,#85435E,#432D35,#592937,#720726,#88505D,#563C3D);

	HColorPool c = bnam;

	for (int i = 0; i < 500; i++) {
		HShape d = new HShape("tenta.svg");
		H.add(d)
		.strokeWeight(0.15)
		.stroke(#222222)
		.noFill()
		.anchorAt(H.CENTER)
		// .loc(random(width/2 - 300, width/2 + 300), random(height/2 - 100, height/2 + 400))
		.loc(random(width), random(height))
		.rotation(random(360))
		// .scale(random(2,2.5));
		.scale(0.75);
		d.randomColors(c.fillOnly());

	}

	HImage img = new HImage(loadImage("mask.png"));
	H.add(img)
		.loc(0,0)
	;
}
 
void draw(){
	H.drawStage();

	// saveFrame("frames/#########.tif"); if (frameCount == 900) exit();
}