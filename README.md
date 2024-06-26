# MySQL + Flask Shadow and Page Emporium Project
## By: Aleksandra Tyutyunik, Andrew Sun, Elijah Sandler, Madeleine Jin

Shadow and Page Emporium is a cursed bookstore. They sell your normal average, run of the mill books, except that about half of them are cursed, with varying levels of severity. This database-driven UI allows users to monitor and update the curses they use, books they stock, as well as track sales and ongoing R&D projects. 

Here is a link to check out a demo of how it works: https://drive.google.com/file/d/1QupVUD2AWJ5k0eahDT8SVZ-jJYPEiM9E/view?usp=sharing

This repo contains a setup for spinning up 3 Docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container to implement a REST API
1. A Local AppSmith Server

## How to setup and start the containers
**Important** - you need Docker Desktop installed

1. Clone this repository.  
1. Create a file named `db_root_password.txt` in the `secrets/` folder and put inside of it the root password for MySQL. 
1. Create a file named `db_password.txt` in the `secrets/` folder and put inside of it the password you want to use for the a non-root user named webapp. 
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 

This first commit contains a test to make sure everything doesn't explode. 



