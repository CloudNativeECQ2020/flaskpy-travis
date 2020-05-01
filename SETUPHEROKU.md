# setup on heroku
may not need all of this (git repos) as I am using a container

ref https://devcenter.heroku.com/articles/heroku-cli-commands

omit git push to heroku
1. [create](#create) heroku apps (prod & stage) 
2. [build](#build)  build the container
3. [run](#run) run the container locally 
3. [publish to heroku](#publish to heroku) push the container
 

## create
ensure the task stack is container
``` 
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku stack:set container -a wordcount-pmc-stage
    Warning: heroku update available from 7.39.0 to 7.39.6.
Setting stack to container... done
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku apps:info --app wordcount-pmc-stae
    Warning: heroku update available from 7.39.0 to 7.39.6.
 ▸    Couldn't find that app.
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku apps:info --app wordcount-pmc-stage
    Warning: heroku update available from 7.39.0 to 7.39.6.
=== wordcount-pmc-stage
Auto Cert Mgmt: false
Dynos:
Git URL:        https://git.heroku.com/wordcount-pmc-stage.git
Owner:          pcampbell.edu@gmail.com
Region:         us
Repo Size:      0 B
Slug Size:      0 B
Stack:          container
Web URL:        https://wordcount-pmc-stage.herokuapp.com/
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku stack:set container -a wordcount-pmc-prod
    Warning: heroku update available from 7.39.0 to 7.39.6.
Setting stack to container... done
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ ^C
```
## create & set type test
problem default stack is heroku-18, need container
```
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku create --app wordcount-pmc-cont ^C
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku apps:info --app wordcount-pmc-cont
    Warning: heroku update available from 7.39.0 to 7.39.6.
=== wordcount-pmc-cont
Auto Cert Mgmt: false
Dynos:
Git URL:        https://git.heroku.com/wordcount-pmc-cont.git
Owner:          pcampbell.edu@gmail.com
Region:         us
Repo Size:      0 B
Slug Size:      0 B
Stack:          heroku-18
Web URL:        https://wordcount-pmc-cont.herokuapp.com/
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku apps:destroy wordcount-pmc-cont
    Warning: heroku update available from 7.39.0 to 7.39.6.
 ▸    WARNING: This will delete ⬢ wordcount-pmc-cont including all add-ons.
 ▸    To proceed, type wordcount-pmc-cont or re-run this command with --confirm
 ▸    wordcount-pmc-cont

> wordcount-pmc-cont
Destroying ⬢ wordcount-pmc-cont (including all add-ons)... done
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku apps:create  wordcount-pmc-cont --stack=container
    Warning: heroku update available from 7.39.0 to 7.39.6.
Creating ⬢ wordcount-pmc-cont... done, stack is container
https://wordcount-pmc-cont.herokuapp.com/ | https://git.heroku.com/wordcount-pmc-cont.git
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ heroku apps:info --app wordcount-pmc-cont
    Warning: heroku update available from 7.39.0 to 7.39.6.
=== wordcount-pmc-cont
Auto Cert Mgmt: false
Dynos:
Git URL:        https://git.heroku.com/wordcount-pmc-cont.git
Owner:          pcampbell.edu@gmail.com
Region:         us
Repo Size:      0 B
Slug Size:      0 B
Stack:          container
Web URL:        https://wordcount-pmc-cont.herokuapp.com/
tricia@acerubuntu1804:~/ecq/flaskpy-travis$
```

## build
```
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ make build
docker build -t flastpytravis .
Sending build context to Docker daemon  52.22kB
Step 1/7 : FROM python:3-alpine
 ---> 6c32e2504283
Step 2/7 : MAINTAINER P.M.Campbell pcampbell.edu@gmail.com
 ---> Using cache
 ---> c68d29cf55af
Step 3/7 : RUN pip install --no-cache-dir Flask
 ---> Using cache
 ---> f3893f9e5fe5
Step 4/7 : COPY app.py /usr/local/bin/app.py
 ---> 5010bbc7fef4
Step 5/7 : EXPOSE 5000
 ---> Running in 758938c7259f
Removing intermediate container 758938c7259f
 ---> 9fa1053f02fe
Step 6/7 : WORKDIR /usr/local/bin
 ---> Running in 58681c8b0ae3
Removing intermediate container 58681c8b0ae3
 ---> ee879e17f102
Step 7/7 : CMD [ "python", "./app.py" ]
 ---> Running in 036ee453419c
Removing intermediate container 036ee453419c
 ---> ee94387fd117
Successfully built ee94387fd117
Successfully tagged flastpytravis:latest
```
## run
```
docker run -d -p 5555:5000    --name flastpytravis  flastpytravis
docker ps
182443517a1dd1f7ff0acf6d256a4089bb9d5aaec6cf14a4db646e1c09f65dec
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                  PORTS                   NAMES
182443517a1d        flastpytravis       "python ./app.py"   5 seconds ago       Up Less than a second   0.0.0.0:5555->5000/tcp   flastpytravis
```
# publish to heroku
```
tricia@acerubuntu1804:~/ecq/flaskpy-travis$ make heroku-publish
push to the heroku repo
    Warning: heroku update available from 7.39.0 to 7.39.6.
=== Building web (/home/tricia/ecq/flaskpy-travis/Dockerfile)
Sending build context to Docker daemon  54.27kB
Step 1/7 : FROM python:3-alpine
 ---> 6c32e2504283
Step 2/7 : MAINTAINER P.M.Campbell pcampbell.edu@gmail.com
 ---> Using cache
 ---> c68d29cf55af
Step 3/7 : RUN pip install --no-cache-dir Flask
 ---> Using cache
 ---> f3893f9e5fe5
Step 4/7 : COPY app.py /usr/local/bin/app.py
 ---> Using cache
 ---> 5010bbc7fef4
Step 5/7 : EXPOSE 5000
 ---> Using cache
 ---> 9fa1053f02fe
Step 6/7 : WORKDIR /usr/local/bin
 ---> Using cache
 ---> ee879e17f102
Step 7/7 : CMD [ "python", "./app.py" ]
 ---> Using cache
 ---> ee94387fd117
Successfully built ee94387fd117
Successfully tagged registry.heroku.com/wordcount-pmc-stage/web:latest
=== Pushing web (/home/tricia/ecq/flaskpy-travis/Dockerfile)
The push refers to repository [registry.heroku.com/wordcount-pmc-stage/web]
f76ef2309f43: Layer already exists
c94e70d31b77: Layer already exists
49462667bf1d: Layer already exists
95d0dbe061b1: Layer already exists
992ca7b80035: Layer already exists
a539b76feca4: Pushed
3e207b409db3: Pushed
latest: digest: sha256:2e202790b74965f476aca505908577d9d47a396b79afdc216e568efd41f7b802 size: 1786
Your image has been successfully pushed. You can now release it with the 'container:release' command.
release app
    Warning: heroku update available from 7.39.0 to 7.39.6.
    Error: Flag --app expects a value
if the last step worked load https://wordcount-pmc-stage.herokuapp.com in a browser
tricia@acerubuntu1804:~/ecq/flaskpy-travis$
```

