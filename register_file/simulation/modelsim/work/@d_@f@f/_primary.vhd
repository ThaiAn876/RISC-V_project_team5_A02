library verilog;
use verilog.vl_types.all;
entity D_FF is
    port(
        D               : in     vl_logic;
        CK              : in     vl_logic;
        i_rstn          : in     vl_logic;
        Q               : out    vl_logic
    );
end D_FF;
