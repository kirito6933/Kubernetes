#!/bin/bash
#Script Daemon Docker et Kuberlet
systemctl enable --now docker
systemctl enable --now kubelet
systemctl disable --now firewalld
done

