LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY UltraSonic IS
	PORT (
		clk, echo : IN std_logic;
		ultra_clk, ultdist_led, ultdist : OUT std_logic
	);
END UltraSonic;

ARCHITECTURE UltraSonic_arch OF UltraSonic IS
	SIGNAL echo_time : INTEGER;
BEGIN
	PROCESS (clk)
	VARIABLE c1, c2 : INTEGER := 0;
	VARIABLE y : std_logic := '1';
	BEGIN
		IF rising_edge (clk) THEN
 
			IF (c1 = 0) THEN
				ultra_clk <= '1';
			ELSIF (c1 = 500) THEN--100us
				ultra_clk <= '0';
				y := '1';
			ELSIF (c1 = 5000000) THEN-- 100 ms
				c1 := 0;
				ultra_clk <= '1';
			END IF;
			c1 := c1 + 1;

			IF (echo = '1') THEN
				c2 := c2 + 1;
			ELSIF (echo = '0' AND y = '1') THEN-- I change the y to not get echo_time =0;
				echo_time <= c2;
				c2 := 0;
				y := '0';
			END IF;
			IF (echo_time < 10000) THEN--20 cm
				ultdist <= '1';
				ultdist_led <= '1';
			ELSE
				ultdist <= '0';
				ultdist_led <= '0';
			END IF;
		END IF;
	END PROCESS;
END UltraSonic_arch;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
PACKAGE UltraSonic_package IS
	COMPONENT UltraSonic
		PORT (
		clk, echo : IN std_logic;
		ultra_clk, ultdist_led, ultdist : OUT std_logic
		);
	END COMPONENT;
END UltraSonic_package;