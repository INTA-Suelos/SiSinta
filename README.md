SiSINTA
=======

El **Sistema de Información de Suelos del [INTA]** es un [SIG], hecho con
[PostGIS] y [Rails], para almacenar y procesar los datos de muestras de suelos
del instituto.

Cómo contribuir
---------------

Para contribuir a SiSINTA es importante leer la [Guía de contribución](CONTRIBUTING.md).

### Instalación local

#### Docker

1. Copiá el archivo `.env.dist` a `.env` y configurá lo que sea necesario ahí.
2. Generá las imágenes

        $ docker compose build

3. Levantá los servicios

        $ docker compose up

    El comando de inicio de la imagen de SiSINTA (`bin/start`) ya crea la base
    de datos, migraciones y seeds, si hace falta.

3. A partir de ahí, es accesible en http://0.0.0.0:8080 (o el puerto que esté
   configurado en `.env`).


docker compose exec app rake routes

### Dependencias

- docker y docker compose

[PostGIS]: http://www.postgis.org/
[SIG]: https://es.wikipedia.org/wiki/Sistema_de_Informaci%C3%B3n_Geogr%C3%A1fica
[Rails]: http://rubyonrails.org/
