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

	Ship(float x, float y)
	{
		super(x, y);
		velocity = new PVector(0, 0);
		forward = new PVector(0, -1);
		accel = new PVector(0, 0);
		force = new PVector(0, 0);
		
		power = 300;
		mass = 1;
		theta = 0;
		shipImg = loadImage("ship.png");
	}

	void render()
	{
		stroke(255);
		strokeWeight(10);
		noFill();

		pushMatrix();

		translate(pos.x, pos.y);
		rotate(theta + HALF_PI);
		
		ellipse(0, 0, 1.2 * shipImg.width, 1.2 * shipImg.height);
		image(shipImg, -shipImg.width/2, - shipImg.height/2);
		
		popMatrix();
	}

	void update()
	{
		forward.x = sin(theta);
		forward.y  = -cos(theta);
		
		if ( checkKey('w') ) {
			force.add(PVector.mult(forward, power));      
		}
		if ( checkKey('s') ) {
			force.add(PVector.mult(forward, -power));      
		}
		if ( checkKey('a') ) {
			theta -= 0.1f;
		}
		if ( checkKey('d') ) {
			theta += 0.1f;
		}
		/*
		if ( checkKey(' ') )
		{
			Bullet b = new Bullet(pos.x, pos.y, theta, 20, 5);
			bullets.add(b);
		}
		*/
		
		accel = PVector.div(force, mass);
		velocity.add(PVector.mult(accel, timeDelta));
		pos.add(PVector.mult(velocity, timeDelta));
		force.x = force.y = 0;
		velocity.mult(0.99f);
	}
}