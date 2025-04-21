#!/bin/bash

set -e

# Configuration
STWO_REPO="https://github.com/starkware-libs/stwo-cairo.git"
STWO_DIR="stwo-cairo"
PROVER_DIR="$STWO_DIR/stwo_cairo_prover"

SHA256_BENCHMARK_FILE="src/main.cairo"

BUILD_DIR="build"
COMPILED_FILE="build/main_compiled.json"
TRACE_FILE="build/trace.bin"
MEMORY_FILE="build/memory.bin"
PUB_INPUT="build/air_public_inputs.json"
PRIV_INPUT="build/air_private_inputs.json"
PROOF_FILE="build/proof.json"

if [ ! -d "$BUILD_DIR" ]; then
  echo "Creating build directory..."
  mkdir build
fi

# Step 0: Activate virtual environment
source .venv/bin/activate

# Step 1: Compile the Cairo program
echo "Compiling $SHA256_BENCHMARK_FILE..."
cairo-compile $SHA256_BENCHMARK_FILE --output $COMPILED_FILE --proof_mode

# Step 2: Run the program and generate execution trace
echo "Running the Cairo program..."
cairo-run --program=$COMPILED_FILE \
          --layout=starknet \
          --trace_file=$TRACE_FILE \
          --memory_file=$MEMORY_FILE \
          --air_public_input=$PUB_INPUT \
          --air_private_input=$PRIV_INPUT \
          --proof_mode

# Step 3: Clone stwo-cairo repository
if [ ! -d "$STWO_DIR" ]; then
  echo "Cloning stwo-cairo repository..."
  git clone $STWO_REPO
fi

# Step 4: Generate STARK proof using Stwo
echo "Generating STARK proof with Stwo..."
cd $PROVER_DIR
cargo run --bin adapted_stwo --release -- \
  --pub_json ../../$PUB_INPUT \
  --priv_json ../../$PRIV_INPUT \
  --proof_path ../../$PROOF_FILE

echo "Proving completed. Proof saved to $PROOF_FILE"
