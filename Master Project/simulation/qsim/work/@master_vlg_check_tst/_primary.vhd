library verilog;
use verilog.vl_types.all;
entity Master_vlg_check_tst is
    port(
        AUD_ADCLRCK     : in     vl_logic;
        AUD_BCLK        : in     vl_logic;
        AUD_DACDAT      : in     vl_logic;
        AUD_DACLRCK     : in     vl_logic;
        AUD_XCK         : in     vl_logic;
        HEX0            : in     vl_logic_vector(6 downto 0);
        HEX1            : in     vl_logic_vector(6 downto 0);
        HEX2            : in     vl_logic_vector(6 downto 0);
        HEX3            : in     vl_logic_vector(6 downto 0);
        HEX4            : in     vl_logic_vector(6 downto 0);
        HEX5            : in     vl_logic_vector(6 downto 0);
        HEX6            : in     vl_logic_vector(6 downto 0);
        HEX7            : in     vl_logic_vector(6 downto 0);
        I2C_SCLK        : in     vl_logic;
        I2C_SDAT        : in     vl_logic;
        LCD_DATA        : in     vl_logic_vector(7 downto 0);
        LCD_EN          : in     vl_logic;
        LCD_ON          : in     vl_logic;
        LCD_RS          : in     vl_logic;
        LCD_RW          : in     vl_logic;
        LEDG            : in     vl_logic_vector(8 downto 0);
        LEDR            : in     vl_logic_vector(17 downto 0);
        sampler_rx      : in     vl_logic
    );
end Master_vlg_check_tst;
