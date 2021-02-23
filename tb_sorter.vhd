------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------------------------------------------
-- test bench 
entity tb_sorter is 
end tb_sorter;
------------------------------------------------------------------------------------------------------------
--step1: declare the component that wil be tested
architecture driver of tb_sorter is 
    
    component sorter
        
        port (clk: in std_logic;
            reset: in std_logic;
            weight : in std_logic_vector(11 downto 0);

            currentGroup : out std_logic_vector(2 downto 0);
            Grp1, Grp2, Grp3, Grp4, Grp5, Grp6 : out std_logic_vector(7 downto 0));
  
    end component;

    --step2: declare the tb signals
    signal tb_clk : std_logic := '0'; 
    signal tb_reset : std_logic := '0'; 
    signal tb_weight : unsigned(11 downto 0):="000000000000";
    
    signal tb_Grp1 :  std_logic_vector (7 downto 0) := "00000000";
    signal tb_Grp2 :  std_logic_vector (7 downto 0) := "00000000";
    signal tb_Grp3 :  std_logic_vector (7 downto 0) := "00000000";
    signal tb_Grp4 :  std_logic_vector (7 downto 0) := "00000000";
    signal tb_Grp5 :  std_logic_vector (7 downto 0) := "00000000";
    signal tb_Grp6 :  std_logic_vector (7 downto 0) := "00000000";

    
    signal tb_currentGroup : std_logic_vector (2 downto 0) := "000";
    --signal decimalweight : integer := 0;

-- step3: unit under test instantiation
begin 
    
    UUT: sorter port map(
        
        clk =>tb_clk,
        reset =>tb_reset,
        weight => std_logic_vector(tb_weight),


        Grp1 => tb_Grp1,
        Grp2 => tb_Grp2,
        Grp3 => tb_Grp3,
        Grp4 => tb_Grp4,
        Grp5 => tb_Grp5,
        Grp6 => tb_Grp6,

        currentGroup =>tb_currentGroup

    );

    tb_reset <= '0';
    tb_clk <= '1' after 0 ns, '0' after 10 ns , '1' after 20 ns, '0' after 30 ns, '1' after 40 ns, '0' after 50 ns, '1' after 60 ns, '0' after 70 ns, '1' after 80 ns, '0' after 90 ns, '1' after 100 ns, '0' after 110 ns, '1' after 120 ns, '0' after 130 ns;
                                                --^STARTS                         --^CATCHES                        
    pp : process
    begin 

        --tb_clk <= '1';
        --decimalweight <= 50;
        --wait for 10 ns;

        tb_weight <= "000001100100"; --// 100
        wait for 20 ns;

        tb_weight <= "000000000000"; --// 0
        wait for 20 ns;

        tb_weight <= "000110010000"; --// 400
        wait for 20 ns;

        tb_weight <= "000000000000"; --// 0
        wait for 20 ns;

        tb_weight <= "001110000100"; --// 900
        wait for 20 ns;

        tb_weight <= "001101100110"; --// 870
        wait for 20 ns;


    end process;

    --// tb_reset<= '1' after 50 ns;
    
    --// decimalweight <= 0 after 1 ns , 1150 after 20 ns,0 after 30 ns, 300 after 40 ns, 0 after 50 ns ,501 after 60 ns, 512 after 80 ns;
    --// tb_weight <= to_unsigned(decimalweight, 12) after 1 ns;


end driver;
--}
------------------------------------------------------------------------------------------------------------