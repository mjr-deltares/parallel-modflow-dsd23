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

## Installing the class `mf6xtd` conda environment

Open the WLS terminal and navigate to the `/parallel-modflow-dsd23/installation` directory. 

### Clean WSL Ubuntu virtual environment, Linux, or MacOS

If you installing the class conda environment in a WSL Ubuntu virtual environment, Linux machine, or MacOS machine without a Conda or Miniconda installation, the environment can be installed using

```
./parallel_class_environment_setup.sh
```

This will install Miniconda, install the class `mf6xtd` conda environment, compile parallel MODFLOW 6, test parallel MODFLOW 6, and test the environment installation.

### WSL Ubuntu virtual environment, Linux, or MacOS

If you installing the class `mf6xtd` conda environment in a WSL Ubuntu virtual environment, Linux machine, or MacOS machine with an an existing Conda or Miniconda installation, the environment can be installed using

```
./parallel_class_environment_setup.sh --skip-conda
```

This will install the class `mf6xtd` conda environment, compile parallel MODFLOW 6, test parallel MODFLOW 6, and test the environment installation. This step can also be run to update an existing class `mf6xtd`environment on a WSL Ubuntu virtual environment, Linux machine, or MacOS machine.

### Successful installation of the class `mf6xtd` conda environment

If the class `mf6xtd` conda environment has been successfully installed, `Successful testing of miniconda environment and MODFLOW 6` will be written to the terminal. The message `Successful testing of miniconda environment and MODFLOW 6`, will also be written to the last line of the `/parallel-modflow-dsd23/installation\installation.log` file if the class `mf6xtd` conda environment has been successfully installed. The `installation.log` file will also include additional information written during the class `mf6xtd` conda environment installation.
