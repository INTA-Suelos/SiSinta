Sistema de Base de Datos de Suelos
==================================

Instalación
-----------

### Base de datos

1. [PostgreSQL]
2. [PostGIS]
3. template1 con las funciones y tablas de [PostGIS]

### Dependencias opcionales

* [Rgeo] puede usar [GEOS] si está instalado.

### Producción

    $ RAILS_ENV=production
    $ rake db:create
    $ rake db:setup
    $ rake assets:precompile

El usuario default es Administrador, y se loguea con email@falso.com y el password *administrador*

[PostgreSQL]: http://www.postgresql.org/
[PostGIS]: http://www.postgis.org/
[Rgeo]: http://virtuoso.rubyforge.org/rgeo/
[GEOS]: http://trac.osgeo.org/geos/
