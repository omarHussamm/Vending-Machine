LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY InfraRed IS
	PORT (
		clk, infra : IN std_logic;
		cinfsig : BUFFER std_logic;
		cinfsig_led : OUT std_logic
	);
END InfraRed;

ARCHITECTURE InfraRed_arch OF InfraRed IS
BEGIN
	PROCESS (clk)
	VARIABLE cinf : INTEGER := 0;
	BEGIN
		IF rising_edge (clk) THEN

			IF (infra = '0' OR cinfsig = '1') THEN
				IF (cinf < 100000000) THEN --10secs
					cinf := cinf + 1;
					cinfsig <= '1';
					cinfsig_led <= '1';
				ELSE
					cinf := 0;
					cinfsig <= '0';
					cinfsig_led <= '0';
				END IF;
			END IF;
		END IF; 
	END PROCESS;
END InfraRed_arch;
	
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
PACKAGE InfraRed_package IS
	COMPONENT InfraRed
		PORT (
		clk, infra : IN std_logic;
		cinfsig : BUFFER std_logic;
		cinfsig_led : OUT std_logic
		);
	END COMPONENT;
END InfraRed_package;