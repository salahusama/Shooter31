class BasicEnemy extends Enemy
{
	BasicEnemy(float x, float y, float speed, Ship target, float health)
	{
		super(x, y, speed, target);
		this.health = health;
	}

	void render()
	{
		pushMatrix();
		translate(pos.x, pos.y);
		
		rotate(theta);
		fill(255);
		noStroke();
		ellipse(0, 0, 10, 10);

		popMatrix();
	}

	void update()
	{
		forward.x = speed * sin(theta);
		forward.y = speed * -cos(theta);
		pos.add(forward);

		updateTheta();
	}
}