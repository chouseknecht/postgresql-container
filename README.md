# postgresql-container

A PostgreSQL container enabled role. Add a *postgres* service to your Ansible Container project:

```
$ ansible-container install chouseknecht.postgresql-container 
```

## Requirements

- [Ansible Container](https://github.com/ansible/ansible-container)
- An existing Ansible Container project. You can create a project using the `init` command:

    ```
    $ mkdir myproject
    $ cd myproject
    $ ansible-container init
    ```


## Role Variables

pgdata
> PostgreSQL data directory where your database will be created. Defaults to */var/lib/postgresql*.

## Dependencies

None. 

## License

Apache v2

## Author Information

[@chouseknecht](https://github.com/chouseknecht)
