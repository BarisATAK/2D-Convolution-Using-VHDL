library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Convolution_pkg IS
    TYPE integer_vector is ARRAY(integer RANGE <>) OF integer;
end;

use work.Convolution_pkg.ALL;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;

entity convolution is
    generic (i_width  :integer  := 5;
	     i_height :integer  := 5;
             k_width  :integer  := 3;
             k_height :integer  := 3);
    port (clock:in std_logic;
          new_img:out integer_vector (0 to 8)); --3*3
end convolution;

architecture Behavioral of convolution is
type krl_memory is array (0 to 2, 0 to 2) of integer;
constant krnl: krl_memory := (
          (1, 2, 1),
          (2, 1, 2),
          (1, 2, 1));
type img_memory is array (0 to 4, 0 to 4) of integer;
constant img: img_memory := (
          (2, 2, 1, 1, 1),
          (1, 1, 1, 1, 1),
          (2, 2, 1, 1, 1),
    	  (1, 1, 1, 1, 1),
          (3, 3, 1, 1, 1));
BEGIN   
    process (clock)
    variable sum :integer 	:= 0;
    variable n_i_width:integer  := i_width -(k_width-1);
    variable n_i_height:integer := i_height-(k_height-1);
	
    begin
    if(clock' event and clock='1')then
    	for y in 0 to (n_i_height-1) loop
	   for x in 0 to (n_i_width-1) loop
	   sum :=0;
	      for k_r in 0 to (k_height-1) loop
		 for k_c in 0 to (k_width-1) loop
		    sum := sum + img((y+k_r),(x+k_c)) * krnl(k_r,k_c); 	
		 end loop;
	      end loop;
	      new_img(y*(n_i_width)+x) <= sum;
	      end loop;
           end loop;
      end if;
      end process;
end Behavioral;
	