# Auroral Services

This repo describes the services that are offered by MetGIS in the [Auroral network](https://auroral.docs.bavenir.eu/home/what/).
To access the data over the network, you must have a node [installed](https://auroral.docs.bavenir.eu/getting_started/install_node/) and be a member of the [network](https://auroral.docs.bavenir.eu/getting_started/start_using_auroral/start_using_auroral/).

## Point-Forecast Service

The Point-Forecast Service returns a hourly weather forecast for a requested location (lon, lat).
To get a forecast pass longitude (lon) and latitude (lat) as request parameters (?lon=12&lat=45).

<details>
  <summary>A response value will look like this.</summary>

```json
{
"@context": "https://auroralh2020.github.io/auroral-ontology-contexts/adapters/context.json",
"@type": "https://auroral.iot.linkeddata.es/def/adapters#WeatherSensor",
"id": "h0", // id  hour of the forecast
"saref:measuresProperty": [
    {
    "@type": "https://auroral.iot.linkeddata.es/def/adapters#Rainfall",
    "saref:relatesToMeasurement": {
        "@type": "saref:Measurement",
        "saref:hasValue": 0, // rain in mm for this hour
        "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
        "saref:hasTimeStamp": "2025-02-11T18:00+01:00"
    }
    },
    {
    "@type": "https://auroral.iot.linkeddata.es/def/adapters#Snowfall",
    "saref:relatesToMeasurement": {
        "@type": "saref:Measurement",
        "saref:hasValue": 0, // snowfall in cm for this hour
        "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/centimetre",
        "saref:hasTimeStamp": "2025-02-11T18:00+01:00"
    }
    },
    {
    "@type": "https://auroral.iot.linkeddata.es/def/adapters#WindSpeed",
    "saref:relatesToMeasurement": {
        "@type": "saref:Measurement",
        "saref:hasValue": 13, // wind in km/h for this hour
        "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
        "saref:hasTimeStamp": "2025-02-11T18:00+01:00"
    }
    },
    {
    "@type": "https://auroral.iot.linkeddata.es/def/adapters#WindDirection",
    "saref:relatesToMeasurement": {
        "@type": "saref:Measurement",
        "saref:hasValue": "SE", // wind direction in degree from north for this hour
        "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
        "saref:hasTimeStamp": "2025-02-11T18:00+01:00"
    }
    },
    {
    "@type": "https://auroral.iot.linkeddata.es/def/adapters#Temperature",
    "saref:relatesToMeasurement": {
        "@type": "saref:Measurement",
        "saref:hasValue": 6.7,  // temperature in degrecelsius for this hour
        "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
        "saref:hasTimeStamp": "2025-02-11T18:00+01:00"
    }
    },
    {
    "@type": "https://auroral.iot.linkeddata.es/def/adapters#RelativeHumidity",
    "saref:relatesToMeasurement": {
        "@type": "saref:Measurement",
        "saref:hasValue": 92, // relative humidity in percent for this hour
        "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
        "saref:hasTimeStamp": "2025-02-11T18:00+01:00"
    }
    },
    {
    "@type": "https://auroral.iot.linkeddata.es/def/adapters#CloudCover",
    "saref:relatesToMeasurement": {
        "@type": "saref:Measurement",
        "saref:hasValue": 92, // cloud cover in percent for this hour
        "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
        "saref:hasTimeStamp": "2025-02-11T18:00+01:00"
    }
    }
]
},
{
// next hour
"@context": "https://auroralh2020.github.io/auroral-ontology-contexts/adapters/context.json",
"@type": "https://auroral.iot.linkeddata.es/def/adapters#WeatherSensor",
"id": "h1",
"saref:measuresProperty": [
    {
    "@type": "https://auroral.iot.linkeddata.es/def/adapters#Rainfall",
    "saref:relatesToMeasurement": {
        "@type": "saref:Measurement",
        "saref:hasValue": 0,
        "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
        "saref:hasTimeStamp": "2025-02-11T19:00+01:00"
    }
    ...
},
...
```

</details>

As can bee seen in the response data for rainfall, snowfall, wind, temperature, humidity, and cloud cover will be returned.

## Maps Service

This service returns access urls for MetGis weather tiles. Which can be used to create interactive weather maps.
With libraries like mapbox or malibre-gl for a demo application see chapter **Demo Application**.
You can choose from temperature,snow, combined weather (snow, rain, clouds) tiles.
Select the layer by passing the request parameter layer.

| Map Type             | ?layer=     | type   | metadata                                                              |
| -------------------- | ----------- | ------ | --------------------------------------------------------------------- |
| Snow Cover Map       | snow        | vector |                                                                       |
| Temperature Map      | temperature | raster | [metajson](https://tiles.metgis.com/meta-world/0.8/meta.json)         |
| Combined Weather Map | weather     | vector | [meta-weathermap-world](https://api.metgis.com/meta-weathermap-world) |

A sample response would look like this

```json
{
  "@context": "https://auroralh2020.github.io/auroral-ontology-contexts/core/services.json",
  "@type": "https://auroral.iot.linkeddata.es/def/core#Dataset",
  "accessURL": "https://{a}.metgis.com/tmp2m-world_{t}/{z}/{x}/{y}.png?key=..."
}
```

To access the tiles you have to substitute the placeholders with valid values.

| Placeholder | Description | Allowed Values  | Regards                         |
| ----------- | ----------- | --------------- | ------------------------------- |
| {a}         | Mirror      | t1,t2,t3        | snow, temperature, combined Map |
| {t}         | Timestep    | see metadata    | temperature, combined           |
| {z}/{x}/{y} | Tile ID     | any valid value | snow, temperature, combined Map |

<details>
  <summary>To get the available timesteps and their mappings for the temperature map you can use this script</summary>

```js
fetch("https://tiles.metgis.com/meta-world/0.8/meta.json")
  .then((res) => res.json())
  .then((data) => {
    const startDate = new Date(data.forecastIssued);
    const step = data.timeStep;
    const timeStepCount = data.timeStepNumber;
    const arr = [];

    for (let i = 0; i < timeStepCount; i++) {
      const hours = i * step;
      const date = new Date(startDate.getTime());
      date.setHours(date.getHours() + hours);

      arr.push({ timestep: i + 1, date: date.toISOString() });
    }

    return Promise.resolve(arr);
  })
  .then((arr) => {
    console.log(arr);
  });
```
</details>

<details>
  <summary>The color values for the temperature tiles are as follows:</summary>
  
| **Value [°C]** | **Color** |
| -------------- | --------- |
| <-30           | `#737373` |
| -30            | `#969696` |
| -28            | `#bdbdbd` |
| -26            | `#efedf5` |
| -24            | `#dadaeb` |
| -22            | `#bcbddc` |
| -20            | `#9e9ac8` |
| -18            | `#807dba` |
| -16            | `#6a51a3` |
| -14            | `#544082` |
| -12            | `#06407c` |
| -10            | `#08519c` |
| -8             | `#2171b5` |
| -6             | `#4292c6` |
| -4             | `#6baed6` |
| -2             | `#9ecae1` |
| 0              | `#238443` |
| 2              | `#41ab5d` |
| 4              | `#78c679` |
| 6              | `#addd8e` |
| 8              | `#d9f0a3` |
| 10             | `#f7fcb9` |
| 12             | `#ffffcc` |
| 14             | `#ffeda0` |
| 16             | `#fed976` |
| 18             | `#feb24c` |
| 20             | `#fd8d3c` |
| 22             | `#fdbb84` |
| 24             | `#fc8d59` |
| 26             | `#ef6548` |
| 28             | `#d7301f` |
| 30             | `#bd0026` |
| 32             | `#b30000` |
| 34             | `#800026` |
| 36             | `#7f0000` |
| 38             | `#4c0016` |
| >40            | `#35000f` |
</details>


The available timesteps, their mappings and style for the **combined weather map** are in the meta json.

<details>
  <summary>Sample metajson for combined weather maps</summary>

```json
{
  "description": "MetGIS Tile Server",
  "layers": [
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t6/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t6/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t6/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t6.json",
        "https://t2.metgis.com/weathermap-world_t6.json",
        "https://t3.metgis.com/weathermap-world_t6.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t6/style.json",
        "https://t2.metgis.com/weathermap-world_t6/style.json",
        "https://t3.metgis.com/weathermap-world_t6/style.json"
      ],
      "timestamp": "2025-02-12T00:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t9/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t9/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t9/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t9.json",
        "https://t2.metgis.com/weathermap-world_t9.json",
        "https://t3.metgis.com/weathermap-world_t9.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t9/style.json",
        "https://t2.metgis.com/weathermap-world_t9/style.json",
        "https://t3.metgis.com/weathermap-world_t9/style.json"
      ],
      "timestamp": "2025-02-12T03:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t12/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t12/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t12/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t12.json",
        "https://t2.metgis.com/weathermap-world_t12.json",
        "https://t3.metgis.com/weathermap-world_t12.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t12/style.json",
        "https://t2.metgis.com/weathermap-world_t12/style.json",
        "https://t3.metgis.com/weathermap-world_t12/style.json"
      ],
      "timestamp": "2025-02-12T06:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t15/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t15/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t15/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t15.json",
        "https://t2.metgis.com/weathermap-world_t15.json",
        "https://t3.metgis.com/weathermap-world_t15.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t15/style.json",
        "https://t2.metgis.com/weathermap-world_t15/style.json",
        "https://t3.metgis.com/weathermap-world_t15/style.json"
      ],
      "timestamp": "2025-02-12T09:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t18/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t18/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t18/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t18.json",
        "https://t2.metgis.com/weathermap-world_t18.json",
        "https://t3.metgis.com/weathermap-world_t18.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t18/style.json",
        "https://t2.metgis.com/weathermap-world_t18/style.json",
        "https://t3.metgis.com/weathermap-world_t18/style.json"
      ],
      "timestamp": "2025-02-12T12:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t21/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t21/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t21/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t21.json",
        "https://t2.metgis.com/weathermap-world_t21.json",
        "https://t3.metgis.com/weathermap-world_t21.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t21/style.json",
        "https://t2.metgis.com/weathermap-world_t21/style.json",
        "https://t3.metgis.com/weathermap-world_t21/style.json"
      ],
      "timestamp": "2025-02-12T15:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t24/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t24/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t24/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t24.json",
        "https://t2.metgis.com/weathermap-world_t24.json",
        "https://t3.metgis.com/weathermap-world_t24.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t24/style.json",
        "https://t2.metgis.com/weathermap-world_t24/style.json",
        "https://t3.metgis.com/weathermap-world_t24/style.json"
      ],
      "timestamp": "2025-02-12T18:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t27/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t27/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t27/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t27.json",
        "https://t2.metgis.com/weathermap-world_t27.json",
        "https://t3.metgis.com/weathermap-world_t27.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t27/style.json",
        "https://t2.metgis.com/weathermap-world_t27/style.json",
        "https://t3.metgis.com/weathermap-world_t27/style.json"
      ],
      "timestamp": "2025-02-12T21:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t30/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t30/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t30/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t30.json",
        "https://t2.metgis.com/weathermap-world_t30.json",
        "https://t3.metgis.com/weathermap-world_t30.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t30/style.json",
        "https://t2.metgis.com/weathermap-world_t30/style.json",
        "https://t3.metgis.com/weathermap-world_t30/style.json"
      ],
      "timestamp": "2025-02-13T00:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t33/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t33/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t33/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t33.json",
        "https://t2.metgis.com/weathermap-world_t33.json",
        "https://t3.metgis.com/weathermap-world_t33.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t33/style.json",
        "https://t2.metgis.com/weathermap-world_t33/style.json",
        "https://t3.metgis.com/weathermap-world_t33/style.json"
      ],
      "timestamp": "2025-02-13T03:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t36/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t36/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t36/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t36.json",
        "https://t2.metgis.com/weathermap-world_t36.json",
        "https://t3.metgis.com/weathermap-world_t36.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t36/style.json",
        "https://t2.metgis.com/weathermap-world_t36/style.json",
        "https://t3.metgis.com/weathermap-world_t36/style.json"
      ],
      "timestamp": "2025-02-13T06:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t39/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t39/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t39/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t39.json",
        "https://t2.metgis.com/weathermap-world_t39.json",
        "https://t3.metgis.com/weathermap-world_t39.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t39/style.json",
        "https://t2.metgis.com/weathermap-world_t39/style.json",
        "https://t3.metgis.com/weathermap-world_t39/style.json"
      ],
      "timestamp": "2025-02-13T09:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t42/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t42/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t42/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t42.json",
        "https://t2.metgis.com/weathermap-world_t42.json",
        "https://t3.metgis.com/weathermap-world_t42.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t42/style.json",
        "https://t2.metgis.com/weathermap-world_t42/style.json",
        "https://t3.metgis.com/weathermap-world_t42/style.json"
      ],
      "timestamp": "2025-02-13T12:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t45/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t45/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t45/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t45.json",
        "https://t2.metgis.com/weathermap-world_t45.json",
        "https://t3.metgis.com/weathermap-world_t45.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t45/style.json",
        "https://t2.metgis.com/weathermap-world_t45/style.json",
        "https://t3.metgis.com/weathermap-world_t45/style.json"
      ],
      "timestamp": "2025-02-13T15:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t48/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t48/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t48/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t48.json",
        "https://t2.metgis.com/weathermap-world_t48.json",
        "https://t3.metgis.com/weathermap-world_t48.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t48/style.json",
        "https://t2.metgis.com/weathermap-world_t48/style.json",
        "https://t3.metgis.com/weathermap-world_t48/style.json"
      ],
      "timestamp": "2025-02-13T18:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t51/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t51/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t51/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t51.json",
        "https://t2.metgis.com/weathermap-world_t51.json",
        "https://t3.metgis.com/weathermap-world_t51.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t51/style.json",
        "https://t2.metgis.com/weathermap-world_t51/style.json",
        "https://t3.metgis.com/weathermap-world_t51/style.json"
      ],
      "timestamp": "2025-02-13T21:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t54/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t54/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t54/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t54.json",
        "https://t2.metgis.com/weathermap-world_t54.json",
        "https://t3.metgis.com/weathermap-world_t54.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t54/style.json",
        "https://t2.metgis.com/weathermap-world_t54/style.json",
        "https://t3.metgis.com/weathermap-world_t54/style.json"
      ],
      "timestamp": "2025-02-14T00:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t57/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t57/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t57/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t57.json",
        "https://t2.metgis.com/weathermap-world_t57.json",
        "https://t3.metgis.com/weathermap-world_t57.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t57/style.json",
        "https://t2.metgis.com/weathermap-world_t57/style.json",
        "https://t3.metgis.com/weathermap-world_t57/style.json"
      ],
      "timestamp": "2025-02-14T03:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t60/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t60/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t60/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t60.json",
        "https://t2.metgis.com/weathermap-world_t60.json",
        "https://t3.metgis.com/weathermap-world_t60.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t60/style.json",
        "https://t2.metgis.com/weathermap-world_t60/style.json",
        "https://t3.metgis.com/weathermap-world_t60/style.json"
      ],
      "timestamp": "2025-02-14T06:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t63/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t63/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t63/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t63.json",
        "https://t2.metgis.com/weathermap-world_t63.json",
        "https://t3.metgis.com/weathermap-world_t63.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t63/style.json",
        "https://t2.metgis.com/weathermap-world_t63/style.json",
        "https://t3.metgis.com/weathermap-world_t63/style.json"
      ],
      "timestamp": "2025-02-14T09:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t66/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t66/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t66/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t66.json",
        "https://t2.metgis.com/weathermap-world_t66.json",
        "https://t3.metgis.com/weathermap-world_t66.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t66/style.json",
        "https://t2.metgis.com/weathermap-world_t66/style.json",
        "https://t3.metgis.com/weathermap-world_t66/style.json"
      ],
      "timestamp": "2025-02-14T12:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t69/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t69/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t69/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t69.json",
        "https://t2.metgis.com/weathermap-world_t69.json",
        "https://t3.metgis.com/weathermap-world_t69.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t69/style.json",
        "https://t2.metgis.com/weathermap-world_t69/style.json",
        "https://t3.metgis.com/weathermap-world_t69/style.json"
      ],
      "timestamp": "2025-02-14T15:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t72/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t72/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t72/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t72.json",
        "https://t2.metgis.com/weathermap-world_t72.json",
        "https://t3.metgis.com/weathermap-world_t72.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t72/style.json",
        "https://t2.metgis.com/weathermap-world_t72/style.json",
        "https://t3.metgis.com/weathermap-world_t72/style.json"
      ],
      "timestamp": "2025-02-14T18:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t75/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t75/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t75/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t75.json",
        "https://t2.metgis.com/weathermap-world_t75.json",
        "https://t3.metgis.com/weathermap-world_t75.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t75/style.json",
        "https://t2.metgis.com/weathermap-world_t75/style.json",
        "https://t3.metgis.com/weathermap-world_t75/style.json"
      ],
      "timestamp": "2025-02-14T21:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t78/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t78/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t78/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t78.json",
        "https://t2.metgis.com/weathermap-world_t78.json",
        "https://t3.metgis.com/weathermap-world_t78.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t78/style.json",
        "https://t2.metgis.com/weathermap-world_t78/style.json",
        "https://t3.metgis.com/weathermap-world_t78/style.json"
      ],
      "timestamp": "2025-02-15T00:00:00.000Z"
    },
    {
      "vector": [
        "https://t1.metgis.com/weathermap-world_t81/{z}/{x}/{y}.pbf",
        "https://t2.metgis.com/weathermap-world_t81/{z}/{x}/{y}.pbf",
        "https://t3.metgis.com/weathermap-world_t81/{z}/{x}/{y}.pbf"
      ],
      "tileJson": [
        "https://t1.metgis.com/weathermap-world_t81.json",
        "https://t2.metgis.com/weathermap-world_t81.json",
        "https://t3.metgis.com/weathermap-world_t81.json"
      ],
      "glStyle": [
        "https://t1.metgis.com/weathermap-world_t81/style.json",
        "https://t2.metgis.com/weathermap-world_t81/style.json",
        "https://t3.metgis.com/weathermap-world_t81/style.json"
      ],
      "timestamp": "2025-02-15T03:00:00.000Z"
    }
  ],
  "projection": "EPSG:3857",
  "bbox": "-90.0,-180.0,90.0,180.0",
  "timeStep": 3,
  "timeStepUnit": "h",
  "timeStepNumber": 25,
  "attribution": "Weather Forecast &copy; <a title='MetGIS Professional Weather Service' href='http://www.metgis.com/' target='_blank'>MetGIS</a>",
  "parameters": {
    "weathermap": {
      "parameterName": "Cloudiness, Precipitation and fresh Snow"
    }
  }
}
```

</details>

<details>
  <summary>Sample style for snow maps</summary>
{ 
  id: 'snow_cover', 
  type: 'fill', 
  source: 'snowmap', 
  'source-layer': 'snow', 
  paint: { 
    'fill-color': '#0099FF', 
    'fill-opacity': 0.8, 
    'fill-outline-color': 'rgba(0, 0, 0, 1)' 
  } 
}
</details>

## Hist Service

The hist service returns historical weather data for the requested date and location.
To get historical weather data pass longitude (lon) and latitude (lat) and time (yyyymmdd) as request parameters (?lon=12&lat=45&time=20230101).

<details>
  <summary>A response value will look like this.</summary>

```json
[
        {
          "@context": "https://auroralh2020.github.io/auroral-ontology-contexts/adapters/context.json",
          "@type": "https://auroral.iot.linkeddata.es/def/adapters#Temperature",
          "saref:relatesToMeasurement": [
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 2.2,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T00:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 1,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T01:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0.9,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T02:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 1,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T03:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 1.5,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T04:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 1.9,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T05:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 2.1,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T06:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.2,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T07:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.1,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T08:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.5,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T09:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.5,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T10:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.3,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T11:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 4,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T12:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 5,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T13:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 5.2,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T14:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 4.6,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T15:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.9,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T16:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.7,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T17:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.4,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T18:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.4,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T19:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.4,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T20:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.7,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T21:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 4,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T22:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 3.8,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degreeCelsius",
              "saref:hasTimeStamp": "2024-01-01T23:00:00Z"
            }
          ]
        },
        {
          "@context": "https://auroralh2020.github.io/auroral-ontology-contexts/adapters/context.json",
          "@type": "https://auroral.iot.linkeddata.es/def/adapters#AmountPrecipitation",
          "saref:relatesToMeasurement": [
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0.7,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T00:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 1.2,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T01:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 1.2,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T02:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0.8,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T03:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 1.3,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T04:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 1.1,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T05:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0.4,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T06:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T07:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T08:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T09:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T10:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T11:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T12:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T13:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T14:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T15:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T16:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T17:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T18:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T19:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T20:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T21:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T22:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 0,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/millimetre",
              "saref:hasTimeStamp": "2024-01-01T23:00:00Z"
            }
          ]
        },
        {
          "@context": "https://auroralh2020.github.io/auroral-ontology-contexts/adapters/context.json",
          "@type": "https://auroral.iot.linkeddata.es/def/adapters#WindSpeed",
          "saref:relatesToMeasurement": [
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 14,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T00:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 13,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T01:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12.2,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T02:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12.2,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T03:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 11.4,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T04:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 9.2,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T05:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 10,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T06:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 9,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T07:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 10,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T08:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T09:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 14,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T10:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 14.3,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T11:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 15.1,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T12:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 14.1,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T13:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 15,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T14:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 14,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T15:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T16:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T17:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T18:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T19:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 11,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T20:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T21:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 12,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T22:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 11,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/kilometrePerHour",
              "saref:hasTimeStamp": "2024-01-01T23:00:00Z"
            }
          ]
        },
        {
          "@context": "https://auroralh2020.github.io/auroral-ontology-contexts/adapters/context.json",
          "@type": "https://auroral.iot.linkeddata.es/def/adapters#RelativeHumidity",
          "saref:relatesToMeasurement": [
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 93,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T00:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 95,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T01:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 95,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T02:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 95,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T03:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 96,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T04:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 96,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T05:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 91,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T06:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 76,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T07:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 69,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T08:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 67,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T09:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 71,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T10:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 74,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T11:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 71,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T12:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 70,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T13:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 70,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T14:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 72,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T15:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 74,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T16:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 69,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T17:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 64,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T18:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 62,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T19:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 61,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T20:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 61,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T21:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 60,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T22:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 57,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/percentage",
              "saref:hasTimeStamp": "2024-01-01T23:00:00Z"
            }
          ]
        },
        {
          "@context": "https://auroralh2020.github.io/auroral-ontology-contexts/adapters/context.json",
          "@type": "https://auroral.iot.linkeddata.es/def/adapters#WindDirection",
          "saref:relatesToMeasurement": [
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T00:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 274,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T01:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 279,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T02:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 279,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T03:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 285,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T04:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 282,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T05:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 275,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T06:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T07:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T08:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T09:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 274,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T10:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 282,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T11:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 277,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T12:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 278,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T13:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 273,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T14:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 274,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T15:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 274,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T16:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T17:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T18:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T19:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T20:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T21:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T22:00:00Z"
            },
            {
              "@type": "saref:Measurement",
              "saref:hasValue": 90,
              "saref:isMeasuredIn": "http://www.ontology-of-units-of-measure.org/resource/om-2/degree",
              "saref:hasTimeStamp": "2024-01-01T23:00:00Z"
            }
          ]
        }
      ]



```
</details>

As can bee seen a response contains historical temperature, wind, precipitation, and humidity data for the requested date and location.



## Topo Service

The Topo service return a access url for the Topo-Api. (no request param required)
This Api serves DEM as encoded RGB pngs. These pngs can be used to display 3d terrain, with libraries like mapbox, mablibre-gl.
A docker-ised Demo is provided in this repo, for instructions see **Demo Application**.


# Demo Application

To see how the weather and topo layers can be used in an application you can launch a demo webserver locally on
your machine. To do that you need **docker** and **docker-compose** installed.
If you haven't docker installed please read the official [documentation](https://docs.docker.com/engine/install/) for installation instructions.

Before running the container paste your API-KEY in the docker-compose.yml.

```yaml
environment:
  - API_KEY=<paste API KEY HERE>
```

Start the container with `docker-compose up`.
Now you can open the [demopages](http://localhost:80) in any browser.
If you want to display terrain that is rendered with the data of the topo tiles, press the peak symbol in the top right corner.
