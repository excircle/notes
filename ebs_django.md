# Setting Up Your Virtual Environment

Use the `virtualenv` command to create a virtual environment for our Django Application

```bash
~$ virtualenv eb-virt
```

Next, turn the virtual environment on
```bash
~$ source eb-virt/bin/activate
(eb-virt) ~$
```
 Next, use the Python Package Manager to install the version of Django we want.

```bash
(eb-virt)~$ pip install django==2.1.1
```

Next, use the newly installed Django software to provision a Django project. This project is the web framework that builds websites.

```bash
(eb-virt)~$ django-admin startproject ebdjango
```

Enter inside of the project folder.

```bash
(eb-virt) ~$ cd ebdjango
(eb-virt) ~/ebdjango$ python manage.py runserver
```

Now, we should be able to find our site by visiting our local environment and hitting port 8000.
<a href="http://127.0.0.1:8000/">Local Django Project</a>

Next, let's edit the Django config file to allow traffic to Django.

```bash
(eb-virt) ~/ebdjango$ vim ebdjango/settings.py
```

# Deploying This Django App To Elastic Beanstalk

Elastic Beanstalk will need some information on what our Python environment requires to run. Since we already have our requirements setup on our local system, we'll capture those environment settings using the `pip freeze` command and save the output into a file called `requirement.txt`. This file will be read by Elastic Beanstalk and used to configure the AWS environment to be suitable for Django.

```bash
(eb-virt) ~/ebdjango$ pip freeze > requirements.txt
```

Next, we'll need to create a `.ebextension` folder to provide some configuration details to Elastic Beanstalk.
```bash
(eb-virt) ~/ebdjango$ mkdir .ebextensions
```

In the .ebextensions directory, add a configuration file named django.config with the following text.

```bash
(eb-virt) ~/ebdjango$ vim .ebextensions/django.config
```


```
    option_settings:
      aws:elasticbeanstalk:container:python:
        WSGIPath: ebdjango/wsgi.py
```

Now, we'll turn off our virtual environment. deactivate command.

```bash
(eb-virt) ~/ebdjango$ deactivate
```

# Deploying to AWS with Elastic Beanstalk

Initialize your EB CLI repository with the eb init command.

```bash
    ~/ebdjango$ eb init -p python-3.6 django-tutorial2
```
This command creates an application named django-tutorial. It also configures your local repository to create environments with the latest Python 3.6 platform version.

Next, we'll create an environment to deliver our application to using the `eb create` command.

```bash
    ~/ebdjango$ eb create django-env1
```

This process will take approximately 5 minutes. You can check the status of the deploy by running the following command.

```bash
~/ebdjango$ eb status
```
