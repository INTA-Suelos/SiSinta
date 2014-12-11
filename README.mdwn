SiSINTA
=======

El **Sistema de Información de Suelos del [INTA]** es un [SIG], hecho con
[PostGIS] y [Rails], para almacenar y procesar los datos de muestras de suelos
del instituto.

Cómo contribuir
---------------

Para contribuir a SiSINTA es importante leer la [Guía de contribución](CONTRIBUTING.md).


Instalación
-----------

### Base de datos

1. [PostgreSQL] 9.1 (o superior)

    Nos conectamos como el usuario *postgres* y creamos al usuario (por ejemplo
    *sisinta*), con password encriptado:

        $ createuser -P -E -d sisinta

    No hace falta que sea superusuario ni cree otros roles. Ahora configuramos
    los permisos de acceso para poder conectarse con este usuario en
    `pg_hba.conf`, agregando esta línea:

        local   all             sisinta                                 md5

    Luego reiniciamos o recargamos la configuración.

2. [PostGIS] 1.5 (o superior)

    Siempre como el usuario *postgres*, creamos un template específico para la
    aplicación, con el que se crearán las bases de datos con postgis ya
    cargado:

        $ createdb -O sisinta template_sisinta -E UTF-8

    Instalamos el lenguaje plpgsql (si hace falta):

        $ createlang plpgsql template_sisinta

    Y las tablas de [PostGIS] (el path a los archivos depende del sistema):

        $ psql -d template_sisinta -f /usr/share/postgresql/contrib/postgis-1.5/postgis.sql
        $ psql -d template_sisinta -f /usr/share/postgresql/contrib/postgis-1.5/spatial_ref_sys.sql

    Después, hay que cambiar el propietario de esas tablas a *sisinta*, dado
    que un rol común no tiene permisos para crear las definiciones de funciones
    que usa [PostGIS]:

        $ psql -d template_sisinta -c "ALTER TABLE geography_columns OWNER TO sisinta;"
        $ psql -d template_sisinta -c "ALTER TABLE geometry_columns OWNER TO sisinta;"
        $ psql -d template_sisinta -c "ALTER TABLE spatial_ref_sys OWNER TO sisinta;"

    Finalmente, convertimos la base de datos en un template de verdad:

        $ psql -c "UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_sisinta';"

3.  [GEOS] 3.2 (o superior)

4.  [Proj4]

### Producción

Hay que configurar los archivos `.dist` y sacarles esa extensión:

* `config/database.yml.dist`

    username, password y template como los creamos antes antes. Explicitamos
    port, si no está corriendo en el 5432.

* `config/environments/production.rb.dist`
* `config/initializers/devise.rb.dist`
* `config/initializers/secret_token.rb.dist`

Configuramos el entorno en *producción*

    $ export RAILS_ENV=production

Instalamos las dependencias

    $ bundle install

Creamos la base de datos

    $ rake db:reset

Precompilamos los archivos estáticos

    $ rake assets:precompile

El usuario default es **admin** global. Se loguea con *admin@cambiame.com* y el
password *cambiame*

[PostgreSQL]: http://www.postgresql.org/
[PostGIS]: http://www.postgis.org/
[SIG]: https://es.wikipedia.org/wiki/Sistema_de_Informaci%C3%B3n_Geogr%C3%A1fica
[Rails]: http://rubyonrails.org/
[Rgeo]: http://virtuoso.rubyforge.org/rgeo/
[GEOS]: http://trac.osgeo.org/geos/
[Proj4]: https://trac.osgeo.org/proj/
[INTA]: http://inta.gov.ar/
