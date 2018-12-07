library verilog;
use verilog.vl_types.all;
entity DataPath is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        end_of_pixel    : in     vl_logic;
        mux_first1_sel  : in     vl_logic_vector(1 downto 0);
        mux_first2_sel  : in     vl_logic;
        mux_end1_sel    : in     vl_logic_vector(1 downto 0);
        mux_end2_sel    : in     vl_logic;
        r_addr          : in     vl_logic_vector(17 downto 0);
        w_addr          : in     vl_logic_vector(17 downto 0);
        shift_enb       : in     vl_logic
    );
end DataPath;
