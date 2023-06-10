library verilog;
use verilog.vl_types.all;
entity aftab_DARU_errorDetector is
    generic(
        size            : integer := 32
    );
    port(
        nBytes          : in     vl_logic_vector(1 downto 0);
        addrIn          : in     vl_logic_vector(1 downto 0);
        dataInstBar     : in     vl_logic;
        checkMisalignedDARU: in     vl_logic;
        instrMisalignedFlag: out    vl_logic;
        loadMisalignedFlag: out    vl_logic
    );
end aftab_DARU_errorDetector;
