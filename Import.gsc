// Taken from Avalanche
spinWeaponDrop()
{
	while(isDefined(self)) {
		self rotateTo((self.angles[0], self.angles[1]+90, self.angles[2]), .3);
		wait .3;
	}
}






























