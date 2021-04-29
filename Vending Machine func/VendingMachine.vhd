9LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.UltraSonic_package.ALL;
USE work.InfraRed_package.ALL;
USE work.Servo_package.ALL;
ENTITY vendingMachine IS
	PORT (
		clk, infra, btn, echo : IN std_logic;
		servo_clk,servo_clk2, ultra_clk, cinfsig_led, ultdist_led : OUT std_logic
	);
END vendingMachine;

ARCHITECTURE vending_machine_arch OF vendingMachine IS
	SIGNAL ultdist, cinfsig : std_logic;
	SIGNAL yserv : std_logic := '1';
	SIGNAL echo_time : INTEGER;
BEGIN
	stageUltraSonic : UltraSonic
	PORT MAP(clk, echo, ultra_clk, ultdist_led, ultdist);
	stageInfraRed : InfraRed
	PORT MAP(clk, infra, cinfsig, cinfsig_led);
	stageServo : Servo
	PORT MAP(clk, btn, ultdist, cinfsig, servo_clk,servo_clk2);
END vending_machine_arch;