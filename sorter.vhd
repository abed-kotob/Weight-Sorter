------------------------------------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------------------------------------------------------------------------------
--we begin by creating the weight sorter entity and assign the ports to the required types
entity sorter is --{
    
    port( clk : in std_logic;
          reset : in std_logic;
          weight : in std_logic_vector(11 downto 0);

          currentGroup : out std_logic_vector(2 downto 0);
          Grp1, Grp2, Grp3, Grp4, Grp5, Grp6 : out std_logic_vector(7 downto 0));

    end sorter;
--}
------------------------------------------------------------------------------------------------------------
architecture beh of sorter is 
--we initiate an internal signals that we will operate on and assign the inputs to them

    signal in_weight : unsigned (11 downto 0);

    --signal G1 : unsigned (7 downto 0) := "00000000"; --// have to integrate an integer representation somewhere
    --signal G2 : unsigned (7 downto 0) := "00000000";
    --signal G3 : unsigned (7 downto 0) := "00000000";
    --signal G4 : unsigned (7 downto 0) := "00000000";
    --signal G5 : unsigned (7 downto 0) := "00000000";
    --signal G6 : unsigned (7 downto 0) := "00000000";

    signal gg1 : integer range 0 to 255 := 0; 
    signal gg2 : integer range 0 to 255 := 0;
    signal gg3 : integer range 0 to 255 := 0;
    signal gg4 : integer range 0 to 255 := 0;
    signal gg5 : integer range 0 to 255 := 0;
    signal gg6 : integer range 0 to 255 := 0; --// note: 8 bit group counters --> 2^8 capacity --> 0 to 255

    signal curr : unsigned (2 downto 0) := "000";
    --signal takeoff : std_logic := '1';
    --signal prev_weight : unsigned (11 downto 0) := to_unsigned(0,12); --// which means that takeoff initally 1 
    signal total_weight : unsigned (11 downto 0) := to_unsigned(0, 12);

begin 

    --p0: process (weight, clk)
    --begin
        --// check if the new weight, weight, is not zero and the old weight, in_weight, is not zero as well
        --// if that was the case, then takeoff is false --> takeoff = '0' 
        --// else: takeoff = '1' since we do not have two consecutive nonzero weights

        --if (prev_weight = "000000000000")then   takeoff<= '1';
        --else takeoff<= '0'; --end if;

        --if (rising_edge(clk))then if (weight /= "000000000000")then prev_weight <= unsigned(weight); end if; end if;
        --if (falling_edge(clk))then prev_weight <= "000000000000"; end if;
    --end process;


    --we create a process to run this operation and the process is triggered
    --note that we could have implemented variables as well rather than signals

    p1: process (weight, clk, reset)
    begin
        
        if (reset = '1') then
                
            gg1<= 0; --(others=> '0');
            gg2<= 0; --(others=> '0');
            gg3<= 0; --(others=> '0');
            gg4<= 0; --(others=> '0');
            gg5<= 0; --(others=> '0');
            gg6<= 0; --(others=> '0');
            
            curr<= (others=> '0');
            in_weight<= to_unsigned(0, 12); --// reset to 0 in unsigned 

        elsif (rising_edge(clk)) then

            in_weight <= unsigned(weight);
            --if (takeoff = '0') then 
            --in_weight <= unsigned(weight) + unsigned(weight); end if; --// this will help us know what is currGroup
            
            if (to_integer(in_weight) = 0)then total_weight <= "000000000000"; 
                else --// in_weight = X
                
                if (total_weight = "000000000000")then 

--# START DEALING WITH THE GROUPS [in_weight = X and total weight = 0 so this new weight is frist to be added and thus is the incrementing factor]

                    if (to_integer(unsigned(weight))>= 1 and to_integer(unsigned(weight))<=200)then
                        --if (takeoff = '1')then 
                        --if (prev_weight = "000000000000")then  
                        gg1<= (gg1+1) mod 256;
                        --end if;
                        --curr<= "001";
                        --we assign to curren the binary value of 1 ie group 1

                        elsif(to_integer(unsigned(weight))>= 201 and to_integer(unsigned(weight))<=500)then
                            --if (takeoff = '1')then 
                            gg2<= (gg2+1) mod 256; 
                            --end if;
                            --curr<="010";

                        elsif(to_integer(unsigned(weight))>= 501 and to_integer(unsigned(weight))<=800)then
                            --if (takeoff = '1')then 
                            gg3<= (gg3+1) mod 256; 
                            --end if;
                            --curr<= "011";

                        elsif(to_integer(unsigned(weight))>= 801 and to_integer(unsigned(weight))<=1000)then
                            --if (takeoff = '1')then 
                            gg4<= (gg4+1) mod 256; 
                            --end if;
                            --curr<= "100";

                        elsif(to_integer(unsigned(weight))>= 1001 and to_integer(unsigned(weight))<=2000)then
                            --if (takeoff = '1')then 
                            gg5<= (gg5+1) mod 256; 
                            --end if;
                            --curr<= "101";

                        elsif(to_integer(unsigned(weight))>= 2001)then
                            --if (takeoff = '1')then
                            gg6<= (gg6+1) mod 256; 
                            --end if;
                            --curr<= "110";

                        else
                            
                            --G1<= to_unsigned(gg1, 8); 
                            --G2<= to_unsigned(gg2, 8); 
                            --G3<= to_unsigned(gg3, 8); 
                            --G4<= to_unsigned(gg4, 8); 
                            --G5<= to_unsigned(gg5, 8); 
                            --G6<= to_unsigned(gg6, 8);
                            --curr<= curr;
                            
                            gg1 <= gg1;
                            gg2 <= gg2;
                            gg3 <= gg3;
                            gg4 <= gg4;
                            gg5 <= gg5;
                            gg6 <= gg6;
                            --curr<= curr;
                            --this is to make sure that there is no implied memory and that if the above conditions are not satisfied the counters will remain the same
                        
                    end if;

                end if;
                
                --// essentially:
                total_weight <= (total_weight + in_weight);
            
            end if;

--# HERE ONLY DEAL WITH CURRentGROUP

            if (to_integer(in_weight) = 0) then
                curr<= "000";
            elsif (to_integer(total_weight)>= 1 and to_integer(total_weight)<=200)then
                curr<= "001";
                --we assign to curren the binary value of 1 ie group 1

            elsif(to_integer(total_weight)>= 201 and to_integer(total_weight)<=500)then
                curr<="010";

            elsif(to_integer(total_weight)>= 501 and to_integer(total_weight)<=800)then
                curr<= "011";

            elsif(to_integer(total_weight)>= 801 and to_integer(total_weight)<=1000)then
                curr<= "100";

            elsif(to_integer(total_weight)>= 1001 and to_integer(total_weight)<=2000)then
                curr<= "101";

            elsif(to_integer(total_weight)>= 2001)then
                curr<= "110";


            end if;
        

        end if;

        
    end process;

    Grp1<= std_logic_vector(to_unsigned(gg1, 8)); 
    Grp2<= std_logic_vector(to_unsigned(gg2, 8)); 
    Grp3<= std_logic_vector(to_unsigned(gg3, 8));
    Grp4<= std_logic_vector(to_unsigned(gg4, 8)); 
    Grp5<= std_logic_vector(to_unsigned(gg5, 8)); 
    Grp6<= std_logic_vector(to_unsigned(gg6, 8));
    
    --/*seems useless*/  weight<= std_logic_vector(in_weight);
    --/*alternatively*/  in_weight<= unsigned(weight);   /*but equally useless*/
    
    currentGroup<= std_logic_vector(curr);
    

end beh;
------------------------------------------------------------------------------------------------------------