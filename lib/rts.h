#pragma once

#include<inttypes.h>
#include<stdlib.h>
#include<stdio.h>

#include"sail.h"

/*
 * This function should be called whenever a pattern match failure
 * occurs. Pattern match failures are always fatal.
 */
void sail_match_failure(sail_string msg);

/*
 * sail_assert implements the assert construct in Sail. If any
 * assertion fails we immediately exit the model.
 */
unit sail_assert(bool b, sail_string msg);

unit sail_exit(unit);

/*
 * sail_get_verbosity reads a 64-bit value that the C runtime allows you to set
 * on the command line.
 * The intention is that you can use individual bits to turn on/off different
 * pieces of debugging output.
 */
mach_bits sail_get_verbosity(const unit u);

/*
 * Put processor to sleep until an external device calls wakeup_request().
 */
unit sleep_request(const unit u);

/*
 * Stop processor sleeping.
 * (Typically called when a device generates an interrupt.)
 */
unit wakeup_request(const unit u);

/*
 * Test whether processor is sleeping.
 * (Typically used to disable execution of instructions.)
 */
bool sleeping(const unit u);

/* ***** Memory builtins ***** */

void write_mem(uint64_t, uint64_t);
uint64_t read_mem(uint64_t);

// These memory builtins are intended to match the semantics for the
// __ReadRAM and __WriteRAM functions in ASL.

bool write_ram(const mpz_t addr_size,     // Either 32 or 64
	       const mpz_t data_size_mpz, // Number of bytes
	       const sail_bits hex_ram,       // Currently unused
	       const sail_bits addr_bv,
	       const sail_bits data);

void read_ram(sail_bits *data,
	      const mpz_t addr_size,
	      const mpz_t data_size_mpz,
	      const sail_bits hex_ram,
	      const sail_bits addr_bv);

unit write_tag_bool(const mach_bits, const bool);
bool read_tag_bool(const mach_bits);

unit load_raw(mach_bits addr, const sail_string file);

void load_image(char *);

/* ***** Tracing ***** */

/*
 * Bind these functions in Sail to enable and disable tracing (see
 * lib/trace.sail):
 *
 * val "enable_tracing" : unit -> unit
 * val "disable_tracing" : unit -> unit
 * val "is_tracing" : unit -> bool
 *
 * Compile with sail -c -c_trace.
 */
unit enable_tracing(const unit);
unit disable_tracing(const unit);

bool is_tracing(const unit);

/*
 * Tracing is implemented by void trace_TYPE functions, each of which
 * takes the Sail value to print as the first argument, and prints it
 * directly to stderr with no linebreaks.
 *
 * For types that don't have printing function we have trace_unknown,
 * which simply prints '?'. trace_argsep, trace_argend, and
 * trace_retend are used for formatting function arguments. They won't
 * overlap with user defined types because the type names used for
 * TYPE are zencoded. trace_start(NAME) and trace_end() are called
 * before printing the function arguments and return value
 * respectively.
*/
void trace_sail_int(const sail_int);
void trace_bool(const bool);
void trace_unit(const unit);
void trace_sail_string(const sail_string);
void trace_mach_bits(const mach_bits);
void trace_sail_bits(const sail_bits);

void trace_unknown(void);
void trace_argsep(void);
void trace_argend(void);
void trace_retend(void);
void trace_start(char *);
void trace_end(void);

/*
 * Functions for counting and limiting cycles
 */

// increment cycle count and test if over limit
bool cycle_limit_reached(const unit);

// increment cycle count and abort if over
unit cycle_count(const unit);

// read cycle count
void get_cycle_count(sail_int *rop, const unit);

/*
 * Functions to get info from ELF files.
 */

void elf_entry(sail_int *rop, const unit u);
void elf_tohost(sail_int *rop, const unit u);

int process_arguments(int, char**);

/*
 * setup_rts and cleanup_rts are responsible for calling setup_library
 * and cleanup_library in sail.h.
 */
void setup_rts(void);
void cleanup_rts(void);

unit z__SetConfig(sail_string, sail_int);
unit z__ListConfig(const unit u);
