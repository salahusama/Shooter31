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

	HealthBar healthBar;

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

		healthBar = new HealthBar(this);
	}

	void render()
	{
		noStroke();
		noFill();

		pushMatrix();

		translate(pos.x, pos.y);
		rotate(theta + HALF_PI);

		image(shipImg, -shipImg.width/2, - shipImg.height/2);
		
		popMatrix();

		healthBar.render();

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

class HealthBar
{
	Ship owner;

	float fullHealth;
	float theta;
	float diameter;

	HealthBar(Ship owner)
	{
		this.owner = owner;
		this.fullHealth = owner.health;
		this.diameter = owner.oWidth * 1.5;

		updateTheta();
	}

	void updateTheta()
	{
		// use health as fraction
		theta = (owner.health / fullHealth) * TWO_PI;
	}

	void render()
	{
		updateTheta();

		strokeWeight(5);
		noFill();
		
		if (theta > 1.5 * PI)
			stroke(0, 255, 0);
		else if (theta > HALF_PI)
			stroke(255, 255, 0);
		else
			stroke(255, 0, 0);

		arc(owner.pos.x, owner.pos.y, diameter, diameter, 0, theta);
	}
}