# RailOS Chocolatey Package
Allows the installation of RailOS via the [Chocolatey Package Manager](https://community.chocolatey.org/) for Windows. The setup will install RailOS into `C:\Program Files\RailwayOperationSimulator`. 

The package is published to the Chocolatey repository, with the following commands being available:

## Install
```pwsh
choco install railwayopsim [--params="'/InstallDir=<INSTALL-DIRECTORY>'"]
```

## Uninstall
```pwsh
choco uninstall railwayopsim [--params="'/InstallDir=<INSTALL-DIRECTORY>'"]
```

## Upgrade
```pwsh
choco upgrade railwayopsim [--params="'/InstallDir=<INSTALL-DIRECTORY>'"]
```
