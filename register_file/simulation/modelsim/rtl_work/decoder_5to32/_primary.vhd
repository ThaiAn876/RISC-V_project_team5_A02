library verilog;
use verilog.vl_types.all;
entity decoder_5to32 is
    port(
        i_addr          : in     vl_logic_vector(4 downto 0);
        o_decode        : out    vl_logic_vector(31 downto 0)
    );
end decoder_5to32;
