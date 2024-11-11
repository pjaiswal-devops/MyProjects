#!/bin/bash
mapfile -t running_vms < <(sudo virsh list --state-running | tail -n +3 | awk '{print $2}' | grep -v '^$')

for item in "${running_vms[@]}"; do
  retries=6
  while [[ $retries -gt 0 ]]; do
    if [[ $(sudo virsh domstate "$item") == "running"  ]]; then
      echo "Attempting to shut down VM: $item (retries left: $retries)"
      sudo virsh shutdown "$item"
      ((retries--))
      sleep 10
    else
      echo "VM $item has shut down successfully."
      break
    fi
  done

  if [[ $(sudo virsh domstate "$item") == "running" || $(sudo virsh domstate "$item") != "in shutdown" ]]; then
    echo "Forcing shutdown of VM: $item"
    sudo virsh destroy "$item"
  fi
done
