class BasicEnemy extends Enemy
{
	BasicEnemy(float x, float y, float speed, Ship target, float health)
	{
		super(x, y, health, speed, target);
		oWidth = 100;
		oHeight = 100;
	}

	void render()
	{
		pushMatrix();
		translate(pos.x, pos.y);
		
		rotate(theta);
		fill(100, 100, 0);
		noStroke();
		ellipse(0, 0, oWidth, oHeight);

		popMatrix();
	}

	void update()
	{
		forward.x = speed * sin(theta);
		forward.y = speed * -cos(theta);
		pos.add(forward);

		updateTheta();

		if (gameTime % 1 == 0)
		{
			//fire();
		}
	}
/*
	void fire()
	{
		Bullet b = new Bullet(this, pos.x, pos.y, 10, theta);
		bullets.add(b);
	}*/
}