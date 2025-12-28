#!/bin/bash

# Update package lists
sudo apt update

# Install required packages
sudo apt install -y sysbench bonnie++ iperf p7zip-full hardinfo build-essential
wget https://master.dl.sourceforge.net/project/phoronix-test-suite.mirror/v10.8.4/phoronix-test-suite_10.8.4_all.deb?viasf=1 -O phoronix-test-suite_10.8.4_all.deb
# Install Ramspeed from source (since it's not in default repositories)
# You can either manually install or follow this guide if you need it

# Install Phoronix Test Suite (if needed)
#sudo apt install -y phoronix-test-suite

# Download Geekbench for Linux
wget https://cdn.geekbench.com/Geekbench-6.5.0-Linux.tar.gz -O geekbench.tar.gz

# Extract Geekbench
tar -xvzf geekbench.tar.gz

# Change into the Geekbench directory
cd ./Geekbench-6.5.0-Linux

# Make Geekbench executable
chmod +x geekbench6

# Run Geekbench (optional: remove this if you don't want to run it automatically)
#./geekbench5

# Clean up: remove the downloaded tar.gz file
cd ..
rm geekbench.tar.gz
rm phoronix-test-suite_10.8.4_all.deb

# Finish
echo "Installation complete!"
