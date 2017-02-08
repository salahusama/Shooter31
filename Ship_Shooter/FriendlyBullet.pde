class FriendlyBullet extends Bullet
{
	Ship parent;

	FriendlyBullet(Ship parent, float x, float y, float strength, float theta)
	{
		super(x + (parent.shipImg.width + strength/2) * sin(theta), y + (parent.shipImg.height + strength/2) * -cos(theta), strength, theta);
		this.parent = parent;
	}

	void render()
	{
		strokeWeight(3);
		stroke(0, 0, 250);
		fill(180, 255, 255, 255);

		super.render();
	}
}