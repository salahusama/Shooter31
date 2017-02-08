class EnemyBullet extends Bullet
{
	Enemy parent;

	EnemyBullet(Enemy parent, float x, float y, float strength, float theta)
	{
		super(x + (parent.oWidth + strength/2) * sin(theta), y + (parent.oHeight + strength/2) * -cos(theta), strength, theta);
		this.parent = parent;
	}

	void render()
	{
		strokeWeight(3);
		stroke(250, 0, 00);
		fill(255, 255, 180);

		super.render();
	}
}