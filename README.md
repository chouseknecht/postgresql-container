# postgresql-container

[![Build Status](https://travis-ci.org/chouseknecht/postgresql-container.svg?branch=master)](https://travis-ci.org/chouseknecht/postgresql-container)

A PostgreSQL container enabled role.

- Demonstrates running Ansible inside a container in a way that works on OpenShift. By using [nns_wrapper](https://cwrap.org/nss_wrapper.html), the [entrypoint script](./files/entrypoint.sh) is able to create an entry in the *passwd* file at startup, which allows Ansible to work. It then runs a playbook to initialize a new database, and create users.

- Provides the build for the ansible/ansible-postgres image used in [django-gulp-nginx](https://github.com/ansible/django-gulp-nginx), an Ansible Container demo project.

- Creates an image that is known to work with [minishift](https://github.com/minishift/minishift)

To add a *postgres* service to your Ansible Container project:

```
$ ansible-container install chouseknecht.postgresql-container 
```
### Database creation

When the service is started, if no database is found in /var/lib/pgsql/data/userdata, then a new database is created. See *Role Variables* below for setting the database name and the username and password of the superuser. 

### Ports

Port 5432 is exposed, and can be accessed by other services. If you need to access the port externally, add a *ports* directive in `container.yml`.

### Volumes

The database gets created at */var/lib/pgsql/data/userdata*. If you want the database created on external storage, map a host path or named volume to */var/lib/pgsql/data*. When the database is initialized, the *userdata* directory will be created with an owner of *postgres* and mode *0700*. This is required and enforced by the postgres *dbinit* command.

The image needs to be built without any volumes attached to */var/lib/pgsql/data*, allowing the path to be created in the image with the ownership set to *postgres:root*. Then later a Docker volume can be mounted to the path during `run`, and the permissions on the mount point will be correct, allowing *userdata* to be created. Otherwise, the mount ends up being owned by *root*, and the database init fails with a permssions error. For this reason, it's best to add the *volume* directive to *dev_overrides*.

If you're planning to deploy to OpenShift, then we recommend using the pre-built ansible/ansible-postgres image, which contains the data path already built with the ownership and permissions.

## Requirements

- [Ansible Container](https://github.com/ansible/ansible-container)
- An existing Ansible Container project. You can create a project using the `init` command:

    ```
    $ mkdir myproject
    $ cd myproject
    $ ansible-container init
    ```
## Role Variables

There are no variables defined in [defaults](./defaults/main.yml). However, the following environment variables are defined in [container.yml](./meta/container.yml), and provide some control over the creation of the database:

POSTGRES_DB=mydb
> Sets the name of the database.

POSTGRES_USER=admin
> Sets the username of the superuser created when the database is initialized.

POSTGRES_PASS=admin
> Sets the password for the superuser created at database init as well as the password for the user *postgres*. Both the new user and the *postgres* user will have the same password.

PGDATA=/var/lib/pgsql/data/userdata
> Sets the path to the database files. There shouldn't be any need to change this, but if you do, review and update `main.yml`.

## Dependencies

None. 

## License

Apache v2

## Author Information

[@chouseknecht](https://github.com/chouseknecht)
