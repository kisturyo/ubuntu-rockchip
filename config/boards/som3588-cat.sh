# shellcheck shell=bash

export BOARD_NAME="Som3588 CAT"
export BOARD_MAKER="Som3588"
export BOARD_SOC="Rockchip RK3588"
export BOARD_CPU="ARM Cortex A76 / A55"
export UBOOT_PACKAGE="u-boot-radxa-rk3588"
export UBOOT_RULES_TARGET="som3588-cat-rk3588"
export COMPATIBLE_SUITES=("noble")
export COMPATIBLE_FLAVORS=("server" "desktop")

function config_image_hook__som3588-cat() {
    local rootfs="$1"
    local suite="$3"

    if [ "${suite}" == "jammy" ] || [ "${suite}" == "noble" ]; then
        # Install panthor mesa
        chroot "${rootfs}" add-apt-repository -y ppa:kisak/kisak-mesa
        chroot "${rootfs}" apt-get update
        chroot "${rootfs}" apt-get -y dist-upgrade

        # Install the rockchip camera engine
        # chroot "${rootfs}" apt-get -y install camera-engine-rkaiq-rk3588
    fi

    return 0
}
