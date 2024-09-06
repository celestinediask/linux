# virt-manager
## Auto resize screen resolution
Note: may need spice-vdagent, gnome to work

View -> Scale display -> Always, Auto resize VM with window
## GPU Passthrough
### Video
Model: Virtio

3D accel: enable

### Display
Type: Spice Server

Listen Type: None

OpenGL: enable

## Use without root privilage (not secure)
> [!WARNING]
> Normal user can acces vm.

QEMU requires root privilege by default due to connection QEMU/KVM storage pool is in root. Add QEMU/KVM user session and delete the default connection. Now images are created in home directory instead of root.
