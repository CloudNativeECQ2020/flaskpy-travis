# flask w python + travis CI/CD

I tried a udacity course but it was not up to date so i am going to follow this https://realpython.com/flask-by-example-part-1-project-setup/ but convert it to a container as in [flaskpy](../flaskpy)  and to set it up with https://docs.travis-ci.com/user/tutorial/  to deploy to heroku 

Because I am using a container, I don't need to do the setup on heroku, just on the container. 

## part 2 Setting up Postgres, SQLAlchemy, and Alembic
https://realpython.com/flask-by-example-part-2-postgres-sqlalchemy-and-alembic/

todo check: using a base image python alpine, should I use a base image for PostgresSQL?
todo decide if students should use alpine or ubuntu or redhat images ???
1. update Dockerfile 
    1. use apk to install postgres
    2. a few  stmts to set up postgress &
    2. requirements.txt added other pkgs needed
see [part2 runtime](SETUPDBS.md)
might need to use a postgres base image & install python instead of vice versa 
## part 1 basic setup
https://realpython.com/flask-by-example-part-1-project-setup/ 
1. run on container  (see app/app.py & app/app2.py &  see Dockerfile.part1 & requirements.txt.part1
2. run on heroku  see [setup on heroku](SETUPHEROKU.md)   (omit the push)

## install docker
If you plan to run this image locally install docker (it may also be run from any of the major cloud providers such as AWS, Azure, Google Cloud and some others such as heroku and openshift.

[Install](https://docs.docker.com/install/)  

__Note:__ If you have newly install docker, on \*nix, in order to run docker as a regular user you __must add your userid to the docker group (then restart the shell) `sudo usermod -aG docker youruserid`  To check this you should see it as your group when you run `id`

__Note:__ If you are newly learning docker I suggest you use the command line interface as it may be used anywhere. 
## docker registry image repo todo

### running a container from a hub image: todo
If you don't want to clone this gihub repo you can run this image (provided docker is installed) use this command change hostport to whatever you want (high is eaiser wrt firewalls) docker will do port forwarding for you:
```
docker run -p hostport:5000 tricia/flaskpoc
```
To access the app load a browser and use localhost or your ip address `localhost:hostport` or `your.ip.address:hostport`   
In the following screenshot the command run was `docker run -p 8080:5000 tricia/flaskpoc` so access is form port 8080 on the host running docker.  
![browser shot](flaskcontainertest.PNG)

If you run the preceding docker command the container will have control of the shell and you will see error or debut messages.  In order to run the app in a headless manner you must `-d` detach:
```
docker run -d -p hostport:5000 tricia/flaskpoc
```
## Dockerfile 
todo See [Dockerfile with explanations](Dockerfile.md)

