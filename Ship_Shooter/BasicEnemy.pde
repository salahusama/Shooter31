class BasicEnemy extends Enemy
{
	float lastShot;
	float fireRate;
	color c;

	BasicEnemy(float x, float y, float speed, float health, Ship target)
	{
		super(x, y, health, speed, target);
		oWidth = 30;
		oHeight = 30;

		fireRate = random(0, 0.3);;
		lastShot = -1;

		c = color (random(255), random(255), random(255));
	}

	void render()
	{
		pushMatrix();
		translate(pos.x, pos.y);
		
		rotate(theta);
		fill(c);
		noStroke();
		ellipse(0, 0, oWidth, oHeight);

		popMatrix();

		if (doShake) {
			shake();
		}
	}

	void update()
	{
		forward.x = speed * sin(theta);
		forward.y = speed * -cos(theta);
		pos.add(forward);

		updateTheta();

		if (gameTime - lastShot >= 1 / fireRate)
		{
			fire();
		}

		if (gameTime - lastHit >= timeToShake)
		{
			doShake = false;
		}
	}

	void fire()
	{
		EnemyBullet b = new EnemyBullet(this, pos.x, pos.y, 10, theta);
		normalShot.rewind();
		normalShot.play();
		enemyBullets.add(b);
		lastShot = gameTime;
	}
}