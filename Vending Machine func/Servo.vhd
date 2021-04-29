LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY Servo IS
	PORT (
		clk, btn, ultdist, cinfsig : IN std_logic;
		servo_clk,servo_clk2 : OUT std_logic
	);
END Servo;

ARCHITECTURE Servo_arch OF Servo IS
	SIGNAL yserv : std_logic := '1';
	SIGNAL inProcess : std_logic:= '0';
BEGIN
	PROCESS (clk)
	VARIABLE cservo,xserv : INTEGER := 0;
	VARIABLE cserv, c1serv : INTEGER := 0;
	BEGIN
		IF rising_edge (clk) THEN
			IF (inProcess = '0') THEN
				inProcess <= (NOT btn) AND cinfsig AND ultdist;
			END IF;
			IF (inProcess = '1') THEN
				IF (cservo < 10000000) THEN
					IF (yserv = '0') THEN
						IF (c1serv = 8000000) THEN-- 0.8s
							yserv <= '1';
							xserv := 0;
							c1serv := 0;
						ELSE
							c1serv := c1serv + 1;
						END IF;
					END IF;
					IF (cserv = 200000) THEN -- 20 ms
						cserv := 0;
					ELSE
						cserv := cserv + 1;
					END IF;
					IF (yserv = '1') THEN
						IF (cserv < 13000) THEN --1ms
							servo_clk <= '1';
							xserv := xserv+1;
						ELSE
							servo_clk <= '0';
						END IF;
					END IF;
					IF (xserv = 1 AND cserv = 200000) THEN --20ms
						yserv <= '0';
					END IF;
 
				ELSIF (cservo > 18000000 AND cservo < 28000000) THEN
 
					IF (yserv = '0') THEN
						IF (c1serv = 8000000) THEN-- 0.8s
							yserv <= '1';
							xserv := 0;
							c1serv := 0;
						ELSE
							c1serv := c1serv + 1;
						END IF;
					END IF;
					IF (cserv = 200000) THEN -- 20 ms
						cserv := 0;
					ELSE
						cserv := cserv + 1;
					END IF;
					IF (yserv = '1') THEN
						IF (cserv < 21000) THEN -- 2ms
							servo_clk <= '1';
							xserv := xserv+1;
						ELSE
							servo_clk <= '0';
						END IF;
						IF (xserv = 1 AND cserv = 200000) THEN --20ms
							yserv <= '0';
						END IF;
					END IF;
					ELSIF (cservo > 38000000 AND cservo < 48000000) THEN
					IF (yserv = '0') THEN
						IF (c1serv = 8000000) THEN-- 0.8s
							yserv <= '1';
							xserv := 0;
							c1serv := 0;
						ELSE
							c1serv := c1serv + 1;
						END IF;
					END IF;
					IF (cserv = 200000) THEN -- 20 ms
						cserv := 0;
					ELSE
						cserv := cserv + 1;
					END IF;
					IF (yserv = '1') THEN
						IF (cserv < 20000) THEN --2ms
							servo_clk2 <= '1';
							xserv := xserv+1;
						ELSE
							servo_clk2 <= '0';
						END IF;
					END IF;
					IF (xserv = 1 AND cserv = 200000) THEN --20ms
						yserv <= '0';
					END IF;
 
				ELSIF (cservo > 56000000 AND cservo < 66000000) THEN
 
					IF (yserv = '0') THEN
						IF (c1serv = 8000000) THEN-- 0.8s
							yserv <= '1';
							xserv := 0;
							c1serv := 0;
						ELSE
							c1serv := c1serv + 1;
						END IF;
					END IF;
					IF (cserv = 200000) THEN -- 20 ms
						cserv := 0;
					ELSE
						cserv := cserv + 1;
					END IF;
					IF (yserv = '1') THEN
						IF (cserv < 10000) THEN -- 2ms
							servo_clk2 <= '1';
							xserv := xserv+1;
						ELSE
							servo_clk2 <= '0';
						END IF;
						IF (xserv = 1 AND cserv = 200000) THEN --20ms
							yserv <= '0';
						END IF;
					END IF;
 
				END IF;
				IF (cservo = 70000000) THEN
					cservo := 0;
					inProcess <= '0';
				ELSE
					cservo := cservo + 1;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END Servo_arch;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
PACKAGE Servo_package IS
	COMPONENT Servo
		PORT (
		clk, btn, ultdist, cinfsig : IN std_logic;
		servo_clk,servo_clk2 : OUT std_logic
		);
	END COMPONENT;
END Servo_package;