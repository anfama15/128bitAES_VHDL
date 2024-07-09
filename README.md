
# AES Encryption and Decryption Modules

This repository contains VHDL implementations of various modules used in the Advanced Encryption Standard (AES) algorithm. These modules support both encryption and decryption processes.

## Table of Contents

1. [SubBytes Module](#subbytes-module)
2. [ShiftRows Module](#shiftrows-module)
3. [ShiftColumns Module](#shiftcolumns-module)
4. [AddRoundKeys Module](#addroundkeys-module)
5. [Key Schedule Module](#key-schedule-module)
6. [AES_ENC Module](#aes_enc-module)
7. [AES Decryption Module](#aes-decryption-module)

## SubBytes Module

The SubBytes transformation uses an S-box LUT to replace each byte in the input state with a corresponding byte from the S-box, supporting both encryption and decryption.

### Ports
- **inverse**: Single-bit input signal indicating direct (`0`) or inverse (`1`) transformation.
- **i_state**: 128-bit input state matrix.
- **o_state**: 128-bit output state matrix after transformation.

### Functionality
- **Forward Transformation**: Substitutes bytes using the S-box.
- **Inverse Transformation**: Substitutes bytes using the inverse S-box.

### High-Level Block Diagram
A block diagram consists of 32 S-box LUTs (16 for encryption and 16 for decryption) and 2x1 MUX for selecting the output based on the inverse condition.

## ShiftRows Module

The ShiftRows transformation cyclically shifts the rows of the state array for encryption or decryption.

### Ports
- **clk**: Clock signal.
- **inverse**: Select signal for normal (`0`) or inverse (`1`) transformation.
- **State_array_In**: 128-bit input state array.
- **new_state_array**: 128-bit output state array.

### Functionality
- **Normal Transformation**: Shifts rows to the left.
- **Inverse Transformation**: Shifts rows to the right.

### High-Level Block Diagram
A block diagram showing multiplexers performing standard or inverse ShiftRows operation based on the inverse signal.

## ShiftColumns Module

Handles the MixColumns step, mixing data within each column of the state array for diffusion.

### Ports
- **state_array_in**: 128-bit input state array.
- **inverse**: Control signal for forward or inverse MixColumns operation.
- **output**: 128-bit transformed state array.

### Functionality
- **Forward Transformation**: Multiplies elements by 2 and 3.
- **Inverse Transformation**: Multiplies elements by 9, 11, 13, and 14.

## AddRoundKeys Module

Handles the AddRoundKey step, performing a bitwise XOR operation between the round key and state array.

### Ports
- **input_key**: 128-bit round key.
- **state_array**: 128-bit state array.
- **output**: 128-bit result of XOR operation.

## Key Schedule Module

Expands the provided secret key into round keys used throughout the AES encryption/decryption process.

### Ports
- **clk**: Clock signal.
- **rst**: Reset signal.
- **key_in**: 128-bit input key.
- **key_s0** to **key_s10**: Outputs representing the eleven 128-bit round keys.

## AES_ENC Module

The top-level module for AES encryption, performing multiple rounds of operations.

### Ports
- **clk**: Clock signal.
- **rst**: Reset signal.
- **inverse**: Signal indicating encryption (`0`) or decryption (`1`).
- **key_in**: 128-bit key.
- **plain_text**: 128-bit input data.
- **ciphertext**: 128-bit output data.
- **SubBytes_output**, **ShiftRows_output**, **ShiftColumns_output**: Temporary outputs for debugging.

## AES Decryption Module

Top-level module for AES decryption, utilizing the AES_ENC component with an additional control signal.

### Ports
- **clk**: Clock signal.
- **rst**: Reset signal.
- **key_in**: 128-bit input key.
- **plain_text**: Placeholder input (not used in decryption).
- **ciphertext**: 128-bit encrypted data.
- **decrypted_text**: 128-bit decrypted data.

### Functionality
- Reuses AES_ENC component for decryption with an additional control signal.
