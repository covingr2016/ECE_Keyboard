library verilog;
use verilog.vl_types.all;
entity Master_vlg_sample_tst is
    port(
        AUD_ADCDAT      : in     vl_logic;
        AUD_ADCLRCK     : in     vl_logic;
        AUD_BCLK        : in     vl_logic;
        AUD_DACLRCK     : in     vl_logic;
        CLK_50MHz       : in     vl_logic;
        I2C_SDAT        : in     vl_logic;
        KEY             : in     vl_logic_vector(2 downto 0);
        PS2_CLK         : in     vl_logic;
        PS2_DAT         : in     vl_logic;
        SW              : in     vl_logic_vector(17 downto 0);
        TD_CLK27        : in     vl_logic;
        resetn          : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Master_vlg_sample_tst;
