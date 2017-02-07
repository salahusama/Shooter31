class Bullet extends GameObject
{
	float theta;
	float strength;
	float aliveTime;
	boolean alive;

	PVector forward;
	Ship parent;

	Bullet(Ship parent, float x, float y, float strength, float theta)
	{
		super(x + (parent.shipImg.width + strength/2) * sin(theta), y + (parent.shipImg.height + strength/2) * -cos(theta));
		this.parent = parent;
		this.theta = theta;
		this.strength = strength;
		forward = new PVector(0, 0);
		aliveTime = 2;
		alive = true;
	}

	float size = 0;

	void render()
	{
		strokeWeight(3);
		stroke(0, 0, 250);
		fill(180, 255, 255);

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