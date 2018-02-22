# Instalación

Esta guía detalla los pasos recomendados para instalar el sistema desde cero en
un servidor que será de producción.

## Prerequisitos

Además de seguir los pasos es necesario instalar el siguiente software con el
manejador de paquetes del sistema:

- [git]
- un [build-environment] para compilar [ruby](#ruby)

[git]: https://git-scm.com
[build-environment]: https://github.com/rbenv/ruby-build/wiki#suggested-build-environment

## Un usuario para la app

Crear el usuario

    useradd --create-home sisinta

Generar un password con

    passwd sisinta

O preferentemente configurar el acceso por ssh

    mkdir /home/sisinta/.ssh
    chmod 700 /home/sisinta/.ssh
    cat id_rsa.pub >> /home/sisinta/.ssh/authorized_keys
    chown sisinta:sisinta /home/sisinta/.ssh

## Ruby

Para simplificar la administración de ruby y sus versiones se usa [rbenv] y
[ruby-build] como plugin. Las instrucciones detalladas están en los respectivos
READMEs.

[rbenv]: https://github.com/rbenv/rbenv
[ruby-build]: https://github.com/rbenv/ruby-build

## Base de datos

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

## Producción

El usuario default es **admin** global. Se loguea con *admin@cambiame.com* y el
password *cambiame*.

## Dependencias

- rbenv y rbenv-ruby-build
- ruby
- postgresql
- postgis
- imagemagick
- passenger
- memcached

[PostgreSQL]: http://www.postgresql.org
[PostGIS]: http://www.postgis.org
[Rails]: http://rubyonrails.org
[Rgeo]: http://virtuoso.rubyforge.org/rgeo
[GEOS]: http://trac.osgeo.org/geos
[Proj]: https://trac.osgeo.org/proj
[INTA]: http://inta.gov.ar
