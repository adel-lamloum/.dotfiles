#!/bin/bash

# Run clipse and capture its output
clipse_output=$(clipse)

# Convert the output to JSON (this is just an example, adjust as needed)
echo "{ \"text\": \"$clipse_output\", \"tooltip\": \"clipse output\" }"
