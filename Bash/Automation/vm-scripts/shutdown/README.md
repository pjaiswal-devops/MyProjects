# VM Shutdown Script

This script attempts to gracefully shut down all running VMs. If a VM does not shut down after several attempts, it will forcefully stop it.

## Script Overview

- Graceful Shutdown: The script first tries to shut down each VM gracefully, retrying up to 6 times with 10-second intervals.
- Forced Shutdown: If a VM is still running or in an unexpected state, it will be forcefully stopped using `virsh destroy`.

## Customization Options

1. Adjust Retry and Sleep Intervals: Modify the `retries` or `sleep` values if your VMs require more or less time to shut down.
2. Additional Commands: After the final `if` condition, you can add commands to perform actions like taking backups or snapshots of the VMs to enhance the script's functionality.
3. Disable Forced Shutdown: Comment out the entire final `if` condition if you do not want to execute the `virsh destroy` command.

## Usage

Run the script with:

$ sudo bash shutdown-vms.sh