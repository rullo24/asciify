// system includes
#include <stdio.h>

// user includes
#include "sysexit.h"

int main(int argc, char **argv) {

    // safety check - only allow program + image or program + help flag
    if (argc != 2) {
        perror("Usage: ./asciify <image_path> or ./asciify -h");
        return EXIT_USAGE_ERROR;
    }

    (void)argv;

    return EXIT_SUCCESS;
}