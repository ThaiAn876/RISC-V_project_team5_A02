# Register file

## Cấu trúc

- `rtl/`: register file và các module phụ (`D_FF`, `reg_32bit`, decoder,
  mux).
- `tb/`: testbench `tb_Register_file.sv`.
- `simulation/modelsim/`: script chạy mô phỏng ModelSim.
- `Register_file.qpf` / `Register_file.qsf`: project Quartus.

Top-level module là `Register_file`.
