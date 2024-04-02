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