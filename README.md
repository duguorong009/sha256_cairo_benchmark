# Sha256 hash funcion(cairo) benchmark

## How to run
1. Install the [`uv`](https://github.com/astral-sh/uv) tool
2. Clone the repo 
```
git clone https://github.com/duguorong009/sha256_cairo_benchmark.git
cd sha256_cairo_benchmark
```
3. Setup the environment
```
chmod +x setup.sh
./setup.sh
```
3. Try to run proving with STWO prover
```
chmod +x stwo_proving.sh
./stwo_proving.sh
```
## References
- https://github.com/cartridge-gg/cairo-sha256
- https://github.com/starkware-libs/stwo-cairo?tab=readme-ov-file#using-stwo-to-prove-cairo-programs
- https://docs.cairo-lang.org/cairozero/quickstart.html

## NOTE
1. Current sh scripts show correct performance metrics in only MacOS, not in ubuntu/linux.(Reason: `/usr/bin/time` util)
2. `stwo_verify.sh` file is not working atm. It outputs some weird error when verifying.