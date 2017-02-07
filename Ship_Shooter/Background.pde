class Background
{
	ArrayList<Star> stars;

	Background(float starNum, float xLimit1, float xLimit2, float yLimit1, float yLimit2)
	{
		stars = new ArrayList<Star>();
		for (int i = 0; i < starNum; i++)
		{
			float x = random(xLimit1, xLimit2);
			float y = random(yLimit1, yLimit2);
			float size = random(10);
			float dist = random(255);
			stars.add( new Star(x, y, size, dist) );
		}
	}

	void render()
	{
		background(0);
		for (Star s : stars)
		{
			s.render();
		}
	}
}

class Star
{
	float x;
	float y;
	float size;
	float howFar;

	Star(float x, float y, float size, float howFar)
	{
		this.x = x;
		this.y = y;
		this.size = size;
		this.howFar = howFar;
	}

	void render()
	{
		update();

		noStroke();
		fill(255, howFar);
		ellipse(x, y, size, size);
	}

	void update()
	{
		if (size > 10) {
			size -= 5;
		}
		else if (size < -10) {
			size += 5;
		}
		else {
			size += random(-1, 1);
		}

		// flickering effect
		if (howFar > 10) {
			howFar += random(-5, 5);
		}
		else {
			howFar += 5;
		}
	}
}