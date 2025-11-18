# Lab 7: Counter Display System

## Project Description
This project implements a digital system on the Basys3 FPGA that counts upward from 0 to 4095 (12-bit) and displays the count on a four-digit seven-segment display.  
The design combines multiple modules:
- A **clock divider** that slows the 100 MHz FPGA clock for visible counting.
- A **12-bit up counter** that increments once per slow clock cycle and wraps around after 4095.
- A **binary-to-BCD converter** that uses the Double Dabble algorithm to convert the binary count into four BCD digits.
- A **multi-digit seven-segment display driver** that multiplexes the display to show the count in decimal format.
- A **top-level module** integrating all subsystems and handling reset and display control.

---

## Simulation Instructions
1. Open the project in Vivado.
2. Add the following Verilog files under *Simulation Sources*:
   - `up_counter.v`
   - `bin2bcd.v`
   - `multiseg_display.v`
   - `clk_divider.v`
   - `top_counter_display.v`
   - Any provided testbench files (e.g., `tb_up_counter.v`, `tb_bin2bcd.v`).
3. Run Behavioral Simulation.
4. Verify correct counting, binary-to-BCD conversion, and segment outputs in the waveform.

---

## FPGA Implementation Instructions
1. Add all Verilog design source files to Vivado.
2. Add the constraint file `top_counter_display.xdc` and ensure:
   - `clk` → Basys3 100 MHz clock pin (W5)
   - `reset` → Pushbutton (U18)
   - `seg[6:0]` and `an[3:0]` → Seven-segment display pins
3. Synthesize, implement, and generate bitstream.
4. Program the Basys3 board using the generated `.bit` file.
5. Observe the count on the four-digit display. The display should show the decimal count increasing up to 4095, then wrapping to 0000.

---

## Notes
- If the display updates appear unstable or jumpy, adjust the clock divider constant for a slower visible rate.
- Ensure all module port names match those in the constraint file.
- Reset should initialize the counter back to 0.

