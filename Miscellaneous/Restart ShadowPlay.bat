@echo off
net stop NVDisplay.ContainerLocalSystem
net stop NvContainerLocalSystem
net stop NvContainerNetworkService
net start NVDisplay.ContainerLocalSystem
net start NvContainerLocalSystem
net start NvContainerNetworkService