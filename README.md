# Image Compression Batch Script

This repository contains a batch script for compressing `.tiff` images using `gdal_translate` and `gdaladdo` tools.

## Description

The script processes all `.tiff` files in a specified input directory, compresses them, and saves the compressed images in an output directory.

## Usage

1. Modify the `input_folder` and `output_folder` variables to your desired directories.
2. Run the batch script in a command prompt with administrative privileges.

## Script Content

@echo off
setlocal enabledelayedexpansion

set "input_folder=D:\ImageProcessing\Images"
set "output_folder=D:\ImageProcessing\compressedimages"

for %%i in ("%input_folder%\*.tiff") do (
    set "input_file=%%i"
    set "output_file=!output_folder!\%%~ni_compressed.tiff"

    gdal_translate -a_srs EPSG:21037 -of GTiff -co COMPRESS=JPEG -co JPEG_QUALITY=75 -co PHOTOMETRIC=RGB -co TILED=YES "!input_file!" "!output_file!" && (
        gdaladdo -r average "!output_file!" 2 4 8 16 32 64 128 256 512 1024
    )
)

endlocal
