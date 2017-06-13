# Como GeoJson es un subtipo de json y se genera con `to_json`, se puede usar
# un alias
Mime::Type.register_alias 'application/json', :geojson
