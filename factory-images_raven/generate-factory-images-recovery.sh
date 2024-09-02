#!/bin/sh

DEVICE=raven
BUILDDATE=$(date +%Y%m%d)
ZIPNAME=$DEVICE-factory-images-recovery-$BUILDDATE.zip
FASTBOOT_RECOVERY_FILES="vendor_boot.img boot.img dtbo.img android-info.txt fastboot-info.txt"

echo "Generating factory images recovery for $DEVICE"
echo "Build date: $BUILDDATE"
echo "Zip name: $ZIPNAME"

echo "Cleaning up old factory images recovery"
rm -rf ./device/google/raviole/factory-images_$DEVICE/recovery
mkdir -p ./device/google/raviole/factory-images_$DEVICE/recovery

echo "Copying recovery images from $OUT_DIR"
cp -r $OUT/boot.img $OUT/vendor_boot.img $OUT/dtbo.img device/google/raviole/factory-images_$DEVICE/recovery

echo "Generating fastboot flashing script"
# Generate fastboot-info.txt
cat << EOF > device/google/raviole/factory-images_$DEVICE/recovery/fastboot-info.txt
version 1
flash boot
flash dtbo
flash vendor_boot
if-wipe erase userdata
if-wipe erase metadata
reboot recovery
EOF

# Generate android-info.txt
echo "require board=$DEVICE" > device/google/raviole/factory-images_$DEVICE/recovery/android-info.txt

# Generate fastboot flashing script for linux
cat << EOF > device/google/raviole/factory-images_$DEVICE/recovery/flash-all.sh
#!/bin/sh

fastboot flash boot boot.img
fastboot flash dtbo dtbo.img
fastboot flash vendor_boot vendor_boot.img
fastboot reboot recovery
EOF

# Generate fastboot flashing script for windows
cat << EOF > device/google/raviole/factory-images_$DEVICE/recovery/flash-all.bat
@echo off
fastboot flash boot .\boot.img
fastboot flash dtbo .\dtbo.img
fastboot flash vendor_boot .\vendor_boot.img
fastboot reboot recovery
EOF

chmod +x device/google/raviole/factory-images_$DEVICE/recovery/flash-all.sh

cd device/google/raviole/factory-images_$DEVICE/recovery

echo "Zipping recovery images"
zip -r $ZIPNAME $FASTBOOT_RECOVERY_FILES

cd -

echo "Done ! Files can be found in device/google/raviole/factory-images_$DEVICE/recovery"
