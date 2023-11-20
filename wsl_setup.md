# WSL and Parallel MODFLOW

Instructions are provided here for setting up Ubuntu on the Windows Subsystem for Linux (WSL) to work with MODFLOW.

## Installing WSL
_Note that you need elevated privileges and sometimes your IT administrator to complete this step_

On a Windows machine it is relatively easy to get parallel MODFLOW compiled and running in a WSL Ubuntu virtual machine.

Install a latest version of Ubuntu.
```
  wsl --install -d Ubuntu-22.04
```

You will be asked to provide a username and password.  You'll need to remember this information for some future `sudo` operations. Alternatively, you can install Ubuntu-22.04 from the Microsoft Store.

## Clone the class repo

Clone the class repo in your WSL Ubuntu virtual machine, after opening a WSL terminal, using

```
git clone https://github.com/mjr-deltares/parallel-modflow-dsd23.git
```

## Setting up parallel MODFLOW 6 and pixi environment

In order to set up parallel MODFLOW 6,  execute:

```
cd parallel-modflow-dsd23
./pixi run install
```

This will take a bit of time, somewhere in between 30 minutes and an hour. A successful installation sequence concludes with the message:

```
Successful testing of pixi environment and MODFLOW 6
```

## Jupyter

Jupyter Lab can be started by executing:

```
./pixi run jupyter
```
