library verilog;
use verilog.vl_types.all;
entity aftab_DAWU_errorDetector is
    generic(
        size            : integer := 32
    );
    port(
        nBytes          : in     vl_logic_vector(1 downto 0);
        addrIn          : in     vl_logic_vector(1 downto 0);
        checkMisalignedDAWU: in     vl_logic;
        storeMisalignedFlag: out    vl_logic
    );
end aftab_DAWU_errorDetector;
