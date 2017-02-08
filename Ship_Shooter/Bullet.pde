class Bullet
{
	float theta;
	float strength;
	float aliveTime;
	boolean alive;

	PVector pos;
	PVector forward;

	Bullet(float x, float y, float strength, float theta)
	{
		pos = new PVector(x, y);
		this.theta = theta;
		this.strength = strength;
		forward = new PVector(0, 0);
		aliveTime = 2;
		alive = true;
	}

	float size = 0;

	void render()
	{
		pushMatrix();
		translate(pos.x, pos.y);
		if (size < strength) {
			size += 1;
		}
		else {
			update();
		}
		ellipse(0, 0, size, size);
		popMatrix();
	}

	void update()
	{
		forward.x = sin(theta);
		forward.y  = -cos(theta);
		pos.add(PVector.mult(forward, strength));

		aliveTime -= timeDelta;

		if (aliveTime <= 0) {
			alive = false;
		}
	}
}