void setup(){
	size(640,640);
	H.init(this).background(#202020).autoClear(true);
	smooth();

	HColorPool colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	for (int i = 0; i < 100; i++) {
		HShape d = new HShape("hex.svg");
		H.add(d)
		.strokeWeight(0.25)
		.stroke(#000000)
		.noFill()
		.anchorAt(H.CENTER)
		.loc(random(width), random(height))
		.rotation(random(360))
		.scale(3);

		d.randomColors(colors.fillOnly());

	}



	

	H.drawStage();
}
 
void draw(){
	

	// saveFrame("frames/#########.tif"); if (frameCount == 900) exit();
}