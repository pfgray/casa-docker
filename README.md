# CASA Docker


This is a Docker file to quickly stand up the reference implementation of CASA located [here](https://github.com/IMSGlobal/casa-engine).

This docker is [registered on docker](https://index.docker.io/u/pfgray/casa/)

To run from the docker repository:

    sudo docker pull pfgray/casa
    
    sudo docker run -p 80:5000 -p 9292:3000 -d pfgray/casa


To build and run from this repo:

    sudo docker build -t <username>/casa .
    
    sudo docker run -p 80:5000 -p 9292:3000 -d <username>/casa
    


