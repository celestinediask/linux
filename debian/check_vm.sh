#!/bin/bash

# Function to check for common VM indicators
check_vm() {
    # Check for VM-specific files or directories
    if [ -d "/proc/vz" ] || [ -f "/proc/xen/capabilities" ] || [ -d "/proc/xen" ]; then
        return 0
    fi

    # Check for VM-specific kernel modules
    if lsmod | grep -iq 'vbox\|vmw_balloon\|vmxnet\|xen\|virtio'; then
        return 0
    fi

    # Check CPU info for VM indicators
    if grep -iq 'hypervisor\|qemu\|kvm' /proc/cpuinfo; then
        return 0
    fi

    # Check system manufacturer
    if [ -f "/sys/class/dmi/id/sys_vendor" ]; then
        vendor=$(cat /sys/class/dmi/id/sys_vendor)
        case "$vendor" in
            *VMware*|*Microsoft*|*QEMU*|*Xen*|*innotek*GmbH*)
                return 0
                ;;
        esac
    fi

    # Check for hypervisor bit in CPU flags
    if grep -q "^flags.*hypervisor" /proc/cpuinfo; then
        return 0
    fi

    # Check for VM-specific devices
    if ls /dev/vd[a-z] > /dev/null 2>&1 || ls /dev/xvd[a-z] > /dev/null 2>&1; then
        return 0
    fi

    # If none of the above checks indicate a VM, assume it's not a VM
    return 1
}

# Main script execution
if check_vm; then
    echo "This system is running in a virtual machine."
else
    echo "This system is likely running on physical hardware."
fi
