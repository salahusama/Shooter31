class Ship extends GameObject
{
	PVector velocity;
	PVector forward;
	PVector accel;
	PVector force;

	PImage shipImg;

	float mass;
	float theta;
	float power;
	float lastShot;
	float fireRate;

	Ship(float x, float y, float health)
	{
		super(x, y, health);
		velocity = new PVector(0, 0);
		forward = new PVector(0, -1);
		accel = new PVector(0, 0);
		force = new PVector(0, 0);
		
		fireRate = 1;
		lastShot = -1;
		power = 300;
		theta = 0;
		mass = 1;

		oWidth = 50;
		oHeight = 50;

		shipImg = loadImage("ship.png");
		shipImg.resize((int)oWidth, (int)oHeight);
	}

	void render()
	{
		noStroke();
		noFill();

		pushMatrix();

		translate(pos.x, pos.y);
		rotate(theta + HALF_PI);
		
		ellipse(0, 0, 1.5 * oWidth, 1.5 * oHeight);
		image(shipImg, -shipImg.width/2, - shipImg.height/2);
		
		popMatrix();

		if (doShake) {
			shake();
		}
	}

	void update()
	{
		forward.x = sin(theta);
		forward.y  = -cos(theta);
		
		if ( checkKey(UP) ) {
			force.add(PVector.mult(forward, power));
		}
		if ( checkKey(DOWN) ) {
			force.add(PVector.mult(forward, -power));      
		}
		if ( checkKey(LEFT) ) {
			theta -= 0.1f;
		}
		if ( checkKey(RIGHT) ) {
			theta += 0.1f;
		}
		if (gameTime - lastShot >= 1 / fireRate)
		{
			if ( checkKey(' ') ) {
				bullet_normal();
			}
			if ( checkKey('z') ) {
				bullet_360();
			}
			if ( checkKey('x') ) {
				bullet_super();
			}
		}

		if (gameTime - lastHit >= timeToShake)
		{
			doShake = false;
		}
		
		accel = PVector.div(force, mass);
		velocity.add(PVector.mult(accel, timeDelta));
		pos.add(PVector.mult(velocity, timeDelta));
		force.x = force.y = 0;
		velocity.mult(0.99f);
	}

	void bullet_normal()
	{
		FriendlyBullet b = new FriendlyBullet(this, pos.x, pos.y, 10, theta);
		normalShot.rewind();
		normalShot.play();
		shipBullets.add(b);
		lastShot = gameTime;
	}

	void bullet_360()
	{
		float shotAngle = theta;
		while ( shotAngle - theta < TWO_PI )
		{
			FriendlyBullet b = new FriendlyBullet(this, pos.x, pos.y, 10, shotAngle);
			normalShot.rewind();
			normalShot.play();
			shipBullets.add(b);
			shotAngle += 0.1;
		}
		lastShot = gameTime;
	}

	void bullet_super()
	{
		FriendlyBullet b = new FriendlyBullet(this, pos.x, pos.y, 50, theta);
		loudShot.rewind();
		loudShot.play();
		shipBullets.add(b);
		lastShot = gameTime;
	}
}