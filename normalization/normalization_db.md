```python
# imports:

import pandas as pd
from getpass import getpass
from sqlalchemy import create_engine, text
from sqlalchemy.orm import Session
import psycopg

```


```python
# check_in:

pw = getpass('Please enter password: ')
connection_url = f'postgresql://postgres:{pw}@localhost:5432/nasa_exoplanets'
engine = create_engine(connection_url)

# check connection:
with engine.connect() as conn_alchemy:
    print("SQLAlchemy connected!")


# connection psycopg:
pw = getpass('Please enter password: ')
with psycopg.connect(
    host='localhost',
    port='5432',
    user='postgres',
    password=pw,
    dbname='nasa_exoplanets',
    autocommit=True
) as connection:
    print("psycopg connected!")
```

    SQLAlchemy connected!
    psycopg connected!
    


```python
sel_stmt = '''
    SELECT DISTINCT
	    n.planet_name,
	    o.planet_type,
	    n.host_star_name,
	    n.spectral_type,
	    o.distance,
	    n.discovery_year,
	    n.discovery_method,
	    n.orbital_period_days,
	    o.mass_multiplier,
	    o.mass_wrt,
	    n.planet_mass_earth_mass,
	    n.planet_mass_jupiter_mass,
	    o.radius_multiplier,
	    o.radius_wrt,
	    n.planet_radius_earth_radius,
	    n.planet_radius_jupiter_radius
    FROM new_data AS n
    INNER JOIN old_data AS o ON n.planet_name = o.name'''

complete_df = pd.read_sql(sel_stmt, engine)
```


```python
complete_df.info()
```

    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 5100 entries, 0 to 5099
    Data columns (total 16 columns):
     #   Column                        Non-Null Count  Dtype  
    ---  ------                        --------------  -----  
     0   planet_name                   5100 non-null   object 
     1   planet_type                   5100 non-null   object 
     2   host_star_name                5100 non-null   object 
     3   spectral_type                 1720 non-null   object 
     4   distance                      5084 non-null   float64
     5   discovery_year                5100 non-null   int64  
     6   discovery_method              5100 non-null   object 
     7   orbital_period_days           4918 non-null   float64
     8   mass_multiplier               5078 non-null   float64
     9   mass_wrt                      5078 non-null   object 
     10  planet_mass_earth_mass        5075 non-null   float64
     11  planet_mass_jupiter_mass      5075 non-null   float64
     12  radius_multiplier             5085 non-null   float64
     13  radius_wrt                    5085 non-null   object 
     14  planet_radius_earth_radius    5084 non-null   float64
     15  planet_radius_jupiter_radius  5084 non-null   float64
    dtypes: float64(8), int64(1), object(7)
    memory usage: 637.6+ KB
    


```python
complete_df.to_sql('complete_data', engine)
```




    100




```python
sel_values = '''
    SELECT
        f.planet_id,
        f.star_id,
	    f.spectral_type,
	    f.distance,
	    f.discovery_year,
	    f.orbital_period_days,
	    f.mass_multiplier,
	    f.mass_wrt,
	    f.radius_multiplier,
	    f.radius_wrt
	FROM finalshape_fulldata AS f'''

values_df = pd.read_sql(sel_values, engine)
```


```python
values_df.to_sql('values', engine)
```




    142




```python
stars = '''
    SELECT
    	DISTINCT(host_star_name),
    	star_id,
    	spectral_type
	FROM finalshape_fulldata'''

stars_df = pd.read_sql(stars, engine)
stars_df
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>host_star_name</th>
      <th>star_id</th>
      <th>spectral_type</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Kepler-1000</td>
      <td>446</td>
      <td>None</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Kepler-1699</td>
      <td>1288</td>
      <td>None</td>
    </tr>
    <tr>
      <th>2</th>
      <td>EPIC 212297394</td>
      <td>1725</td>
      <td>None</td>
    </tr>
    <tr>
      <th>3</th>
      <td>WASP-138</td>
      <td>2381</td>
      <td>None</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Kepler-1367</td>
      <td>2541</td>
      <td>None</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>3858</th>
      <td>Kepler-759</td>
      <td>3147</td>
      <td>None</td>
    </tr>
    <tr>
      <th>3859</th>
      <td>BD-13 2130</td>
      <td>800</td>
      <td>G5 IV/V</td>
    </tr>
    <tr>
      <th>3860</th>
      <td>WASP-164</td>
      <td>3224</td>
      <td>G2 V</td>
    </tr>
    <tr>
      <th>3861</th>
      <td>Kepler-1238</td>
      <td>2870</td>
      <td>None</td>
    </tr>
    <tr>
      <th>3862</th>
      <td>Kepler-1775</td>
      <td>2910</td>
      <td>None</td>
    </tr>
  </tbody>
</table>
<p>3863 rows × 3 columns</p>
</div>




```python
stars_df.to_sql('stars', engine)
```




    948




```python
sel_stmt_cd2 = '''
    SELECT DISTINCT
	    c.planet_id,
	    c.planet_name,
	    c.planet_type,
	    c.host_star_name,
	    s.star_id,
	    c.spectral_type,
	    c.mass_multiplier,
	    c.mass_wrt,
	    c.orbital_period_days,
	    c.radius_wrt,
	    c.radius_multiplier,
	    c.distance,
	    c.discovery_year
    FROM complete_data AS c
    JOIN stars AS s USING (host_star_name)
    GROUP BY c.planet_id,
         c.planet_name,
         c.planet_type,
         c.host_star_name,
         s.star_id,
         c.spectral_type,
         c.mass_multiplier,
         c.mass_wrt,
         c.orbital_period_days,
         c.radius_wrt,
         c.radius_multiplier,
         c.distance,
         c.discovery_year;'''

complete_df2 = pd.read_sql(sel_stmt_cd2, engine)
```


```python
complete_df2
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>planet_id</th>
      <th>planet_name</th>
      <th>planet_type</th>
      <th>host_star_name</th>
      <th>star_id</th>
      <th>spectral_type</th>
      <th>mass_multiplier</th>
      <th>mass_wrt</th>
      <th>orbital_period_days</th>
      <th>radius_wrt</th>
      <th>radius_multiplier</th>
      <th>distance</th>
      <th>discovery_year</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>3362</td>
      <td>Kepler-1770 b</td>
      <td>Neptune-like</td>
      <td>Kepler-1770</td>
      <td>164</td>
      <td>None</td>
      <td>8.45</td>
      <td>Earth</td>
      <td>16.841900</td>
      <td>Jupiter</td>
      <td>0.253</td>
      <td>1902.0</td>
      <td>2021</td>
    </tr>
    <tr>
      <th>1</th>
      <td>3457</td>
      <td>Kepler-1691 b</td>
      <td>Super Earth</td>
      <td>Kepler-1691</td>
      <td>1359</td>
      <td>None</td>
      <td>4.02</td>
      <td>Earth</td>
      <td>3.848200</td>
      <td>Earth</td>
      <td>1.835</td>
      <td>4135.0</td>
      <td>2020</td>
    </tr>
    <tr>
      <th>2</th>
      <td>428</td>
      <td>Kepler-1943 b</td>
      <td>Super Earth</td>
      <td>Kepler-1943</td>
      <td>1329</td>
      <td>None</td>
      <td>3.02</td>
      <td>Earth</td>
      <td>4.850180</td>
      <td>Earth</td>
      <td>1.549</td>
      <td>3277.0</td>
      <td>2021</td>
    </tr>
    <tr>
      <th>3</th>
      <td>3855</td>
      <td>Kepler-1000 b</td>
      <td>Neptune-like</td>
      <td>Kepler-1000</td>
      <td>446</td>
      <td>None</td>
      <td>20.30</td>
      <td>Earth</td>
      <td>120.018127</td>
      <td>Jupiter</td>
      <td>0.425</td>
      <td>3639.0</td>
      <td>2016</td>
    </tr>
    <tr>
      <th>4</th>
      <td>51</td>
      <td>Kepler-1043 b</td>
      <td>Neptune-like</td>
      <td>Kepler-1043</td>
      <td>2703</td>
      <td>None</td>
      <td>7.04</td>
      <td>Earth</td>
      <td>38.505340</td>
      <td>Jupiter</td>
      <td>0.227</td>
      <td>2947.0</td>
      <td>2016</td>
    </tr>
    <tr>
      <th>...</th>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
      <td>...</td>
    </tr>
    <tr>
      <th>5137</th>
      <td>3995</td>
      <td>Kepler-680 b</td>
      <td>Neptune-like</td>
      <td>Kepler-680</td>
      <td>1504</td>
      <td>None</td>
      <td>6.44</td>
      <td>Earth</td>
      <td>3.689926</td>
      <td>Jupiter</td>
      <td>0.216</td>
      <td>4868.0</td>
      <td>2016</td>
    </tr>
    <tr>
      <th>5138</th>
      <td>3718</td>
      <td>Kepler-299 b</td>
      <td>Super Earth</td>
      <td>Kepler-299</td>
      <td>3508</td>
      <td>None</td>
      <td>2.30</td>
      <td>Earth</td>
      <td>2.927128</td>
      <td>Earth</td>
      <td>1.320</td>
      <td>3432.0</td>
      <td>2014</td>
    </tr>
    <tr>
      <th>5139</th>
      <td>4490</td>
      <td>K2-384 e</td>
      <td>Super Earth</td>
      <td>K2-384</td>
      <td>1071</td>
      <td>M4 V</td>
      <td>2.37</td>
      <td>Earth</td>
      <td>9.715043</td>
      <td>Earth</td>
      <td>1.345</td>
      <td>270.0</td>
      <td>2022</td>
    </tr>
    <tr>
      <th>5140</th>
      <td>3346</td>
      <td>Kepler-968 c</td>
      <td>Super Earth</td>
      <td>Kepler-968</td>
      <td>3729</td>
      <td>None</td>
      <td>3.50</td>
      <td>Earth</td>
      <td>5.709405</td>
      <td>Earth</td>
      <td>1.690</td>
      <td>947.0</td>
      <td>2016</td>
    </tr>
    <tr>
      <th>5141</th>
      <td>1671</td>
      <td>NGTS-4 b</td>
      <td>Neptune-like</td>
      <td>NGTS-4</td>
      <td>954</td>
      <td>None</td>
      <td>20.60</td>
      <td>Earth</td>
      <td>1.337351</td>
      <td>Jupiter</td>
      <td>0.284</td>
      <td>915.0</td>
      <td>2019</td>
    </tr>
  </tbody>
</table>
<p>5142 rows × 13 columns</p>
</div>




```python
complete_df2.to_sql('finalshape_fulldata', engine)
```




    142




```python
sel_stmt_pl_types = '''
    SELECT
	    planet_id,
	    planet_name,
	    planet_type,
	    star_id
    FROM finalshape_fulldata
    GROUP BY planet_id
    ORDER BY planet_id;'''

pl_types = pd.read_sql(sel_stmt_pl_types, engine)
pl_types.to_sql('planets', engine)
```




    142




```python
sel_stmt_pl_type1 = '''
    SELECT
	    planet_id,
	    planet_name,
	    planet_type,
	    star_id
    FROM finalshape_fulldata
    WHERE planet_type = 'Terrestrial'
    GROUP BY planet_id
    ORDER BY planet_id;'''

pl_type1 = pd.read_sql(sel_stmt_pl_type1, engine)
pl_type1.to_sql('terrestrial planets', engine)
```




    193




```python
sel_stmt_pl_type2 = '''
    SELECT
	    planet_id,
	    planet_name,
	    planet_type,
	    star_id
    FROM finalshape_fulldata
    WHERE planet_type = 'Super Earth'
    GROUP BY planet_id
    ORDER BY planet_id;'''

pl_type2 = pd.read_sql(sel_stmt_pl_type2, engine)
pl_type2.to_sql('super earth planets', engine)
```




    588




```python
sel_stmt_pl_type3 = '''
    SELECT
	    planet_id,
	    planet_name,
	    planet_type,
	    star_id
    FROM finalshape_fulldata
    WHERE planet_type = 'Gas Giant'
    GROUP BY planet_id
    ORDER BY planet_id;'''

pl_type3 = pd.read_sql(sel_stmt_pl_type3, engine)
pl_type3.to_sql('gas giant planets', engine)
```




    539




```python
sel_stmt_pl_type4 = '''
    SELECT
	    planet_id,
	    planet_name,
	    planet_type,
	    star_id
    FROM finalshape_fulldata
    WHERE planet_type = 'Neptune-like'
    GROUP BY planet_id
    ORDER BY planet_id;'''

pl_type4 = pd.read_sql(sel_stmt_pl_type4, engine)
pl_type4.to_sql('neptune-like planets', engine)
```




    817




```python
sel_stmt_pl_type5 = '''
    SELECT
	    planet_id,
	    planet_name,
	    planet_type,
	    star_id
    FROM finalshape_fulldata
    WHERE planet_type = 'Unknown'
    GROUP BY planet_id
    ORDER BY planet_id;'''

pl_type5 = pd.read_sql(sel_stmt_pl_type5, engine)
pl_type5.to_sql('unknown planets', engine)
```




    5


