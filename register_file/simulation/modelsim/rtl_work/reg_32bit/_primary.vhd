library verilog;
use verilog.vl_types.all;
entity reg_32bit is
    port(
        reg_CK          : in     vl_logic;
        i_rstn          : in     vl_logic;
        D_in            : in     vl_logic_vector(31 downto 0);
        en              : in     vl_logic;
        Q_out           : out    vl_logic_vector(31 downto 0)
    );
end reg_32bit;
