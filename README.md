SiSINTA
=======

[![Join the chat at https://gitter.im/INTA-Suelos/SiSinta](https://badges.gitter.im/INTA-Suelos/SiSinta.svg)](https://gitter.im/INTA-Suelos/SiSinta?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

El **Sistema de Información de Suelos del [INTA]** es un [SIG], hecho con
[PostGIS] y [Rails], para almacenar y procesar los datos de muestras de suelos
del instituto.

Cómo contribuir
---------------

Para contribuir a SiSINTA es importante leer la [Guía de contribución](CONTRIBUTING.md).


Instalación
-----------

### Dependencias

- postgresql
- postgis
- imagemagick
- passenger
- memcached

### Base de datos

1. [PostgreSQL] 9.1 (o superior)

    Nos conectamos como el usuario *postgres* y creamos al usuario, con
    password encriptado:

        $ createuser -P -E -d <usuario db>

    No hace falta que sea superusuario ni cree otros roles.

2. [PostGIS] 1.5 (o superior)

    Siempre como el usuario *postgres*, creamos un template específico para la
    aplicación, con el que se crearán las bases de datos con postgis ya
    cargado:

        $ createdb -O <usuario db> template_postgis -E UTF-8

    Y habilitamos las extensiones de [PostGIS]:

        $ psql -d template_postgis -c "CREATE EXTENSION postgis;"

    Finalmente, convertimos la base de datos en un template de verdad:

        $ psql -c "UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';"

3.  [GEOS] 3.2 (o superior)

4.  [Proj] 4

### Producción

El usuario default es **admin** global. Se loguea con *admin@cambiame.com* y el
password *cambiame*

[PostgreSQL]: http://www.postgresql.org/
[PostGIS]: http://www.postgis.org/
[SIG]: https://es.wikipedia.org/wiki/Sistema_de_Informaci%C3%B3n_Geogr%C3%A1fica
[Rails]: http://rubyonrails.org/
[Rgeo]: http://virtuoso.rubyforge.org/rgeo/
[GEOS]: http://trac.osgeo.org/geos/
[Proj]: https://trac.osgeo.org/proj/
[INTA]: http://inta.gov.ar/
