SiSINTA
=======

El **Sistema de Información de Suelos del [INTA]** es un [SIG], hecho con
[PostGIS] y [Rails], para almacenar y procesar los datos de muestras de suelos
del instituto.

Instalación
-----------

### Base de datos

1. [PostgreSQL]
2. [PostGIS]

        $ createdb -O [usario_db] template_postgis -E UTF-8
        $ createlang plpgsql template_postgis
        $ psql -d template_postgis -f /usr/share/postgresql/contrib/postgis-1.5/postgis.sql
        $ psql -d template_postgis -f /usr/share/postgresql/contrib/postgis-1.5/spatial_ref_sys.sql
        $ psql

            UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';

3. template1 con las funciones y tablas de [PostGIS]

### Dependencias opcionales

* [Rgeo] puede usar [GEOS] si está instalado.

### Producción

Hay que configurar los archivos `.dist` y sacarles esa extensión:

* `config/database.yml.dist`
* `config/environments/production.rb.dist`
* `config/initializers/devise.rb.dist`
* `config/initializers/secret_token.rb.dist`

Configuramos el entorno en *producción*

    $ export RAILS_ENV=production

Creamos la base de datos

    $ rake db:reset

Precompilamos los archivos estáticos

    $ rake assets:precompile

Instalamos las dependencias

    $ bundle install

El usuario default es Administrador, y se loguea con email@falso.com y el password *administrador*

[PostgreSQL]: http://www.postgresql.org/
[PostGIS]: http://www.postgis.org/
[SIG]: https://es.wikipedia.org/wiki/Sistema_de_Informaci%C3%B3n_Geogr%C3%A1fica
[Rails]: http://rubyonrails.org/
[Rgeo]: http://virtuoso.rubyforge.org/rgeo/
[GEOS]: http://trac.osgeo.org/geos/
[INTA]: http://inta.gov.ar/
