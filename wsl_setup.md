# WSL and Parallel MODFLOW

Instructions are provided here for setting up Ubuntu on the Windows Subsystem for Linux (WSL) to work with MODFLOW.

## Installing WSL
On a Windows machine it is relatively easy to get parallel MODFLOW compiled and running in a WSL Ubuntu virtual machine.

Install a latest version of Ubuntu.
```
  wsl --install -d Ubuntu-22.04
```

You will be asked to provide a username and password.  You'll need to remember this information for some future `sudo` operations.

## Clone the class repo

Clone the class repo in your WSL Ubuntu virtual machine after opening a WSL terminal using

```
git clone https://github.com/mjr-deltares/parallel-modflow-dsd23.git
```

## Setting up parallel MODFLOW 6 and pixi environment

In order to setting up you system execute:

```
./pixi run install
```

## Jupyter

Jupyter Lab can be started by executing:

```
./pixi run jupyter
```
