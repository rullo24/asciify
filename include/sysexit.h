#ifndef SYSEXIT_H
#define SYSEXIT_H

// Success
#define EXIT_SUCCESS 0

// Argument/Usage Errors
#define EXIT_USAGE_ERROR 1           // Wrong arguments/usage

// File Errors
#define EXIT_FILE_NOT_FOUND 2        // Image file doesn't exist
#define EXIT_FILE_READ_ERROR 3       // Can't read file
#define EXIT_FILE_WRITE_ERROR 4      // Can't write output file
#define EXIT_PERMISSION_DENIED 5     // Permission denied

// Image Format Errors
#define EXIT_UNSUPPORTED_FORMAT 6    // Unsupported image format
#define EXIT_INVALID_FORMAT 7        // Invalid or corrupted format

// Image Data Errors
#define EXIT_INVALID_IMAGE 8         // Corrupted or invalid image data
#define EXIT_INVALID_DIMENSIONS 9    // Invalid image dimensions

// Memory/Resource Errors
#define EXIT_MEMORY_ERROR 10         // Out of memory

// I/O Errors
#define EXIT_IO_ERROR 11             // General I/O error

// Output Errors
#define EXIT_OUTPUT_ERROR 12         // Output error (terminal, stdout, etc.)

#endif