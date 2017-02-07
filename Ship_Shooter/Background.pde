class Background
{
	ArrayList<Star> stars;

	Background(float starNum)
	{
		stars = new ArrayList<Star>();
		for (int i = 0; i < starNum; i++)
		{
			float x = random(-1000, 1000);
			float y = random(-1000, 1000);
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
		noStroke();
		fill(255, howFar);
		ellipse(x, y, size, size);
	}
}