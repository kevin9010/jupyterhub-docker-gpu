Jupyterhub Docker
=================

Allows create containers with Jupyterhub with numpy, pandas, scipy, matplotlib for multiusers throught a central server.

This image create jupyterhub containers with PAMAuthenticator, this allows us use the linux account and credentials.

Create Container
----------------

     $ docker pull rancavil/jupyterhub:0.8.1
     $ docker run -d --name jpy-server-1 -p 8000:8000 rancavil/jupyterhub:0.8.1

In your browser go to:

     http://localhost:8000

Access to Jupyterhub admin
--------------------------

To create the container an admin account (named admin) its created with default password **change.it!**

     username: admin
     password: change.it!

You must change this password through **Terminal** option (New -> Terminal) using the command:

    $ passwd
    Changing password for admin.
    (current) UNIX password:
    Enter new UNIX password:
    Retype new UNIX password:
    passwd: password updated successfully
    $

Don't forget make this!!!

With **admin** account you can create others users.

Got to **Control Panel** button, **Admin** menu option, **Add Users** button.

Each new user will be created with default password **remember.change.it**. Each user must change its password through **Terminal**
option once he begins first session.

You must change this password through **Terminal** option (New -> Terminal) using the command:

    $ passwd
    Changing password for admin.
    (current) UNIX password:
    Enter new UNIX password:
    Retype new UNIX password:
    passwd: password updated successfully
    $

Each user must be responsible of its account.
