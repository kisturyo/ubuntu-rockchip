# shellcheck shell=bash

export BOARD_NAME="Orange Pi CM5"
export BOARD_MAKER="Xulong"
export BOARD_SOC="Rockchip RK3588"
export BOARD_CPU="ARM Cortex A76 / A55"
export UBOOT_PACKAGE="u-boot-radxa-rk3588"
export UBOOT_RULES_TARGET="orangepi-cm5-rk3588s"
export COMPATIBLE_SUITES=("jammy" "noble")
export COMPATIBLE_FLAVORS=("server" "desktop")

function config_image_hook__orangepi-cm5() {
    local rootfs="$1"
    local suite="$3"

    if [ "${suite}" == "jammy" ] || [ "${suite}" == "noble" ]; then
        # Install panthor mesa
        chroot "${rootfs}" add-apt-repository -y ppa:kisak/kisak-mesa
        chroot "${rootfs}" apt-get update
        chroot "${rootfs}" apt-get -y dist-upgrade

        # Install the rockchip camera engine
        chroot "${rootfs}" apt-get -y install camera-engine-rkaiq-rk3588

        # Install wiring orangepi package 
        chroot "${rootfs}" apt-get -y install wiringpi-opi libwiringpi2-opi libwiringpi-opi-dev
        echo "BOARD=orangepicm5" > "${rootfs}/etc/orangepi-release"
    fi

    return 0
}
